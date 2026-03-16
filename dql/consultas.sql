--  CONSULTAS RELACIONAIS (DQL) - Lanchonete

--1
SELECT 
    p.id_pedido,
    m.formas_transacao
FROM pagamentos p
RIGHT JOIN metodos_pagamento m
ON p.id_pagamento = m.id_pagamento;

--2
SELECT 
    p.nome AS produto,
    c.nome_categoria
FROM produtos p
LEFT JOIN categorias c
ON p.id_categoria = c.id_unico;

--3
SELECT 
    ip.id_pedido, 
    pr.nome AS produto
FROM item_produto ip
INNER JOIN produtos pr ON ip.id_produto = pr.id_produto;

--4
SELECT 
    p.id_pedido, 
    f.nome_completo AS atendente
FROM pedidos p
INNER JOIN funcionarios f ON p.cpf_funcionario = f.cpf;

--5
SELECT 
    f.nome_completo, 
    p.id_pedido
FROM funcionarios f
LEFT JOIN pedidos p ON f.cpf = p.cpf_funcionario;

--6
SELECT 
    pr.nome AS produto, 
    ip.quantidade
FROM item_produto ip
INNER JOIN produtos pr ON ip.id_produto = pr.id_produto;

--7
SELECT 
    p.status, 
    c.nome_completo AS cliente
FROM pedidos p
INNER JOIN clientes c ON p.cpf_cliente = c.cpf;

--8
SELECT 
    c.nome_categoria, 
    p.nome AS produto
FROM produtos p
RIGHT JOIN categorias c ON p.id_categoria = c.id_unico;

--9
SELECT 
    pr.nome AS produto, 
    pr.valor_unitario AS valor_tabela, 
    ip.valor AS valor_venda
FROM item_produto ip
INNER JOIN produtos pr ON ip.id_produto = pr.id_produto;

--10
SELECT 
    nome_completo, 
    cargo
FROM funcionarios; 

--11
SELECT 
    p.nome AS produto, 
    i.estoque_atual
FROM produtos p
LEFT JOIN receitas r ON p.id_produto = r.id_produto
LEFT JOIN ingredientes i ON r.id_ingrediente = i.id_ingrediente;

--12
SELECT 
    p.id_pedido, 
    pag.data_pagamento AS horario_confirmacao
FROM pedidos p
INNER JOIN pagamentos pag ON p.id_pedido = pag.id_pedido;