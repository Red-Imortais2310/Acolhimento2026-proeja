<!-- Script para Busca de Lattes em Lote -->
<!-- Cole este código no console do navegador (F12) para buscar cada professor -->

// Função para abrir múltiplas abas com buscas de Lattes
function buscarLattesEmLote() {
    const professores = [
        "Artarxerxes Tiago Tácito Modesto",
        "Claudia Cristina Soares De Carvalho",
        "Leandro Fabricio Campelo",
        "Leticia Vieira Oliveira Giordano",
        "Michelli Analy de Lima Rosa",
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
    ];

    // Abre uma aba para cada professor com busca Google Scholar
    professores.forEach((nome, index) => {
        const query = encodeURIComponent(nome + " IFSP lattes");
        const url = `https://scholar.google.com.br/scholar?q=${query}`;
        
        // Atraso para não sobrecarregar
        setTimeout(() => {
            window.open(url, `_blank_${index}`);
        }, index * 500);
    });

    console.log("Abas abertas para pesquisa de todos os professores!");
}

// Função alternativa: Buscar direto no CNPq
function buscarCNPqDireto(nome) {
    const urlCNPq = `http://lattes.cnpq.br/web/portalnew/buscafrases`;
    const query = encodeURIComponent(`"${nome}"`);
    
    // Abre em nova aba
    window.open(`${urlCNPq}?q=${query}`, '_blank');
}

// Para usar, copie e cole uma destas linhas no console:
// buscarLattesEmLote()        // Abre abas para todos
// buscarCNPqDireto("Nome Aqui") // Busca um específico

console.log("✓ Script carregado! Use 'buscarLattesEmLote()' ou 'buscarCNPqDireto(\"Nome\")'");
