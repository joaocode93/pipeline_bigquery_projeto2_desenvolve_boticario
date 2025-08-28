-- Este script cria a estrutura do schema no Google BigQuery.
-- Tabela de Clientes(TABELA NORMALIZADA, DIMENSÃO)
-- Armazena informações únicas de cada cliente.
-- Chave primária, ID cliente
CREATE OR REPLACE TABLE `t1engenhariadados.LivrariaDevSaber_juliete.Clientes` (
    ID_Cliente      INT64,
    Nome_Cliente    STRING,
    Email_Cliente   STRING,
    Estado_Cliente  STRING
);
   
-- Tabela de Produtos (TABELA NORMALIZADA, DIMENSÃO)
-- Armazena informações únicas de cada produto.
-- Chave primária: ID_Produto 
CREATE OR REPLACE TABLE `t1engenhariadados.LivrariaDevSaber_juliete.Produtos` (
    ID_Produto          INT64,
    Nome_Produto        STRING,
    Categoria_Produto   STRING,
    Preco_Produto NUMERIC
);
--
-- Tabela de Vendas(TABELA FATO )
-- Tabela de fatos que relaciona clientes e produtos, registrando cada transação.
-- As relações com Clientes e Produtos são lógicas, mantidas pelos campos de ID.
-- Chave primária: ID_Venda
-- Chaves estrangeiras: ID_Produto,ID_Cliente
CREATE OR REPLACE TABLE `t1engenhariadados.LivrariaDevSaber_juliete.Vendas` (
    ID_Venda   INT64,
    ID_Cliente INT64,
    ID_Produto INT64,
    Data_Venda DATE,
    Quantidade INT64
);

