-- ROTINAS DE VENDAS E MOVIMENTACAO DIARIA - PostgreSQL

-- Procedures

-- AbrirPedido: inicia um novo registro de venda vinculando o funcionario responsavel.
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

    INSERT INTO pedidos (id, data, hora_pedido, status, valor_total, id_funcionario, id_cliente, id_mesa)
    VALUES (v_novo_id, CURRENT_DATE, CURRENT_TIME, 'Novo', 0, p_id_funcionario, p_id_cliente, p_id_mesa);
END;
$$;

-- AdicionarItemPedido: insere um produto no pedido e calcula o subtotal com base no preco atual.
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
BEGIN
    IF p_quantidade <= 0 THEN
        RAISE EXCEPTION 'A quantidade deve ser maior que zero.';
    END IF;

    SELECT valor_unitario
      INTO v_preco
      FROM produtos
     WHERE id = p_id_produto;

    IF v_preco IS NULL THEN
        RAISE EXCEPTION 'Produto % nao encontrado.', p_id_produto;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pedidos WHERE id = p_id_pedido) THEN
        RAISE EXCEPTION 'Pedido % nao encontrado.', p_id_pedido;
    END IF;

    SELECT COALESCE(MAX(id), 0) + 1 INTO v_novo_id FROM item_produto;

    INSERT INTO item_produto (id, id_pedido, id_produto, quantidade, valor_unitario, valor_total)
    VALUES (v_novo_id, p_id_pedido, p_id_produto, p_quantidade, v_preco, v_preco * p_quantidade);
END;
$$;

-- FecharCaixaDia: consolida as vendas de uma data e grava um resumo financeiro.
DROP FUNCTION IF EXISTS FecharCaixaDia(DATE);
CREATE OR REPLACE PROCEDURE FecharCaixaDia(p_data DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO resumo_caixa_dia (
        data_caixa,
        total_pedidos,
        faturamento_bruto,
        total_pix,
        total_cartao,
        total_dinheiro,
        ticket_medio,
        gerado_em
    )
    SELECT
        p_data AS data_caixa,
        COUNT(DISTINCT p.id)::INTEGER AS total_pedidos,
        COALESCE(SUM(pg.valor_pago), 0) AS faturamento_bruto,
        COALESCE(SUM(pg.valor_pago) FILTER (WHERE mp.forma_transacao ILIKE 'PIX'), 0) AS total_pix,
        COALESCE(SUM(pg.valor_pago) FILTER (WHERE mp.forma_transacao ILIKE 'Cart%'), 0) AS total_cartao,
        COALESCE(SUM(pg.valor_pago) FILTER (WHERE mp.forma_transacao ILIKE 'Dinheiro'), 0) AS total_dinheiro,
        COALESCE(ROUND(COALESCE(SUM(pg.valor_pago), 0) / NULLIF(COUNT(DISTINCT p.id), 0), 2), 0) AS ticket_medio,
        CURRENT_TIMESTAMP AS gerado_em
    FROM pedidos p
    LEFT JOIN pagamentos pg ON pg.id_pedido = p.id
    LEFT JOIN metodos_pagamento mp ON mp.id = pg.id_metodo
    WHERE p.data = p_data
      AND p.status = 'Finalizado'
    ON CONFLICT (data_caixa) DO UPDATE SET
        total_pedidos = EXCLUDED.total_pedidos,
        faturamento_bruto = EXCLUDED.faturamento_bruto,
        total_pix = EXCLUDED.total_pix,
        total_cartao = EXCLUDED.total_cartao,
        total_dinheiro = EXCLUDED.total_dinheiro,
        ticket_medio = EXCLUDED.ticket_medio,
        gerado_em = CURRENT_TIMESTAMP;
END;
$$;

-- Triggers

-- ImpedirVendaSemEstoque: cancela a insercao quando nao ha estoque suficiente.
CREATE OR REPLACE FUNCTION fn_impedir_venda_sem_estoque()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_estoque INT;
BEGIN
    SELECT estoque INTO v_estoque
      FROM produtos
     WHERE id = NEW.id_produto;

    IF v_estoque IS NULL THEN
        RAISE EXCEPTION 'Produto % nao encontrado.', NEW.id_produto;
    END IF;

    IF NEW.quantidade <= 0 THEN
        RAISE EXCEPTION 'A quantidade deve ser maior que zero.';
    END IF;

    IF NEW.quantidade > v_estoque THEN
        RAISE EXCEPTION 'Estoque insuficiente para o produto %. Disponivel: %, solicitado: %.',
            NEW.id_produto, v_estoque, NEW.quantidade;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS ImpedirVendaSemEstoque ON item_produto;
CREATE TRIGGER ImpedirVendaSemEstoque
BEFORE INSERT ON item_produto
FOR EACH ROW
EXECUTE FUNCTION fn_impedir_venda_sem_estoque();

-- BaixaEstoqueAutomatica: diminui o estoque assim que o item entra no pedido.
CREATE OR REPLACE FUNCTION fn_baixa_estoque_automatica()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE produtos
       SET estoque = estoque - NEW.quantidade
     WHERE id = NEW.id_produto;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS BaixaEstoqueAutomatica ON item_produto;
CREATE TRIGGER BaixaEstoqueAutomatica
AFTER INSERT ON item_produto
FOR EACH ROW
EXECUTE FUNCTION fn_baixa_estoque_automatica();

-- AtualizarValorTotalPedido: recalcula o valor total do pedido quando itens mudam.
CREATE OR REPLACE FUNCTION fn_atualizar_valor_total_pedido()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_pedido INT;
BEGIN
    IF TG_OP = 'DELETE' THEN
        v_id_pedido := OLD.id_pedido;
    ELSE
        v_id_pedido := NEW.id_pedido;
    END IF;

    UPDATE pedidos
       SET valor_total = (
           SELECT COALESCE(SUM(valor_total), 0)
             FROM item_produto
            WHERE id_pedido = v_id_pedido
       )
     WHERE id = v_id_pedido;

    IF TG_OP = 'UPDATE' AND OLD.id_pedido <> NEW.id_pedido THEN
        UPDATE pedidos
           SET valor_total = (
               SELECT COALESCE(SUM(valor_total), 0)
                 FROM item_produto
                WHERE id_pedido = OLD.id_pedido
           )
         WHERE id = OLD.id_pedido;
    END IF;

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS AtualizarValorTotalPedido ON item_produto;
CREATE TRIGGER AtualizarValorTotalPedido
AFTER INSERT OR UPDATE OR DELETE ON item_produto
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_valor_total_pedido();

-- Inicializa o valor_total dos pedidos ja cadastrados antes da criacao dos triggers.
UPDATE pedidos p
   SET valor_total = COALESCE((
       SELECT SUM(ip.valor_total)
         FROM item_produto ip
        WHERE ip.id_pedido = p.id
   ), 0);

-- Functions

-- CalcularTroco: recebe o valor do pedido e o valor pago, retornando a diferenca.
CREATE OR REPLACE FUNCTION CalcularTroco(
    p_valor_pedido NUMERIC(12,2),
    p_valor_pago NUMERIC(12,2)
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN p_valor_pago - p_valor_pedido;
END;
$$;

-- ProdutoMaisVendido: retorna o nome do produto com maior saida em um intervalo.
CREATE OR REPLACE FUNCTION ProdutoMaisVendido(
    p_data_inicio DATE,
    p_data_fim DATE
)
RETURNS VARCHAR(80)
LANGUAGE plpgsql
AS $$
DECLARE
    v_produto VARCHAR(80);
BEGIN
    SELECT pr.nome
      INTO v_produto
      FROM item_produto ip
      JOIN produtos pr ON pr.id = ip.id_produto
      JOIN pedidos pe ON pe.id = ip.id_pedido
     WHERE pe.data BETWEEN p_data_inicio AND p_data_fim
       AND pe.status <> 'Cancelado'
     GROUP BY pr.id, pr.nome
     ORDER BY SUM(ip.quantidade) DESC, pr.nome
     LIMIT 1;

    RETURN v_produto;
END;
$$;

-- ComissaoFuncionario: calcula bonus percentual sobre vendas finalizadas do funcionario.
CREATE OR REPLACE FUNCTION ComissaoFuncionario(
    p_id_funcionario INT,
    p_data_inicio DATE,
    p_data_fim DATE,
    p_percentual NUMERIC(5,2) DEFAULT 5.00
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_vendas NUMERIC(12,2);
BEGIN
    SELECT COALESCE(SUM(pg.valor_pago), 0)
      INTO v_total_vendas
      FROM pedidos pe
      JOIN pagamentos pg ON pg.id_pedido = pe.id
     WHERE pe.id_funcionario = p_id_funcionario
       AND pe.status = 'Finalizado'
       AND pe.data BETWEEN p_data_inicio AND p_data_fim;

    RETURN ROUND(v_total_vendas * (p_percentual / 100), 2);
END;
$$;

-- Views

-- VendasPorMetodoPagamento: total faturado por metodo em cada dia.
CREATE OR REPLACE VIEW VendasPorMetodoPagamento AS
SELECT
    pg.data_pagamento AS data_venda,
    mp.forma_transacao AS metodo_pagamento,
    COALESCE(SUM(pg.valor_pago), 0) AS total_faturado
FROM pagamentos pg
JOIN metodos_pagamento mp ON mp.id = pg.id_metodo
GROUP BY pg.data_pagamento, mp.forma_transacao
ORDER BY pg.data_pagamento, mp.forma_transacao;

-- ProdutosParaReposicao: itens abaixo do limite critico de estoque.
CREATE OR REPLACE VIEW ProdutosParaReposicao AS
SELECT
    id,
    nome,
    estoque,
    valor_unitario
FROM produtos
WHERE estoque < 20
ORDER BY estoque ASC, nome;

-- DesempenhoVendasHora: volume de pedidos agrupado por faixa de horario.
CREATE OR REPLACE VIEW DesempenhoVendasHora AS
SELECT
    data,
    EXTRACT(HOUR FROM hora_pedido)::INT AS hora,
    COUNT(*) AS total_pedidos,
    COALESCE(SUM(valor_total), 0) AS valor_total_pedidos
FROM pedidos
WHERE status <> 'Cancelado'
GROUP BY data, EXTRACT(HOUR FROM hora_pedido)
ORDER BY data, hora;
