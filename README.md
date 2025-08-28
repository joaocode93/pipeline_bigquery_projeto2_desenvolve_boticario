# [Mini Projeto] Pipeline de Dados e Análise com SQL no BigQuery

## 1. Introdução: A Missão da Livraria DevSaber
A **Livraria DevSaber**, uma nova loja online, começou registrando suas vendas em planilhas, mas para crescer precisa de análises mais profundas.  
Nossa missão foi transformar essa planilha em um **mini data warehouse no Google BigQuery**, construindo todo o pipeline: criação da estrutura, ingestão dos dados e consultas analíticas.

---

## 2. Estruturando o Armazenamento - Modelagem de Dados
As tabelas foram criadas com `CREATE OR REPLACE TABLE`, organizadas em **dimensões** e **fato**:

- **Clientes**: informações únicas de cada cliente.  
- **Produtos**: informações únicas de cada produto.  
- **Vendas**: fatos que relacionam clientes e produtos.  
```text
+------------------------+                      +------------------------+
|        CLIENTES        |                      |        PRODUTOS        |
+------------------------+                      +------------------------+
| PK ID_Cliente          |                      | PK ID_Produto          |
| Nome_Cliente           |                      | Nome_Produto           |
| Email_Cliente          |                      | Categoria_Produto      |
| Estado_Cliente         |                      | Preco_Produto          |
+-----------+------------+                      +-----------+------------+
            |                                               |
            |                                               |
            |                                               |
            v                                               v
+-----------------------------------------------------------------------+
|                               VENDAS                                  |
+-----------------------------------------------------------------------+
| PK ID_Venda                                                           |
| FK ID_Cliente  -----------------------> CLIENTES.ID_Cliente           |
| FK ID_Produto  -----------------------> PRODUTOS.ID_Produto           |
| Data_Venda                                                            |
| Quantidade                                                            |
+-----------------------------------------------------------------------+
```
---

## 3. Ingerindo os Dados
Os dados foram carregados nas tabelas usando `INSERT INTO`.  
Clientes e produtos foram inseridos **sem duplicatas**, enquanto a tabela de vendas relaciona os IDs.

---

## 4. Análise de Dados
Com consultas SQL, respondemos a perguntas de negócio como:

- Quais clientes são de SP?  
- Quais produtos são da categoria Ficção Científica?  
- Qual o valor total de cada venda?  
- Qual o produto mais vendido em quantidade?  

---

## 5. Automação e Reuso: VIEW
Foi criada a view `v_relatorio_vendas_detalhado`, simplificando consultas recorrentes sobre vendas detalhadas, com cliente, produto, preço, quantidade e valor total.

---

## 6. Conclusão
O projeto resultou em um **pipeline completo no BigQuery**: criação de schema, ingestão de dados, análises com `SELECT` e `JOIN` e automação com `VIEW`. Esse material foi documentado no repositório com scripts SQL e este README.

---


> Observação: No BigQuery, as chaves são **lógicas** (não há enforcement automático). Os relacionamentos são aplicados nas consultas via `JOIN`.

---

##  Arquivos do Projeto
- **01_create_tables_bigquery.sql** → criação das tabelas.  
- **02_insert_data_bigquery.sql** → inserção de dados.  
- **03_analysis_and_view_bigquery.sql** → consultas de análise e criação de views.  

---

##  Perguntas e Respostas (conforme solicitado)

**Por que uma planilha não é ideal para uma empresa que quer analisar suas vendas a fundo?**  
Uma planilha não é ideal para analisar vendas em profundidade porque não escala bem para grandes volumes de dados, carece de mecanismos de integridade que garantam consistência entre informações relacionadas e possui recursos limitados para realizar análises avançadas e gerar relatórios detalhados.

---

**Que tipo de perguntas vocês acham que o dono da livraria gostaria de responder com esses dados?**  
- Quais são os produtos mais vendidos e em quais categorias?  
- Quem são os clientes que mais compram e de quais estados eles vêm?  
- Qual é o faturamento total em determinado período?  
- Quais períodos do ano apresentam maior volume de vendas?  

---

**Com base nos dados brutos, quais outras duas tabelas precisamos criar? Que colunas e tipos de dados elas teriam?**  

### 1. Clientes

Armazena informações únicas de cada cliente.

- ID_Cliente INT64 – identificador único do cliente.

- Nome_Cliente STRING – nome completo do cliente.

- Email_Cliente STRING – e-mail do cliente.

- Estado_Cliente STRING – estado de origem do cliente.

### 2. Produtos

Armazena informações únicas de cada produto.

- ID_Produto INT64 – identificador único do produto.

- Nome_Produto STRING – nome do produto.

- Categoria_Produto STRING – categoria do produto (ex.: Dados, Ficção Científica, Programação).

- Preco_Produto NUMERIC – preço unitário do produto.

### 3. Vendas
A tabela de Vendas continua como tabela fato, relacionando as duas dimensões:

- ID_Venda INT64

- ID_Cliente INT64 (chave estrangeira para Clientes)

- ID_Produto INT64 (chave estrangeira para Produtos)

- Data_Venda DATE

- Quantidade INT64

---

**Se o BigQuery não tem chaves estrangeiras, como garantimos que um `ID_Cliente` na tabela de vendas realmente existe na tabela de clientes? (Resposta: A responsabilidade é nossa, na hora de construir a consulta com o `JOIN`).**  
 Usando JOIN entre Vendas e Clientes em consultas para garantir que só registros consistentes sejam analisados.

---

**Por que é uma boa prática inserir os clientes e produtos em suas próprias tabelas antes de inserir os dados de vendas?**  
Inserir clientes e produtos em tabelas próprias antes das vendas é uma boa prática porque evita redundância de informações, garante consistência nos dados ao centralizar atualizações em um único lugar e facilita as análises ao seguir uma modelagem clara em que dimensões descrevem os elementos e a tabela de vendas registra os fatos.

---

**Em um cenário com milhões de vendas por dia, o `INSERT INTO` seria a melhor abordagem?**  
Em um cenário com milhões de vendas por dia, o INSERT INTO não é a melhor abordagem, pois seria ineficiente e custoso; o ideal é utilizar cargas em lote com uma pipeline de dados automatizada.

---

**Qual é a principal vantagem de usar uma `VIEW` em vez de simplesmente salvar o código em um arquivo de texto?**  
A principal vantagem de usar uma VIEW é que ela fica armazenada no próprio banco e pode ser reutilizada facilmente por qualquer usuário ou aplicação, sempre refletindo os dados mais atualizados, enquanto um arquivo de texto exige copiar e executar manualmente o código, aumentando riscos de erro e dificultando a padronização das consultas.

---

**Se o preço de um produto mudar na tabela `Produtos`, o `Valor_Total` na `VIEW` será atualizado automaticamente na próxima vez que a consultarmos?**  
Sim, porque uma VIEW não armazena dados, apenas a lógica da consulta; assim, quando o preço de um produto é alterado na tabela Produtos, o cálculo de Valor_Total é refeito dinamicamente na próxima execução da view, refletindo automaticamente o valor atualizado.



