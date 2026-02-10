# Script para buscar IDs de Lattes
# Este script procura pelos professores e retorna possíveis IDs de Lattes

$directores = @(
    "Artarxerxes Tiago Tácito Modesto",
    "Claudia Cristina Soares De Carvalho",
    "Leandro Fabricio Campelo",
    "Leticia Vieira Oliveira Giordano",
    "Michelli Analy de Lima Rosa"
)

$professores = @(
    "Antonio Mendes De Oliveira Neto",
    "Carlos Barreira Da Silva Farinhas",
    "Carlos Jair Coletto",
    "Caroline Alves Soler",
    "Charles Artur Santos De Oliveira",
    "Cristiane Ferraz E Silva Suarez",
    "Daiane Evangelista Da Silva",
    "Douglas Rodrigues Silva",
    "Edmilson Roberto Braga",
    "Eduardo Henrique Gomes",
    "Elaine Cristina De Araujo",
    "Elcio Rodrigues Aranha",
    "Elian João Agnoletto",
    "Enzo Bertazini",
    "Fabiana De Lacerda Vilaco",
    "Ferdinando Calle",
    "Fernanda Aparecida Dos Santos",
    "Fernando Ribeiro Dos Santos",
    "Filipe Bento Magalhães",
    "Flavia Daylane Tavares De Luna"
)

function Search-Lattes {
    param(
        [string]$Nome
    )
    
    # Formata o nome para a busca
    $searchTerm = [System.Uri]::EscapeDataString($Nome)
    
    # Tenta buscar pela URL direta do Lattes (padrão)
    # URL padrão: http://lattes.cnpq.br/{ID}
    # Vamos tentar fazer uma busca comum
    
    Write-Host "Procurando: $Nome"
    
    # Retorna o nome para análise manual posterior
    # (Neste caso, como não posso fazer scraping, vou gerar um template)
    return $Nome
}

# Processa diretores
Write-Host "=== DIRETORES ===" -ForegroundColor Green
$directores | ForEach-Object {
    Search-Lattes $_
}

# Processa professores
Write-Host "`n=== PROFESSORES ===" -ForegroundColor Green
$professores | ForEach-Object {
    Search-Lattes $_
}

Write-Host "`nNota: Para encontrar os IDs de Lattes, acesse http://lattes.cnpq.br/ e busque pelo nome de cada professor."
Write-Host "O ID estará na URL final no formato: http://lattes.cnpq.br/{ID}"
