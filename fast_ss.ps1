$content = Get-Content "extract_temp/xl/sharedStrings.xml" -Raw -Encoding utf8
$matches = [regex]::Matches($content, '<t>(.*?)</t>')
$sb = New-Object System.Text.StringBuilder
foreach ($m in $matches) {
    [void]$sb.AppendLine($m.Groups[1].Value)
}
$sb.ToString() | Out-File "strings_plain.txt" -Encoding utf8
