$zipPath = "docentes.xlsx"
$destPath = "extract_temp"
if (Test-Path $destPath) { Remove-Item -Recurse -Force $destPath }
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $destPath)

[xml]$ssXml = Get-Content "$destPath/xl/sharedStrings.xml"
$ss = @()
foreach ($si in $ssXml.sst.si) {
    if ($si.t) { $ss += $si.t.'#text' }
    elseif ($si.r) {
        $t = ""
        foreach ($part in $si.r) { $t += $part.t.'#text' }
        $ss += $t
    }
    else { $ss += "" }
}

[xml]$relsXml = Get-Content "$destPath/xl/worksheets/_rels/sheet1.xml.rels"
$links = @{}
foreach ($rel in $relsXml.Relationships.Relationship) {
    if ($rel.Id -and $rel.Target) { $links[$rel.Id] = $rel.Target }
}

[xml]$sheetXml = Get-Content "$destPath/xl/worksheets/sheet1.xml"
$cellToRid = @{}
foreach ($hl in $sheetXml.worksheet.hyperlinks.hyperlink) {
    $cellToRid[$hl.ref] = $hl.id
}

$mapping = @{}
foreach ($row in $sheetXml.worksheet.sheetData.row) {
    $rNum = $row.r
    $name = ""
    $lattes = ""
    foreach ($c in $row.c) {
        $val = ""
        if ($c.v) {
            if ($c.t -eq "s") { $val = $ss[[int]$c.v] }
            else { $val = $c.v }
        }
        if ($c.r -match "^A$rNum$") { $name = $val }
        if ($cellToRid.ContainsKey($c.r)) { $lattes = $links[$cellToRid[$c.r]] }
    }
    if ($name -and $lattes) {
        Write-Output "FOUND: $name -> $lattes"
    }
}
