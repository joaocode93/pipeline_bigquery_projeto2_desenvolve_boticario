SELECT Nome_Cliente
FROM `seu-projeto.seu_dataset.Clientes`
WHERE Estado_Cliente = 'SP';

SELECT Nome_Produto
FROM `seu-projeto.seu_dataset.Produtos`
WHERE Categoria_Produto = 'Ficção Científica';

SELECT
    C.Nome_Cliente,
    P.Nome_Produto,
    V.Data_Venda
FROM `seu-projeto.seu_dataset.Vendas` AS V
JOIN `seu-projeto.seu_dataset.Clientes` AS C ON V.ID_Cliente = C.ID_Cliente
JOIN `seu-projeto.seu_dataset.Produtos` AS P ON V.ID_Produto = P.ID_Produto
ORDER BY V.Data_Venda;

SELECT
    V.ID_Venda,
    (V.Quantidade * P.Preco_Produto) AS Valor_Total
FROM `seu-projeto.seu_dataset.Vendas` AS V
JOIN `seu-projeto.seu_dataset.Produtos` AS P ON V.ID_Produto = P.ID_Produto;

SELECT
    P.Nome_Produto,
    SUM(V.Quantidade) AS Total_Quantidade_Vendida
FROM `seu-projeto.seu_dataset.Vendas` AS V
JOIN `seu-projeto.seu_dataset.Produtos` AS P ON V.ID_Produto = P.ID_Produto
GROUP BY P.Nome_Produto
ORDER BY Total_Quantidade_Vendida DESC
LIMIT 1;

CREATE OR REPLACE VIEW `seu-projeto.seu_dataset.v_relatorio_vendas_detalhado` AS
SELECT
    V.ID_Venda,
    V.Data_Venda,
    C.Nome_Cliente,
    C.Estado_Cliente,
    P.Nome_Produto,
    P.Categoria_Produto,
    V.Quantidade,
    P.Preco_Produto,
    (V.Quantidade * P.Preco_Produto) AS Valor_Total
FROM `seu-projeto.seu_dataset.Vendas` AS V
JOIN `seu-projeto.seu_dataset.Clientes` AS C ON V.ID_Cliente = C.ID_Cliente
JOIN `seu-projeto.seu_dataset.Produtos` AS P ON V.ID_Produto = P.ID_Produto;
