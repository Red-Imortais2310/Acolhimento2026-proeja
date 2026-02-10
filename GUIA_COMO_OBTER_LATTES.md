# GUIA PRÁTICO: Como Obter os IDs de Lattes

## Método 1: Busca Manual no Site do CNPq (Recomendado)

### Passo 1: Acesse o site do CNPq
- Abra seu navegador
- Vá para: **http://lattes.cnpq.br/**

### Passo 2: Procure pelo nome do professor
- Na barra de busca, digite o nome do professor
- Você pode buscar por:
  - Nome completo: "Artarxerxes Tiago Tácito Modesto"
  - Sobrenome + outro nome: "Modesto Artarxerxes"
  - Apenas sobrenome (se raro)

### Passo 3: Identifique o currículo correto
- Procure pelo professor que é do IFSP Campus Cubatão
- Verifique se o área de pesquisa está correta
- Às vezes pode haver homônimos

### Passo 4: Copie o ID
- Quando entrar no currículo, a URL será:
  ```
  http://lattes.cnpq.br/1234567890123
  ```
- O ID é aquele número no final: **1234567890123**
- Você pode também ir em "Visualizar Currículo" > "Formulário da Base"
- O ID aparece como "ID Lattes" ou "Número do Currículo"

---

## Método 2: Encontrar através do Google Scholar

### Se o professor tiver perfil no Google Scholar:

1. Abra a URL do Google Scholar fornecida no CSV
   - Exemplo: `https://scholar.google.com.br/citations?user=JslBIEEAAAAJ`

2. Procure por um link para o Lattes
   - Geralmente está no perfil do Scholar
   - Pode estar na seção "Informações do Autor"

3. Clique no link do Lattes
   - Você será redirecionado para o currículo Lattes
   - Copie o ID da URL

---

## Método 3: Busca no Google

Se os métodos anteriores não funcionarem:

1. Abra Google
2. Digite: `"Nome Completo" site:lattes.cnpq.br`
   - Exemplo: `"Artarxerxes Tiago Tácito Modesto" site:lattes.cnpq.br`

3. Clique no primeiro resultado
4. Copie o ID da URL

---

## Método 4: Contato Direto (Último Recurso)

Se nada funcionar, envie um email para o professor:

```
Para: nome.sobrenome@ifsp.edu.br

Assunto: Solicito seu ID do Currículo Lattes

Prezado(a) Prof(a) [Nome],

Para um projeto institucional, precisamos do seu ID de Currículo Lattes.

Você pode encontrá-lo em http://lattes.cnpq.br/:
- Faça login
- Vá em "Meu Currículo"
- O ID aparece na URL (números no final)

Agradeço a colaboração.

Cordialmente,
[Seu Nome]
```

---

## Lista de Professores Prioritários

Comece por estes (têm perfis confirmados):

1. ✓ Artarxerxes Tiago Tácito Modesto - Fácil
2. ✓ Claudia Cristina Soares De Carvalho - Fácil
3. ✓ Leandro Fabricio Campelo - Fácil
4. ✓ Antonio Mendes De Oliveira Neto - Fácil
5. ✓ Caroline Alves Soler - Fácil
6. ✓ Elcio Rodrigues Aranha - Fácil
7. ✓ Elian João Agnoletto - Fácil
8. ✓ Enzo Bertazini - Fácil

Depois, procure pelos demais usando Método 1 ou Método 4.

---

## Formato Final Esperado

Quando obter todos os IDs, o resultado deve ser assim:

```
Artarxerxes Tiago Tácito Modesto | 1234567890123 | http://lattes.cnpq.br/1234567890123
Claudia Cristina Soares De Carvalho | 2345678901234 | http://lattes.cnpq.br/2345678901234
[...]
```

---

## Dicas Práticas

- **Acentuação**: Se não encontrar com acento, tente sem (ex: "Fabricio" em vez de "Fabrício")
- **Ordem de nomes**: Tente diferentes ordens do nome
- **Variações de sobrenome**: Alguns usam "De", "Da" ou "Do" de formas diferentes
- **Nomes compostos**: Teste diferentes partes do nome

---

## Tempo Estimado

- **Com Método 1**: ~1 minuto por professor = ~25-30 minutos total
- **Com Método 2**: ~2-3 minutos por professor = ~1 hora total
- **Método 3**: ~3-5 minutos por professor = ~1h 30min total

**Tempo total estimado: 30-50 minutos para os 25 professores**

---

## Arquivo para Preencher

Use o arquivo `professores_lattes.csv` para registrar os IDs conforme os encontrar:
- Coluna "ID Lattes" → Cole o número aqui
- Coluna "Status" → Mude para "Completo" ou "Não Encontrado"
- Coluna "Notas" → Adicione observações se necessário

Depois salve como Excel ou envie para integração no projeto.

---

## Suporte

Se tiver dúvidas:
- Verifique se o site do Lattes está funcionando
- Tente em um navegador diferente
- Verifique a ortografia do nome (acentos, maiúsculas)
- Consulte o professor pessoalmente

---

**Boa sorte com a busca!** 🎓
