--  CONSULTAS RELACIONAIS (DQL) - Lanchonete

--1 Right Join: Liste todos os métodos de pagamento e os IDs dos pedidos que os utilizaram, incluindo métodos nunca usados.
SELECT 
    p.id_pedido,
    m.formas_transacao
FROM pagamentos p
RIGHT JOIN metodos_pagamento m
ON p.id_pagamento = m.id_pagamento;

--2 Left Join: Exiba todos os produtos e o nome de suas categorias, incluindo produtos que ainda não foram categorizados.
SELECT 
    p.nome AS produto,
    c.nome_categoria
FROM produtos p
LEFT JOIN categorias c
ON p.id_categoria = c.id_unico;

--3 Inner Join: Mostre o número do pedido e os nomes dos produtos incluídos nele.
SELECT 
    ip.id_pedido, 
    pr.nome AS produto
FROM item_produto ip
INNER JOIN produtos pr ON ip.id_produto = pr.id_produto;

--4 Inner Join: Relacione o pedido com o nome do funcionário que realizou o atendimento.
SELECT 
    p.id_pedido, 
    f.nome_completo AS atendente
FROM pedidos p
INNER JOIN funcionarios f ON p.cpf_funcionario = f.cpf;

--5 Left Join: Liste todos os funcionários e os pedidos que eles processaram, incluindo funcionários de folga que não venderam nada.
SELECT 
    f.nome_completo, 
    p.id_pedido
FROM funcionarios f
LEFT JOIN pedidos p ON f.cpf = p.cpf_funcionario;

--6 Inner Join: Exiba o nome do produto e a quantidade exata vendida em cada item de pedido.
SELECT 
    pr.nome AS produto, 
    ip.quantidade
FROM item_produto ip
INNER JOIN produtos pr ON ip.id_produto = pr.id_produto;

--7 Inner Join: Mostre o status do pedido (preparando/entregue) e o nome do cliente vinculado (se houver).
SELECT 
    p.status, 
    c.nome_completo AS cliente
FROM pedidos p
INNER JOIN clientes c ON p.cpf_cliente = c.cpf;

--8 Right Join: Liste todas as categorias do cardápio e os produtos vinculados, mesmo categorias que não possuem itens à venda.
SELECT 
    c.nome_categoria, 
    p.nome AS produto
FROM produtos p
RIGHT JOIN categorias c ON p.id_categoria = c.id_unico;

--9 Inner Join: Exiba o valor unitário do produto na tabela de preços e o valor praticado no momento da venda no item do pedido.
SELECT 
    pr.nome AS produto, 
    pr.valor_unitario AS valor_tabela, 
    ip.valor AS valor_venda
FROM item_produto ip
INNER JOIN produtos pr ON ip.id_produto = pr.id_produto;

--10 Inner Join: Relacione o nome do funcionário com o cargo que ele ocupa na lanchonete.
SELECT 
    nome_completo, 
    cargo
FROM funcionarios; 

--11 Left Join: Liste todos os produtos e os registros de estoque, incluindo itens que nunca tiveram entrada de mercadoria.
SELECT 
    p.nome AS produto, 
    i.estoque_atual
FROM produtos p
LEFT JOIN receitas r ON p.id_produto = r.id_produto
LEFT JOIN ingredientes i ON r.id_ingrediente = i.id_ingrediente;

--12 Inner Join: Mostre o ID do pedido e o detalhamento do horário em que o pagamento foi confirmado.
SELECT 
    p.id_pedido, 
    pag.data_pagamento AS horario_confirmacao
FROM pedidos p
INNER JOIN pagamentos pag ON p.id_pedido = pag.id_pedido;
