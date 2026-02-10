[xml]$ssXml = Get-Content "extract_temp/xl/sharedStrings.xml"
$ss = @()
foreach ($si in $ssXml.sst.si) {
    if ($si.t) {
        $ss += $si.t.'#text'
    }
    elseif ($si.r) {
        $text = ""
        foreach ($r in $si.r) {
            if ($r.t.'#text') { $text += $r.t.'#text' }
            elseif ($r.t) { $text += $r.t }
        }
        $ss += $text
    }
    else {
        $ss += ""
    }
}

[xml]$relsXml = Get-Content "extract_temp/xl/worksheets/_rels/sheet1.xml.rels"
$linksMap = @{}
foreach ($rel in $relsXml.Relationships.Relationship) {
    if ($rel.Id -and $rel.Target) { $linksMap[$rel.Id] = $rel.Target }
}

[xml]$sheetXml = Get-Content "extract_temp/xl/worksheets/sheet1.xml"
$cellToRid = @{}
foreach ($hl in $sheetXml.worksheet.hyperlinks.hyperlink) {
    $cellToRid[$hl.ref] = $hl.id
}

$results = @()
foreach ($row in $sheetXml.worksheet.sheetData.row) {
    $rNum = $row.r
    $name = ""
    $lattes = ""
    foreach ($c in $row.c) {
        if ($c.r -eq "A$rNum") {
            if ($c.t -eq "s") { $name = $ss[[int]$c.v] }
        }
        if ($cellToRid.ContainsKey($c.r)) {
            $url = $linksMap[$cellToRid[$c.r]]
            if ($url -like "*lattes*" -or $url -like "*buscatextual*") { $lattes = $url }
        }
    }
    if ($name -and $lattes -and $name -ne "DOCENTE") {
        $results += "$name|$lattes"
    }
}
$results | Out-File "final_mapping.txt" -Encoding utf8
