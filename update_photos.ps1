$html = Get-Content "index.html" -Raw -Encoding utf8

# Pattern to find professor cards with the default IFSP logo and a Lattes link
# We capture the Lattes ID (16 digits)
$pattern = '(?s)(<div class="professor-card" [^>]*data-lattes="http://lattes.cnpq.br/(\d+)"[^>]*>.*?<img src=")imagens/Ifsp_logo.jpg("[^>]*alt="([^"]+)")'

# Replacement: Use the Lattes photo service URL with the captured ID
$replacement = '$1http://servicosweb.cnpq.br/cvlattesweb/foto.do?id=$2"$3'

$newHtml = [regex]::Replace($html, $pattern, $replacement)

# Also handle cases where data-lattes comes BEFORE onclick or secondary attributes
$pattern2 = '(?s)(<div class="professor-card" [^>]*data-lattes="http://lattes.cnpq.br/(\d+)"[^>]*>.*?<img src=")imagens/Ifsp_logo.jpg("[^>]*>)'
$newHtml = [regex]::Replace($newHtml, $pattern2, '$1http://servicosweb.cnpq.br/cvlattesweb/foto.do?id=$2"$3')

$newHtml | Set-Content -Path "index.html" -Encoding utf8
