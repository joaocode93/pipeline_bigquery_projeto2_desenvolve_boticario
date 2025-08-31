SELECT nome_cliente, SUM(preco_produto * quantidade) AS total_gasto
FROM `seu_projeto.seu_dataset.vendas`
GROUP BY nome_cliente;

SELECT nome_produto, SUM(quantidade) AS total_vendido
FROM `seu_projeto.seu_dataset.vendas`
GROUP BY nome_produto
ORDER BY total_vendido DESC;

SELECT estado_cliente, SUM(preco_produto * quantidade) AS receita_total
FROM `seu_projeto.seu_dataset.vendas`
GROUP BY estado_cliente;