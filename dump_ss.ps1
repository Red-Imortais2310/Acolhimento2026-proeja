$ssContent = Get-Content "extract_temp/xl/sharedStrings.xml" -Raw -Encoding utf8
$ssMatches = [regex]::Matches($ssContent, '<si>(.*?)</si>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
$i = 0
foreach ($m in $ssMatches) {
    if ($m.Groups[1].Value -match '<t>(.*?)</t>') {
        Write-Output "$i|$($matches[1])"
    }
    $i++
}
