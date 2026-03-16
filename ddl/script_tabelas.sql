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
DROP TABLE IF EXISTS escala_trabalho CASCADE;
DROP TABLE IF EXISTS avaliacoes CASCADE;

CREATE TABLE categorias (
    id_unico SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(80) NOT NULL
);

CREATE TABLE metodos_pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    formas_transacao VARCHAR(30) NOT NULL
);

CREATE TABLE funcionarios (
    cpf CHAR(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    cargo VARCHAR(40) NOT NULL,
    login_usuario VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE clientes (
    cpf CHAR(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL UNIQUE,
    endereco VARCHAR(150),
    data_cadastro DATE NOT NULL
);

CREATE TABLE mesas (
    numero_mesa SERIAL PRIMARY KEY,
    capacidade INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE entregadores (
    id_entregador SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    placa_veiculo CHAR(8) NOT NULL UNIQUE
);

CREATE TABLE fornecedores (
    cnpj CHAR(14) PRIMARY KEY,
    nome_fantasia VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE ingredientes (
    id_ingrediente SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    estoque_atual NUMERIC(10,2) NOT NULL CHECK (estoque_atual >= 0)
);

CREATE TABLE turnos (
    id_turno SERIAL PRIMARY KEY,
    nome_turno VARCHAR(30) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL
);

CREATE TABLE promocoes (
    id_promocao SERIAL PRIMARY KEY,
    nome_promocao VARCHAR(80) NOT NULL,
    desconto_percentual NUMERIC(5,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    valor_unitario NUMERIC(12,2) NOT NULL,
    estoque INTEGER NOT NULL CHECK (estoque >= 0),
    id_categoria INTEGER NOT NULL, 
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_unico) ON DELETE RESTRICT
);

CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    cpf_funcionario CHAR(11) NOT NULL, 
    cpf_cliente CHAR(11), 
    numero_mesa INTEGER, 
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionarios(cpf) ON DELETE RESTRICT,
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf) ON DELETE SET NULL,
    FOREIGN KEY (numero_mesa) REFERENCES mesas(numero_mesa) ON DELETE SET NULL
);

CREATE TABLE item_produto (
    id_item SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL, 
    id_produto INTEGER NOT NULL, 
    quantidade INTEGER NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE RESTRICT
);

CREATE TABLE entregas (
    id_entrega SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_entregador INTEGER NOT NULL,
    endereco_destino VARCHAR(150) NOT NULL,
    taxa_entrega NUMERIC(12,2) NOT NULL,
    status_entrega VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_entregador) REFERENCES entregadores(id_entregador) ON DELETE RESTRICT
);

CREATE TABLE receitas (
    id_receita SERIAL PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,
    quantidade_necessaria NUMERIC(10,2) NOT NULL,
    modo_de_preparo VARCHAR(200) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente) ON DELETE CASCADE
);

CREATE TABLE compras_estoque (
    id_compra SERIAL PRIMARY KEY,
    cnpj_fornecedor CHAR(14) NOT NULL,
    data_compra DATE NOT NULL,
    valor_total NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (cnpj_fornecedor) REFERENCES fornecedores(cnpj) ON DELETE RESTRICT
);

CREATE TABLE itens_compra (
    id_item_compra SERIAL PRIMARY KEY,
    id_compra INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,
    quantidade NUMERIC(10,2) NOT NULL,
    preco_unitario NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES compras_estoque(id_compra) ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente) ON DELETE RESTRICT
);

CREATE TABLE pagamentos (
    id_pagamento_realizado SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_pagamento INTEGER NOT NULL,
    valor_pago NUMERIC(12,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_pagamento) REFERENCES metodos_pagamento(id_pagamento) ON DELETE RESTRICT
);

CREATE TABLE escala_trabalho (
    id_escala SERIAL PRIMARY KEY,
    cpf_funcionario CHAR(11) NOT NULL,
    id_turno INTEGER NOT NULL,
    data_escala DATE NOT NULL,
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionarios(cpf) ON DELETE CASCADE,
    FOREIGN KEY (id_turno) REFERENCES turnos(id_turno) ON DELETE CASCADE
);

CREATE TABLE avaliacoes (
    id_avaliacao SERIAL PRIMARY KEY,
    cpf_cliente CHAR(11) NOT NULL,
    id_pedido INTEGER NOT NULL,
    nota INTEGER NOT NULL CHECK (nota >= 1 AND nota <= 5),
    comentario VARCHAR(200),
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf) ON DELETE SET NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE
);

