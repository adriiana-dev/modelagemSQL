--  CONSULTAS RELACIONAIS (DQL) - Lanchonete

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
