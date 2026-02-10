## RELATÓRIO: BUSCA DE IDs DE LATTES - IFSP CAMPUS CUBATÃO
### Data: 05 de fevereiro de 2026

---

### RESUMO EXECUTIVO

Foi realizada uma busca por IDs de Lattes para 25 professores do IFSP Campus Cubatão (5 diretores e 20 professores). Devido a limitações técnicas de acesso ao site do CNPq, conseguimos:

✓ Identificar perfis no Google Scholar para ~13 professores  
✓ Confirmar que o CSV do projeto contém estrutura para dados de Lattes  
✓ Mapear fontes alternativas de informação (ResearchGate, Academia.edu)  
✗ Extrair os IDs numéricos completos de forma automatizada

---

### DIRETORES - STATUS DA BUSCA

| Nome | Google Scholar | Status | Próximas Etapas |
|------|---------|--------|----------|
| Artarxerxes Tiago Tácito Modesto | ✓ JslBIEEAAAAJ | Perfil encontrado | Buscar ID no Lattes direto |
| Claudia Cristina Soares De Carvalho | ✓ x3grG94AAAAJ | Perfil encontrado | Buscar ID no Lattes direto |
| Leandro Fabricio Campelo | ✓ iO4xbYYAAAAJ | Perfil encontrado | Buscar ID no Lattes direto |
| Leticia Vieira Oliveira Giordano | ✗ | Não encontrado | Contato direto recomendado |
| Michelli Analy de Lima Rosa | ✗ | Não encontrado | Contato direto recomendado |

---

### PROFESSORES - STATUS DA BUSCA (Amostra)

| Nome | Google Scholar | Status | Notas |
|------|---------|--------|-------|
| Antonio Mendes De Oliveira Neto | ✓ RniiM28AAAAJ | Encontrado | Pesquisador ativo, 122 citações |
| Caroline Alves Soler | ✓ | Encontrado | Especialista em Espanhol/IFSP |
| Carlos Jair Coletto | ✓ | Encontrado | Múltiplos artigos |
| Edmilson Roberto Braga | ✓ | Encontrado | Pesquisador ativo em sensores |
| Elcio Rodrigues Aranha | ✓ | Encontrado | Múltiplos artigos IFSP |
| Elian João Agnoletto | ✓ | Encontrado | Pesquisador em microgrids |
| Enzo Bertazini | ✓ | Encontrado | Artigos em automação elétrica |
| Fernando Ribeiro Dos Santos | ✓ | Encontrado | Área de Turismo/IFSP |

---

### DESAFIOS TÉCNICOS ENCONTRADOS

1. **Site do CNPq com proteção contra scraping**
   - Retorna erro HTTP 429 (Too Many Requests)
   - Requer navegação interativa do navegador

2. **Falta de dados padronizados em repositórios públicos**
   - Nem todos os professores têm perfis em Google Scholar
   - Não há lista consolidada de Lattes no site do IFSP

3. **Variações de nomes**
   - Alguns professores usam nomes diferentes em publicações
   - Dificuldade em mapear com 100% de certeza

---

### RECOMENDAÇÕES - PRÓXIMOS PASSOS

#### **Opção 1: Busca Manual (Mais Confiável)**
1. Acesse: http://lattes.cnpq.br/
2. Para cada professor, procure pelo nome completo
3. Quando encontrado, a URL será: `http://lattes.cnpq.br/{ID}`
4. Copie o ID (números no final da URL)

Tempo estimado: ~10-15 minutos para 25 pessoas

#### **Opção 2: Contato Direto com Professores**
Envie email para: `nome.sobrenome@ifsp.edu.br`

Modelo de email:
```
Assunto: Solicitação - ID do Currículo Lattes

Prezado(a) Prof(a) [Nome],

Para o projeto Acolhimento Proeja 2026, precisamos do seu ID de Lattes 
(número de 10-15 dígitos). Você pode encontrá-lo em: http://lattes.cnpq.br/

Seu ID aparece no final da URL do seu currículo.

Agradecemos a colaboração!
```

#### **Opção 3: Dados via Scripts Auxiliares**
Arquivos criados para auxiliar:
- `buscar_lattes_navegador.js` - Script para abrir múltiplas abas
- `mapeamento_lattes.txt` - Arquivo com status de cada professor

---

### ARQUIVOS GERADOS

1. **mapeamento_lattes.txt**
   - Lista completa de professores
   - Status da busca para cada um
   - Links para Google Scholar dos encontrados

2. **buscar_lattes_navegador.js**
   - Script para automatizar buscas em lote
   - Para usar: copie o código no console (F12) do navegador

3. **buscar_lattes.ps1**
   - Script PowerShell com lista de professores
   - Pode ser adaptado para integração com dados

---

### INFORMAÇÕES ÚTEIS

**IDs de Google Scholar Confirmados:**
- Artarxerxes Tiago Tácito Modesto: JslBIEEAAAAJ
- Claudia Cristina Soares De Carvalho: x3grG94AAAAJ
- Leandro Fabricio Campelo: iO4xbYYAAAAJ
- Antonio Mendes De Oliveira Neto: RniiM28AAAAJ

Estes podem ser usados para gerar links de Scholar:
`https://scholar.google.com.br/citations?user={ID}`

---

### CONCLUSÃO

A busca de IDs de Lattes por meio de automação é limitada devido à proteção do site do CNPq. 
Recomenda-se a **combinação de busca manual + contato direto** para obter os dados com 
100% de precisão no menor tempo possível.

Tempo estimado para conclusão (manual): **15-20 minutos**
Pessoas buscadas: **25 (5 diretores + 20 professores)**
Taxa de sucesso encontrada: **~52% com perfis públicos localizáveis**

---

**Próximas ações sugeridas:**
- [ ] Completar buscas manuais dos professores encontrados
- [ ] Enviar emails aos não encontrados
- [ ] Compilar dados finais em formato CSV
- [ ] Integrar IDs ao projeto do site

