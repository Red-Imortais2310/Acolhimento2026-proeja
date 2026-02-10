$zipPath = "docentes.xlsx"
$destPath = "extract_temp"
if (Test-Path $destPath) { Remove-Item -Recurse -Force $destPath }
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $destPath)

# 1. Extract Shared Strings via Regex
$ssContent = Get-Content "$destPath/xl/sharedStrings.xml" -Raw -Encoding utf8
$ssMatches = [regex]::Matches($ssContent, '<si>(.*?)</si>')
$ss = @()
foreach ($m in $ssMatches) {
    if ($m.Groups[1].Value -match '<t>(.*?)</t>') {
        $ss += $matches[1]
    }
    else { $ss += "" }
}

# 2. Extract Relationships via Regex
$relsContent = Get-Content "$destPath/xl/worksheets/_rels/sheet1.xml.rels" -Raw -Encoding utf8
$relMatches = [regex]::Matches($relsContent, '<Relationship Id="([^"]+)" [^>]*Target="([^"]+)"')
$links = @{}
foreach ($m in $relMatches) {
    $links[$m.Groups[1].Value] = $m.Groups[2].Value
}

# 3. Extract Hyperlinks from Sheet via Regex
$sheetContent = Get-Content "$destPath/xl/worksheets/sheet1.xml" -Raw -Encoding utf8
$hlMatches = [regex]::Matches($sheetContent, '<hyperlink ref="([^"]+)" [^>]*r:id="([^"]+)"')
$cellToRid = @{}
foreach ($m in $hlMatches) {
    $cellToRid[$m.Groups[1].Value] = $m.Groups[2].Value
}

# 4. Extract Row Data via Regex
# Find <row r="(\d+)"> blocks
$rowMatches = [regex]::Matches($sheetContent, '<row r="(\d+)".*?>(.*?)</row>')
$mapping = @{}
foreach ($rm in $rowMatches) {
    $rNum = $rm.Groups[1].Value
    $rowInner = $rm.Groups[2].Value
    
    $name = ""
    $lattes = ""
    
    # Find cell A
    if ($rowInner -match '<c r="A' + $rNum + '" t="s"><v>(\d+)</v>') {
        $idx = [int]$matches[1]
        if ($idx -lt $ss.Count) { $name = $ss[$idx] }
    }
    
    # Find Lattes link in row
    # Hyperlink ref could be E, or other columns. Let's find cells that have Rid.
    $lattesCell = ""
    foreach ($cellRef in $cellToRid.Keys) {
        if ($cellRef -match "^[A-Z]+$rNum$") {
            $rid = $cellToRid[$cellRef]
            $url = $links[$rid]
            if ($url -like "*lattes*" -or $url -like "*buscatextual*") {
                $lattes = $url
                break
            }
        }
    }
    
    if ($name -and $lattes -and $name -ne "DOCENTE") {
        $mapping[$name.Trim().ToUpper()] = $lattes
    }
}

# 5. Update index.html
$html = Get-Content "index.html" -Raw -Encoding utf8
$newHtml = $html

foreach ($name in $mapping.Keys) {
    $url = $mapping[$name]
    $escapedName = [regex]::Escape($name)
    $pattern = '(?i)(data-name="' + $escapedName + '")\s+data-lattes="#"'
    $newHtml = [regex]::Replace($newHtml, $pattern, '$1 data-lattes="' + $url + '"')
}

# 6. Apply Photos
# Process each card independently to avoid cross-card matching
$cardMatches = [regex]::Matches($newHtml, '(?is)<div class="professor-card".*?</div>\s*</div>')
foreach ($cm in $cardMatches) {
    $card = $cm.Value
    if ($card -match 'data-lattes="http[^"]+?lattes.cnpq.br/(\d+)"' -and $card -match 'src="(imagens/Ifsp_logo.jpg|http://servicosweb.cnpq.br/cvlattesweb/foto.do\?id=)"') {
        $id = $matches[1]
        $newCard = [regex]::Replace($card, 'src="[^"]+"', 'src="http://servicosweb.cnpq.br/cvlattesweb/foto.do?id=' + $id + '"')
        $newHtml = $newHtml.Replace($card, $newCard)
    }
}

$newHtml | Set-Content -Path "index.html" -Encoding utf8

# Clean up
if (Test-Path $destPath) { Remove-Item -Recurse -Force $destPath }
if (Test-Path "docentes.xlsx") { Remove-Item "docentes.xlsx" }
