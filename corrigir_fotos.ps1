$html = [System.IO.File]::ReadAllText('index.html', [System.Text.Encoding]::UTF8)

$correcoes = @(
    @{ nome = "Ivaldo Marques Batista"; foto = "imagens/Ivaldo_Informática.jpeg" },
    @{ nome = "Sérgio Henrique Rocha Batista"; foto = "imagens/Sérgio_Inglês.png" },
    @{ nome = "Ricardo Sorgon Pires"; foto = "imagens/ricardo.gif" },
    @{ nome = "Paulo Mannini"; foto = "imagens/paulo.gif" },
    @{ nome = "Giovane Marçal De Oliveira"; foto = "imagens/giovanne.gif" },
    @{ nome = "Fernando Dias De Oliveira"; foto = "imagens/fernando.gif" },
    @{ nome = "Rita De Cássia Demarchi"; foto = "imagens/rita.gif" },
    @{ nome = "Nelson Da Silva Paz"; foto = "imagens/Nelson.jpeg" }
)

$alteradas = 0
foreach ($correcao in $correcoes) {
    $padrao = '(data-name="' + [regex]::Escape($correcao.nome) + '"[^>]*>\s*<div class="professor-image"><img src=")imagens/Ifsp_logo\.jpg'
    
    if ($html -match $padrao) {
        $html = $html -replace $padrao, ('$1' + $correcao.foto)
        $alteradas++
        Write-Host "OK: $($correcao.nome)" -ForegroundColor Green
    }
}

[System.IO.File]::WriteAllText('index.html', $html, [System.Text.Encoding]::UTF8)
Write-Host "`nTotal: $alteradas fotos corrigidas!" -ForegroundColor Green
