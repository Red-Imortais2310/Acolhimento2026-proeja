$ss = Get-Content "extract_temp/xl/sharedStrings.xml" -Raw -Encoding utf8
$matches = [regex]::Matches($ss, '<t>(.*?)</t>')
$strings = @()
foreach ($m in $matches) { $strings += $m.Groups[1].Value }

$rels = Get-Content "extract_temp/xl/worksheets/_rels/sheet1.xml.rels" -Raw -Encoding utf8
$relMatches = [regex]::Matches($rels, '<Relationship Id="([^"]+)" [^>]*Target="([^"]+)"')
$links = @{}
foreach ($m in $relMatches) { $links[$m.Groups[1].Value] = $m.Groups[2].Value }

$sheet = Get-Content "extract_temp/xl/worksheets/sheet1.xml" -Raw -Encoding utf8
$hlMatches = [regex]::Matches($sheet, '<hyperlink ref="([^"]+)" [^>]*r:id="([^"]+)"')
$cellToRid = @{}
foreach ($m in $hlMatches) { $cellToRid[$m.Groups[1].Value] = $m.Groups[2].Value }

$rowMatches = [regex]::Matches($sheet, '<row r="(\d+)".*?>(.*?)</row>')
$results = @()
foreach ($rm in $rowMatches) {
    $rNum = $rm.Groups[1].Value
    $rowInner = $rm.Groups[2].Value
    $name = ""; $lattes = ""
    if ($rowInner -match '<c r="A' + $rNum + '" t="s"><v>(\d+)</v>') {
        $idx = [int]$matches[1]
        if ($idx -lt $strings.Count) { $name = $strings[$idx] }
    }
    foreach ($cellRef in $cellToRid.Keys) {
        if ($cellRef -match "^[A-Z]+$rNum$") {
            $url = $links[$cellToRid[$cellRef]]
            if ($url -like "*lattes*" -or $url -like "*buscatextual*") { $lattes = $url; break }
        }
    }
    if ($name -and $lattes) { $results += "$name|$lattes" }
}
$results | Out-File "final_mapping.txt" -Encoding utf8
