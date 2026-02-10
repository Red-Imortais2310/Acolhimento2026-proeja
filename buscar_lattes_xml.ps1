# Script para extrair Lattes do arquivo sharedStrings.xml extraído
# Vamos tentar uma abordagem diferente

# Primeiro, vamos carregar os dados CSV que tem os nomes
$csv = Import-Csv "docentes.csv"

# Mapeamento de nomes para IDs (dos que já estão corretos no HTML)
$lattesMap = @{
    "ADRIANA RODRIGUES MENDONÇA" = "0530827038331816"
    "ALBERTO LUIZ FERREIRA" = "3443182824878866"
    "ALEXANDRE ARAUJO BEZERRA" = "5647518666766098"
    "ALEXANDRE MANICOBA DE OLIVEIRA" = "2351905355694162"
    "ALINE MARIA DOS SANTOS TEIXEIRA" = "8589666863624180"
    "AMAURI DIAS DE CARVALHO" = "4633002288019460"
    "ANA ELISA SOBRAL CAETANO DA SILVA FERREIRA" = "0322712366911621"
    "ANDERSON ALVES DE OLIVEIRA" = "8390762794908585"
    "ANTONIO CESAR LINS RODRIGUES" = "5364387869010471"
    "ARISTIDES FARIA LOPES DOS SANTOS" = "K4737658J8"
    "ARNALDO DE CARVALHO JUNIOR" = "2801594081219451"
    "AUGUSTO MONTEIRO OZORIO" = "8946741255015096"
}

# Agora vamos procurar na planilha por Lattes URLs em células
# Vamos ler o XML diretamente e procurar por padrões

Write-Host "Procurando Lattes no arquivo XML..."

# Lê o arquivo de strings
$xmlContent = Get-Content "extract_temp/xl/sharedStrings.xml" -Raw

# Procura por URLs de Lattes
$lattesUrls = @()
if ($xmlContent -match 'http[s]?://[^"<>]*lattes[^"<>]*') {
    $matches | ForEach-Object { 
        if ($_ -match 'http[s]?://[^"<>]*') {
            $lattesUrls += $matches[0]
        }
    }
}

Write-Host "Encontrados $($lattesUrls.Count) URLs de Lattes"
$lattesUrls | ForEach-Object { Write-Host $_ }

# Salva para análise
$lattesUrls | Out-File "lattes_urls_encontradas.txt" -Encoding utf8

Write-Host "`nArquivo salvo em: lattes_urls_encontradas.txt"
