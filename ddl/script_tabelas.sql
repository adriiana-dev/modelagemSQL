DROP VIEW IF EXISTS desempenho_vendas_hora CASCADE;
DROP VIEW IF EXISTS produtos_para_reposicao CASCADE;
DROP VIEW IF EXISTS vendas_por_metodo_pagamento CASCADE;

DROP PROCEDURE IF EXISTS abrirpedido(INT, INT, INT);
DROP PROCEDURE IF EXISTS adicionaritempedido(INT, INT, INT);
DROP PROCEDURE IF EXISTS fecharcaixadia(DATE);

DROP FUNCTION IF EXISTS calculartroco(NUMERIC, NUMERIC);
DROP FUNCTION IF EXISTS produtomaisvendido(DATE, DATE);
DROP FUNCTION IF EXISTS comissaofuncionario(INT, DATE, DATE, NUMERIC);
DROP FUNCTION IF EXISTS impedir_venda_sem_estoque_fn();
DROP FUNCTION IF EXISTS baixa_estoque_automatica_fn();
DROP FUNCTION IF EXISTS atualizar_valor_total_pedido_fn();

DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS metodos_pagamento CASCADE;
DROP TABLE IF EXISTS funcionarios CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS mesas CASCADE;
DROP TABLE IF EXISTS entregadores CASCADE;
DROP TABLE IF EXISTS fornecedores CASCADE;
DROP TABLE IF EXISTS ingredientes CASCADE;
DROP TABLE IF EXISTS turnos CASCADE;
DROP TABLE IF EXISTS promocoes CASCADE;
DROP TABLE IF EXISTS produtos CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS item_produto CASCADE;
DROP TABLE IF EXISTS entregas CASCADE;
DROP TABLE IF EXISTS receitas CASCADE;
DROP TABLE IF EXISTS compras_estoque CASCADE;
DROP TABLE IF EXISTS itens_compra CASCADE;
DROP TABLE IF EXISTS pagamentos CASCADE;
DROP TABLE IF EXISTS fechamentos_caixa CASCADE;
DROP TABLE IF EXISTS escala_trabalho CASCADE;
DROP TABLE IF EXISTS avaliacoes CASCADE;

CREATE TABLE categorias (
    id INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL
);

CREATE TABLE metodos_pagamento (
    id INT PRIMARY KEY,
    forma_transacao VARCHAR(30) NOT NULL
);

CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    cpf CHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(80) NOT NULL,
    cargo VARCHAR(40) NOT NULL,
    login_usuario VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    cpf CHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL UNIQUE,
    endereco VARCHAR(150),
    data_cadastro DATE NOT NULL
);

CREATE TABLE mesas (
    id INT PRIMARY KEY,
    capacidade INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE entregadores (
    id INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    placa_veiculo CHAR(8) NOT NULL UNIQUE
);

CREATE TABLE fornecedores (
    id INT PRIMARY KEY,
    cnpj CHAR(14) UNIQUE NOT NULL,
    nome_fantasia VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE ingredientes (
    id INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    estoque_atual NUMERIC(10,2) NOT NULL CHECK (estoque_atual >= 0)
);

CREATE TABLE turnos (
    id INT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL
);

CREATE TABLE promocoes (
    id INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    desconto NUMERIC(5,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL
);

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    valor_unitario NUMERIC(12,2) NOT NULL,
    estoque INTEGER NOT NULL CHECK (estoque >= 0),
    id_categoria INT NOT NULL, 
    FOREIGN KEY (id_categoria) REFERENCES categorias(id) ON DELETE RESTRICT
   
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    data DATE NOT NULL,
    hora_pedido TIME NOT NULL DEFAULT CURRENT_TIME,
    status VARCHAR(50) NOT NULL,
    valor_total NUMERIC(12,2) NOT NULL DEFAULT 0.00,
    id_funcionario INT NOT NULL, 
    id_cliente INT, 
    id_mesa INT, 
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (id_mesa) REFERENCES mesas(id)
);

CREATE TABLE item_produto (
    id INT PRIMARY KEY,
    id_pedido INT NOT NULL, 
    id_produto INT NOT NULL, 
    quantidade INTEGER NOT NULL,
    valor_unitario NUMERIC(12,2) NOT NULL,
    valor_total NUMERIC(12,2) NOT NULL, 
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

CREATE TABLE entregas (
    id INT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_entregador INT NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    taxa  NUMERIC(12,2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_entregador) REFERENCES entregadores(id)
);

CREATE TABLE receitas (
    id INT PRIMARY KEY,
    id_produto INT NOT NULL,
    id_ingrediente INT NOT NULL,
    quantidade_necessaria NUMERIC(10,2) NOT NULL,
    preparo VARCHAR(200) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id) ON DELETE CASCADE
);

CREATE TABLE compras_estoque (
    id INT PRIMARY KEY,
    id_fornecedor INT NOT NULL,
    data  DATE NOT NULL,
    valor_total NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id)
);

CREATE TABLE itens_compra (
    id INT PRIMARY KEY,
    id_compra INT NOT NULL,
    id_ingrediente INT NOT NULL,
    quantidade NUMERIC(10,2) NOT NULL,
    valor_unitario NUMERIC(12,2) NOT NULL,
    valor_total NUMERIC(12,2) NOT NULL, 
    FOREIGN KEY (id_compra) REFERENCES compras_estoque(id) ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id) ON DELETE RESTRICT
);

CREATE TABLE pagamentos (
    id INT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_metodo INT NOT NULL, 
    valor_pago NUMERIC(12,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_metodo) REFERENCES metodos_pagamento(id) ON DELETE RESTRICT
);

CREATE TABLE fechamentos_caixa (
    id INT PRIMARY KEY,
    data_fechamento DATE NOT NULL UNIQUE,
    total_pedidos INT NOT NULL,
    total_faturado NUMERIC(12,2) NOT NULL,
    total_pix NUMERIC(12,2) NOT NULL,
    total_cartao NUMERIC(12,2) NOT NULL,
    total_dinheiro NUMERIC(12,2) NOT NULL,
    gerado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE escala_trabalho (
    id INT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_turno INT NOT NULL,
    data_escala DATE NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id) ON DELETE RESTRICT,
    FOREIGN KEY (id_turno) REFERENCES turnos(id) ON DELETE RESTRICT
);


CREATE TABLE avaliacoes (
    id INT PRIMARY KEY,
    id_cliente INT,
    id_pedido INT NOT NULL,
    nota INTEGER NOT NULL CHECK (nota >= 1 AND nota <= 5),
    comentario VARCHAR(200),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id) ON DELETE SET NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE CASCADE
);

-- FUNCTIONS
CREATE OR REPLACE FUNCTION calculartroco(
    p_valor_pedido NUMERIC,
    p_valor_pago NUMERIC
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN ROUND(p_valor_pago - p_valor_pedido, 2);
END;
$$;

CREATE OR REPLACE FUNCTION produtomaisvendido(
    p_data_inicio DATE,
    p_data_fim DATE
)
RETURNS VARCHAR(80)
LANGUAGE plpgsql
AS $$
DECLARE
    v_nome_produto VARCHAR(80);
BEGIN
    SELECT pr.nome
    INTO v_nome_produto
    FROM item_produto ip
    JOIN produtos pr ON pr.id = ip.id_produto
    JOIN pedidos pe ON pe.id = ip.id_pedido
    WHERE pe.data BETWEEN p_data_inicio AND p_data_fim
      AND pe.status <> 'Cancelado'
    GROUP BY pr.id, pr.nome
    ORDER BY SUM(ip.quantidade) DESC, pr.nome
    LIMIT 1;

    RETURN v_nome_produto;
END;
$$;

CREATE OR REPLACE FUNCTION comissaofuncionario(
    p_id_funcionario INT,
    p_data_inicio DATE,
    p_data_fim DATE,
    p_percentual NUMERIC DEFAULT 5.00
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_vendas NUMERIC(12,2);
BEGIN
    SELECT COALESCE(SUM(pe.valor_total), 0)
    INTO v_total_vendas
    FROM pedidos pe
    WHERE pe.id_funcionario = p_id_funcionario
      AND pe.data BETWEEN p_data_inicio AND p_data_fim
      AND pe.status <> 'Cancelado';

    RETURN ROUND(v_total_vendas * (p_percentual / 100), 2);
END;
$$;

-- PROCEDURES
CREATE OR REPLACE PROCEDURE abrirpedido(
    p_id_funcionario INT,
    p_id_cliente INT DEFAULT NULL,
    p_id_mesa INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_pedido INT;
BEGIN
    SELECT COALESCE(MAX(id), 0) + 1
    INTO v_id_pedido
    FROM pedidos;

    INSERT INTO pedidos (id, data, hora_pedido, status, valor_total, id_funcionario, id_cliente, id_mesa)
    VALUES (v_id_pedido, CURRENT_DATE, CURRENT_TIME, 'Aberto', 0.00, p_id_funcionario, p_id_cliente, p_id_mesa);
END;
$$;

CREATE OR REPLACE PROCEDURE adicionaritempedido(
    p_id_pedido INT,
    p_id_produto INT,
    p_quantidade INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_item INT;
    v_valor_unitario NUMERIC(12,2);
BEGIN
    IF p_quantidade <= 0 THEN
        RAISE EXCEPTION 'A quantidade do item deve ser maior que zero.';
    END IF;

    SELECT valor_unitario
    INTO v_valor_unitario
    FROM produtos
    WHERE id = p_id_produto;

    IF v_valor_unitario IS NULL THEN
        RAISE EXCEPTION 'Produto % nao encontrado.', p_id_produto;
    END IF;

    SELECT COALESCE(MAX(id), 0) + 1
    INTO v_id_item
    FROM item_produto;

    INSERT INTO item_produto (id, id_pedido, id_produto, quantidade, valor_unitario, valor_total)
    VALUES (v_id_item, p_id_pedido, p_id_produto, p_quantidade, v_valor_unitario, p_quantidade * v_valor_unitario);
END;
$$;

CREATE OR REPLACE PROCEDURE fecharcaixadia(
    p_data DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_fechamento INT;
BEGIN
    SELECT COALESCE(MAX(id), 0) + 1
    INTO v_id_fechamento
    FROM fechamentos_caixa;

    INSERT INTO fechamentos_caixa (
        id,
        data_fechamento,
        total_pedidos,
        total_faturado,
        total_pix,
        total_cartao,
        total_dinheiro
    )
    SELECT
        v_id_fechamento,
        p_data,
        COUNT(DISTINCT pe.id),
        COALESCE(SUM(pg.valor_pago), 0),
        COALESCE(SUM(CASE WHEN UPPER(mp.forma_transacao) = 'PIX' THEN pg.valor_pago ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN UPPER(mp.forma_transacao) LIKE 'CART%' THEN pg.valor_pago ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN UPPER(mp.forma_transacao) = 'DINHEIRO' THEN pg.valor_pago ELSE 0 END), 0)
    FROM pedidos pe
    LEFT JOIN pagamentos pg ON pg.id_pedido = pe.id
    LEFT JOIN metodos_pagamento mp ON mp.id = pg.id_metodo
    WHERE pe.data = p_data
      AND pe.status <> 'Cancelado'
    ON CONFLICT (data_fechamento)
    DO UPDATE SET
        total_pedidos = EXCLUDED.total_pedidos,
        total_faturado = EXCLUDED.total_faturado,
        total_pix = EXCLUDED.total_pix,
        total_cartao = EXCLUDED.total_cartao,
        total_dinheiro = EXCLUDED.total_dinheiro,
        gerado_em = CURRENT_TIMESTAMP;
END;
$$;

-- TRIGGERS
CREATE OR REPLACE FUNCTION impedir_venda_sem_estoque_fn()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_estoque_atual INT;
BEGIN
    IF NEW.quantidade <= 0 THEN
        RAISE EXCEPTION 'A quantidade vendida deve ser maior que zero.';
    END IF;

    SELECT estoque
    INTO v_estoque_atual
    FROM produtos
    WHERE id = NEW.id_produto;

    IF v_estoque_atual IS NULL THEN
        RAISE EXCEPTION 'Produto % nao encontrado.', NEW.id_produto;
    END IF;

    IF NEW.quantidade > v_estoque_atual THEN
        RAISE EXCEPTION 'Estoque insuficiente para o produto %. Disponivel: %, solicitado: %.',
            NEW.id_produto, v_estoque_atual, NEW.quantidade;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER impedirvendasemestoque
BEFORE INSERT ON item_produto
FOR EACH ROW
EXECUTE FUNCTION impedir_venda_sem_estoque_fn();

CREATE OR REPLACE FUNCTION baixa_estoque_automatica_fn()
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

CREATE TRIGGER baixaestoqueautomatica
AFTER INSERT ON item_produto
FOR EACH ROW
EXECUTE FUNCTION baixa_estoque_automatica_fn();

CREATE OR REPLACE FUNCTION atualizar_valor_total_pedido_fn()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP IN ('UPDATE', 'DELETE') THEN
        UPDATE pedidos
        SET valor_total = (
            SELECT COALESCE(SUM(valor_total), 0)
            FROM item_produto
            WHERE id_pedido = OLD.id_pedido
        )
        WHERE id = OLD.id_pedido;
    END IF;

    IF TG_OP IN ('INSERT', 'UPDATE') THEN
        UPDATE pedidos
        SET valor_total = (
            SELECT COALESCE(SUM(valor_total), 0)
            FROM item_produto
            WHERE id_pedido = NEW.id_pedido
        )
        WHERE id = NEW.id_pedido;

        RETURN NEW;
    END IF;

    RETURN OLD;
END;
$$;

CREATE TRIGGER atualizarvalortotalpedido
AFTER INSERT OR UPDATE OR DELETE ON item_produto
FOR EACH ROW
EXECUTE FUNCTION atualizar_valor_total_pedido_fn();

-- VIEWS
CREATE OR REPLACE VIEW vendas_por_metodo_pagamento AS
SELECT
    pg.data_pagamento,
    SUM(CASE WHEN UPPER(mp.forma_transacao) = 'PIX' THEN pg.valor_pago ELSE 0 END) AS total_pix,
    SUM(CASE WHEN UPPER(mp.forma_transacao) LIKE 'CART%' THEN pg.valor_pago ELSE 0 END) AS total_cartao,
    SUM(CASE WHEN UPPER(mp.forma_transacao) = 'DINHEIRO' THEN pg.valor_pago ELSE 0 END) AS total_dinheiro,
    SUM(pg.valor_pago) AS total_faturado
FROM pagamentos pg
JOIN metodos_pagamento mp ON mp.id = pg.id_metodo
GROUP BY pg.data_pagamento
ORDER BY pg.data_pagamento;

CREATE OR REPLACE VIEW produtos_para_reposicao AS
SELECT
    id,
    nome,
    estoque,
    CASE
        WHEN estoque <= 10 THEN 'Critico'
        WHEN estoque <= 20 THEN 'Baixo'
        ELSE 'Regular'
    END AS nivel_reposicao
FROM produtos
WHERE estoque <= 20
ORDER BY estoque, nome;

CREATE OR REPLACE VIEW desempenho_vendas_hora AS
SELECT
    pe.data,
    EXTRACT(HOUR FROM pe.hora_pedido)::INT AS hora,
    COUNT(DISTINCT pe.id) AS total_pedidos,
    COALESCE(SUM(pe.valor_total), 0) AS total_vendido
FROM pedidos pe
WHERE pe.status <> 'Cancelado'
GROUP BY pe.data, EXTRACT(HOUR FROM pe.hora_pedido)
ORDER BY pe.data, hora;
