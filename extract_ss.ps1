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
$ss | Out-File "strings.txt" -Encoding utf8
