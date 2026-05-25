--AbrirPedido: Inicia um novo registro de venda vinculando o funcionário responsável.

CREATE OR REPLACE PROCEDURE AbrirPedido(
    p_id_funcionario INT,
    p_id_cliente INT DEFAULT NULL,
    p_id_mesa INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_novo_id INT; 
BEGIN
        SELECT COALESCE(MAX(id), 0) + 1 INTO v_novo_id FROM pedidos;

    INSERT INTO pedidos (id, data, status, id_funcionario, id_cliente, id_mesa)
    VALUES (v_novo_id, CURRENT_DATE, 'Novo', p_id_funcionario, p_id_cliente, p_id_mesa);
END;
$$;


--AdicionarItemPedido: Insere um produto no pedido e calcula o subtotal com base no preço atual.

CREATE OR REPLACE PROCEDURE AdicionarItemPedido(
    p_id_pedido INT,
    p_id_produto INT,
    p_quantidade INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_novo_id INT;
    v_preco NUMERIC(12,2);
    v_total NUMERIC(12,2);
BEGIN
    SELECT valor_unitario INTO v_preco 
    FROM produtos 
    WHERE id = p_id_produto;

    v_total := v_preco * p_quantidade;

    SELECT COALESCE(MAX(id), 0) + 1 INTO v_novo_id FROM item_produto;

    INSERT INTO item_produto (id, id_pedido, id_produto, quantidade, valor_unitario, valor_total)
    VALUES (v_novo_id, p_id_pedido, p_id_produto, p_quantidade, v_preco, v_total);

    UPDATE produtos 
    SET estoque = estoque - p_quantidade 
    WHERE id = p_id_produto;
END;
$$;


--FecharCaixaDia: Consolida todas as vendas de uma data e gera um resumo financeiro.

CREATE OR REPLACE FUNCTION FecharCaixaDia(p_data DATE)
RETURNS TABLE (
    data_caixa DATE,
    total_pedidos BIGINT,
    faturamento_bruto NUMERIC(12,2),
    ticket_medio NUMERIC(12,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
   
    RETURN QUERY
    SELECT 
        p_data AS data_caixa,
        COUNT(DISTINCT p.id) AS total_pedidos,
        COALESCE(SUM(pag.valor_pago), 0) AS faturamento_bruto,
        ROUND(COALESCE(SUM(pag.valor_pago), 0) / NULLIF(COUNT(DISTINCT p.id), 0), 2) AS ticket_medio
    FROM pedidos p
    LEFT JOIN pagamentos pag ON p.id = pag.id_pedido
    WHERE p.data = p_data AND p.status = 'Finalizado';
END;
$$;



