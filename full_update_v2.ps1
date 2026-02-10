$zipPath = "docentes.xlsx"
$destPath = "extract_temp"
if (Test-Path "docentes.xlsx" -eq $false) {
    Invoke-WebRequest -Uri 'https://docs.google.com/spreadsheets/d/1_1Eyuh4w5su93Ip2FKSEKyWgnqLDtOL-fGXuFSS2NKU/export?format=xlsx' -OutFile 'docentes.xlsx'
}
if (Test-Path $destPath) { Remove-Item -Recurse -Force $destPath }
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $destPath)

# 1. Extract Shared Strings
$ssContent = Get-Content "$destPath/xl/sharedStrings.xml" -Raw -Encoding utf8
$ssMatches = [regex]::Matches($ssContent, '<si>(.*?)</si>')
$ss = @()
foreach ($m in $ssMatches) {
    if ($m.Groups[1].Value -match '<t>(.*?)</t>') { $ss += $matches[1] }
    else { $ss += "" }
}

# 2. Extract Link Mapping
$relsContent = Get-Content "$destPath/xl/worksheets/_rels/sheet1.xml.rels" -Raw -Encoding utf8
$relMatches = [regex]::Matches($relsContent, '<Relationship Id="([^"]+)" [^>]*Target="([^"]+)"')
$links = @{}
foreach ($m in $relMatches) { $links[$m.Groups[1].Value] = $m.Groups[2].Value }

$sheetContent = Get-Content "$destPath/xl/worksheets/sheet1.xml" -Raw -Encoding utf8
$hlMatches = [regex]::Matches($sheetContent, '<hyperlink ref="([^"]+)" [^>]*r:id="([^"]+)"')
$cellToRid = @{}
foreach ($m in $hlMatches) { $cellToRid[$m.Groups[1].Value] = $m.Groups[2].Value }

$rowMatches = [regex]::Matches($sheetContent, '<row r="(\d+)".*?>(.*?)</row>')
$mapping = @{}
foreach ($rm in $rowMatches) {
    $rNum = $rm.Groups[1].Value
    $rowInner = $rm.Groups[2].Value
    $name = ""; $lattes = ""
    if ($rowInner -match '<c r="A' + $rNum + '" t="s"><v>(\d+)</v>') {
        $idx = [int]$matches[1]
        if ($idx -lt $ss.Count) { $name = $ss[$idx] }
    }
    foreach ($cellRef in $cellToRid.Keys) {
        if ($cellRef -match "^[A-Z]+$rNum$") {
            $url = $links[$cellToRid[$cellRef]]
            if ($url -like "*lattes*" -or $url -like "*buscatextual*") { $lattes = $url; break }
        }
    }
    if ($name -and $lattes) { $mapping[$name.Trim().ToUpper()] = $lattes }
}

# 3. Update HTML Smartly
$html = Get-Content "index.html" -Raw -Encoding utf8
$newHtml = $html

# Find all blocks that likely represent a professor card (including those with carousel-slide class)
$cardMatches = [regex]::Matches($html, '(?is)<div class="(professor-card|carousel-slide)".*?data-name="([^"]+)"[^>]*data-lattes="#"')

foreach ($m in $cardMatches) {
    $fullBlock = $m.Value
    $name = $m.Groups[2].Value.Trim().ToUpper()
    
    if ($mapping.ContainsKey($name)) {
        $url = $mapping[$name]
        $newBlock = $fullBlock -replace 'data-lattes="#"', ('data-lattes="' + $url + '"')
        
        # If it's a numeric Lattes ID, also update the photo if it's the default logo
        if ($url -match 'lattes.cnpq.br/(\d+)') {
            $id = $matches[1]
            if ($newBlock -match 'src="imagens/Ifsp_logo.jpg"') {
                $newBlock = $newBlock -replace 'src="imagens/Ifsp_logo.jpg"', ('src="http://servicosweb.cnpq.br/cvlattesweb/foto.do?id=' + $id + '"')
            }
        }
        
        $newHtml = $newHtml.Replace($fullBlock, $newBlock)
    }
}

$newHtml | Set-Content -Path "index.html" -Encoding utf8

# Cleanup
Remove-Item -Recurse -Force $destPath
Remove-Item "docentes.xlsx"
