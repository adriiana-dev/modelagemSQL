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


--CadastrarObraCompleta: Insere simultaneamente um livro, seu autor e sua categoria.

CREATE OR REPLACE PROCEDURE cadastrar_obra_completa(p_titulo_livro varchar, p_nome_autor varchar, p_nome_categoria varchar)
 
LANGUAGE plpgsql

AS $procedure$

DECLARE
    v_id_autor INT;
    v_id_categoria INT;

BEGIN
    
    INSERT INTO autores (nome) VALUES (p_nome_autor) 
    RETURNING id INTO v_id_autor;

    INSERT INTO categorias (nome) VALUES (p_nome_categoria) 
    RETURNING id INTO v_id_categoria;

    INSERT INTO livros (titulo, id_autor, id_categoria)
    VALUES (p_titulo_livro, v_id_autor, v_id_categoria);
END;
$procedure$
;


