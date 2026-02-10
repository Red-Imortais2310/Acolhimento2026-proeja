# Script para mapear Lattes com nomes dos professores
[xml]$sheet = Get-Content "extract_temp/xl/worksheets/sheet1.xml"
[xml]$rels = Get-Content "extract_temp/xl/worksheets/_rels/sheet1.xml.rels"
[xml]$ss = Get-Content "extract_temp/xl/sharedStrings.xml"

# Mapa de hiperlinks: Cell -> Relationship ID
$hyperlinks = @{}
foreach ($hl in $sheet.worksheet.hyperlinks.hyperlink) {
    $hyperlinks[$hl.ref] = $hl.id
}

# Mapa de Relationship IDs -> URLs
$linksMap = @{}
$rels.Relationships.Relationship | Where-Object { $_.Target -like "*lattes*" } | ForEach-Object {
    $linksMap[$_.Id] = $_.Target
}

# Mapa de valores de célula
$cellValues = @{}
$idx = 0
foreach ($si in $ss.sst.si) {
    if ($si.t) {
        $cellValues[$idx] = $si.t.'#text'
    }
    elseif ($si.r) {
        $text = ""
        foreach ($r in $si.r) {
            if ($r.t.'#text') { $text += $r.t.'#text' }
            elseif ($r.t) { $text += $r.t }
        }
        $cellValues[$idx] = $text
    }
    else {
        $cellValues[$idx] = ""
    }
    $idx++
}

# Extrai nomes e Lattes
$results = @()
foreach ($row in $sheet.worksheet.sheetData.row) {
    $colA = $null  # Nome
    $colE = $null  # Lattes URL
    
    foreach ($cell in $row.c) {
        # Coluna A (nomes)
        if ($cell.r -match '^A\d+') {
            if ($cell.t -eq 's') {
                $colA = $cellValues[[int]$cell.v]
            }
            elseif ($cell.v) {
                $colA = $cell.v
            }
        }
        
        # Coluna E (Lattes) - procura por hiperlink
        if ($cell.r -match '^E\d+' -and $hyperlinks[$cell.r]) {
            $rId = $hyperlinks[$cell.r]
            if ($linksMap[$rId]) {
                $colE = $linksMap[$rId]
            }
        }
    }
    
    if ($colA -and $colE -and $colA -ne 'DOCENTE' -and $colE -like "*lattes*") {
        $results += "$colA|$colE"
    }
}

$results | Out-File "mapeamento_nomes_lattes.txt" -Encoding utf8
Write-Host "Mapeamento criado: mapeamento_nomes_lattes.txt"
Write-Host "Total: $($results.Count) professores com Lattes"
$results | Select-Object -First 20 | ForEach-Object { Write-Host $_ }
