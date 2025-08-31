-- Arquivo: 01_create_tables_bigquery.sql
-- Este script cria a estrutura do schema no Google BigQuery.
-- Substitua `seu-projeto.seu_dataset` pelo nome do seu projeto e dataset.

-- Tabela de Clientes
CREATE OR REPLACE TABLE `seu-projeto.seu_dataset.Clientes` (
    ID_Cliente INT64,
    Nome_Cliente STRING,
    Email_Cliente STRING,
    Estado_Cliente STRING
);

-- Tabela de Produtos
CREATE OR REPLACE TABLE `seu-projeto.seu_dataset.Produtos` (
    ID_Produto INT64,
    Nome_Produto STRING,
    Categoria_Produto STRING,
    Preco_Produto NUMERIC
);

-- Tabela de Vendas
CREATE OR REPLACE TABLE `seu-projeto.seu_dataset.Vendas` (
    ID_Venda INT64,
    ID_Cliente INT64,
    ID_Produto INT64,
    Data_Venda DATE,
    Quantidade INT64
);
