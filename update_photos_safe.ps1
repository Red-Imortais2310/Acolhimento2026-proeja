$html = Get-Content "index.html" -Raw -Encoding utf8

# We find each professor-card block
$blocks = [regex]::Matches($html, '(?s)<div class="professor-card".*?</div>\s*</div>')

$newHtml = $html
foreach ($m in $blocks) {
    $block = $m.Value
    
    # Check if this block has the default logo and a valid 16-digit Lattes ID
    if ($block -match 'data-lattes="http://lattes.cnpq.br/(\d+)"' -and $block -match 'src="imagens/Ifsp_logo.jpg"') {
        $id = $matches[1]
        
        # Replace the image src within THIS block only
        $newBlock = $block -replace 'src="imagens/Ifsp_logo.jpg"', ('src="http://servicosweb.cnpq.br/cvlattesweb/foto.do?id=' + $id + '"')
        
        # Escape the original block for a safe replacement in the main HTML
        $escapedBlock = [regex]::Escape($block)
        $newHtml = [regex]::Replace($newHtml, $escapedBlock, $newBlock)
    }
}

$newHtml | Set-Content -Path "index.html" -Encoding utf8
