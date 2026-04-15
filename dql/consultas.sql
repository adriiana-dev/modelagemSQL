-- CONSULTAS RELACIONAIS (DQL) - Lanchonete

--1 Right Join: Liste todos os métodos de pagamento e os IDs dos pedidos que os utilizaram, incluindo métodos nunca usados.
SELECT m.forma_transacao, p.id AS id_pagamento
FROM pagamentos p
RIGHT JOIN metodos_pagamento m ON p.id_metodo = m.id;

--2 Left Join: Exiba todos os produtos e o nome de suas categorias, incluindo produtos que ainda não foram categorizados.
SELECT p.nome AS produto, c.nome AS categoria
FROM produtos p
LEFT JOIN categorias c ON p.id_categoria = c.id;

--3 Inner Join: Mostre o número do pedido e os nomes dos produtos incluídos nele.
SELECT ip.id_pedido, p.nome AS produto
FROM item_produto ip
INNER JOIN produtos p ON ip.id_produto = p.id;

--4 Inner Join: Relacione o pedido com o nome do funcionário que realizou o atendimento.
SELECT p.id AS pedido_n, f.nome AS funcionario
FROM pedidos p
INNER JOIN funcionarios f ON p.id_funcionario = f.id;

--5 Left Join: Liste todos os funcionários e os pedidos que eles processaram, incluindo funcionários de folga que não venderam nada.
SELECT f.nome AS funcionario, p.id AS pedido_n
FROM funcionarios f
LEFT JOIN pedidos p ON f.id = p.id_funcionario;

--6 Inner Join: Exiba o nome do produto e a quantidade exata vendida em cada item de pedido.
SELECT p.nome AS produto, ip.quantidade
FROM item_produto ip
INNER JOIN produtos p ON ip.id_produto = p.id;

--7 Inner Join: Mostre o status do pedido (preparando/entregue) e o nome do cliente vinculado (se houver).
SELECT p.status, c.nome AS cliente
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id;

--8 Right Join: Liste todas as categorias do cardápio e os produtos vinculados, mesmo categorias que não possuem itens à venda.
SELECT c.nome AS categoria, p.nome AS produto
FROM produtos p
RIGHT JOIN categorias c ON p.id_categoria = c.id;

--9 Inner Join: Exiba o valor unitário do produto na tabela de preços e o valor praticado no momento da venda no item do pedido.
SELECT p.nome, p.valor_unitario AS preco_tabela, ip.valor_unitario AS preco_venda
FROM item_produto ip
INNER JOIN produtos p ON ip.id_produto = p.id;

--10 Inner Join: Relacione o nome do funcionário com o cargo que ele ocupa na lanchonete.
SELECT nome, cargo
FROM funcionarios;

--11 Left Join: Liste todos os produtos e os registros de estoque, incluindo itens que nunca tiveram entrada de mercadoria.
SELECT p.nome AS produto, r.id AS registro_receita
FROM produtos p
LEFT JOIN receitas r ON p.id = r.id_produto;

--12 Inner Join: Mostre o ID do pedido e o detalhamento do horário em que o pagamento foi confirmado.
SELECT id_pedido, data_pagamento
FROM pagamentos;

--13 Group By: Calcule o valor total arrecadado agrupado por método de pagamento.
SELECT 
    mp.forma_transacao,
    SUM(p.valor_pago) AS total_arrecadado
FROM pagamentos p
JOIN metodos_pagamento mp ON mp.id = p.id_metodo
GROUP BY mp.forma_transacao
ORDER BY total_arrecadado DESC;

--14 Group By: Conte quantos pedidos cada funcionário atendeu no dia.
SELECT 
    f.nome AS funcionario,
    COUNT(p.id) AS total_pedidos
FROM pedidos p
JOIN funcionarios f ON f.id = p.id_funcionario
WHERE p.data = '2026-03-11' -- aqui coloca a data do dia
GROUP BY f.nome
ORDER BY total_pedidos DESC;

--15 Group By: Identifique a quantidade total vendida de cada produto na tabela de itens.
SELECT 
    p.nome AS produto, 
    SUM(ip.quantidade) AS total_vendido
FROM item_produto ip
JOIN produtos p ON ip.id_produto = p.id
GROUP BY p.nome;

--16 Group By: Calcule o preço médio dos produtos por categoria.
SELECT 
    c.nome AS categoria, 
    ROUND(AVG(p.valor_unitario), 2) AS preco_medio
FROM produtos p
JOIN categorias c ON p.id_categoria = c.id
GROUP BY c.nome;

--17 Union: Liste os nomes de todos os produtos e os nomes de todas as categorias do cardápio.
SELECT nome AS item_cardapio 
FROM produtos
UNION
SELECT nome 
FROM categorias;

--18 Union All: Combine os IDs de produtos da tabela de cadastro com os IDs de produtos da tabela de itens vendidos.
SELECT id AS id_produto_geral 
FROM produtos
UNION ALL
SELECT id_produto 
FROM item_produto;

--19 Intersect: Identifique produtos que tiveram vendas registradas tanto em "Dinheiro" quanto em "Pix".
SELECT p.nome AS produto
FROM produtos p
JOIN item_produto ip ON p.id = ip.id_produto
JOIN pagamentos pg ON ip.id_pedido = pg.id_pedido
JOIN metodos_pagamento mp ON pg.id_metodo = mp.id
WHERE mp.forma_transacao = 'Dinheiro'
INTERSECT
SELECT p.nome AS produto
FROM produtos p
JOIN item_produto ip ON p.id = ip.id_produto
JOIN pagamentos pg ON ip.id_pedido = pg.id_pedido
JOIN metodos_pagamento mp ON pg.id_metodo = mp.id
WHERE mp.forma_transacao = 'Pix';

--20 Group By: Totalize o faturamento da lanchonete agrupado por data da venda.
SELECT 
    data_pagamento, 
    SUM(valor_pago) AS faturamento_total
FROM pagamentos
GROUP BY data_pagamento
ORDER BY data_pagamento;

--21 Union: Gere uma lista com os nomes de todos os funcionários e nomes de clientes (se houver cadastro).
SELECT nome, 'Funcionário' AS origem 
FROM funcionarios
UNION
SELECT nome, 'Cliente' 
FROM clientes;

--22 Group By: Mostre a quantidade de itens incluídos em cada pedido específico.
SELECT 
    id_pedido, 
    SUM(quantidade) AS total_itens_no_pedido
FROM item_produto
GROUP BY id_pedido
ORDER BY id_pedido;

--23 Intersect: Encontre datas em que houve tanto vendas quanto registros de entrada de estoque.
SELECT data AS data_operacao 
FROM pedidos
INTERSECT
SELECT data 
FROM compras_estoque;

--24 Group By: Exiba o total de estoque remanescente agrupado por nome de produto.
SELECT 
    nome, 
    SUM(estoque) AS estoque_total_remanescente
FROM produtos
GROUP BY nome;