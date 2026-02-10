# Extrai Lattes do arquivo Excel
[xml]$sheet = Get-Content "extract_temp/xl/worksheets/sheet1.xml"
[xml]$rels = Get-Content "extract_temp/xl/worksheets/_rels/sheet1.xml.rels"
[xml]$ss = Get-Content "extract_temp/xl/sharedStrings.xml"

# Mapa de links
$linksMap = @{}
foreach ($rel in $rels.Relationships.Relationship) {
    $linksMap[$rel.Id] = $rel.Target
}

# Mapa de valores de célula
$cellVals = @{}
$idx = 0
foreach ($si in $ss.sst.si) {
    if ($si.t) {
        $cellVals[$idx] = $si.t.'#text'
    }
    else {
        $cellVals[$idx] = ""
    }
    $idx++
}

# Hiperlinks
$hyperlinks = @{}
foreach ($hl in $sheet.worksheet.hyperlinks.hyperlink) {
    $hyperlinks[$hl.ref] = $linksMap[$hl.id]
}

# Extrai nomes e lattes
$results = @()
foreach ($row in $sheet.worksheet.sheetData.row) {
    $colA = $null
    $urlFound = $null
    
    foreach ($cell in $row.c) {
        if ($cell.r -match '^A\d+$') {
            if ($cell.t -eq 's') {
                $colA = $cellVals[[int]$cell.v]
            }
        }
        if ($hyperlinks[$cell.r]) {
            $urlFound = $hyperlinks[$cell.r]
        }
    }
    
    if ($colA -and $urlFound -and $colA -ne 'DOCENTE' -and $urlFound -like '*lattes*') {
        $results += "$colA | $urlFound"
    }
}

$results | Out-File "extracted_lattes.txt" -Encoding utf8
Write-Output "Extraído $(($results | Measure-Object).Count) Lattes"
$results | Select-Object -First 30
