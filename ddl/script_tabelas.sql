CREATE DATABASE lanchonete;


CREATE TABLE categorias (
    codigo_unico INTEGER PRIMARY KEY,
    nome_categoria VARCHAR(80) NOT NULL
);

CREATE TABLE metodos_pagamento (
    codigo_pagamento INTEGER PRIMARY KEY,
    formas_transacao VARCHAR(30) NOT NULL
);

CREATE TABLE funcionarios (
    cpf CHARACTER(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    cargo VARCHAR(40) NOT NULL,
    login_usuario VARCHAR(20) NOT NULL
);

CREATE TABLE clientes (
    cpf CHARACTER(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    endereco VARCHAR(150),
    data_cadastro DATE NOT NULL
);

CREATE TABLE mesas (
    numero_mesa INTEGER PRIMARY KEY,
    capacidade INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE produtos (
    codigo_produto INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    valor_unitario NUMERIC(12,2) NOT NULL,
    estoque INTEGER NOT NULL,
    codigo_categoria INTEGER NOT NULL, 
    FOREIGN KEY (codigo_categoria) REFERENCES categorias(codigo_unico)
);

CREATE TABLE pedidos (
    codigo_pedido INTEGER PRIMARY KEY,
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    cpf_funcionario CHARACTER(11) NOT NULL, 
    cpf_cliente CHARACTER(11), 
    numero_mesa INTEGER, 
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionarios(cpf),
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf),
    FOREIGN KEY (numero_mesa) REFERENCES mesas(numero_mesa)
);

CREATE TABLE item_produto (
    codigo_item INTEGER PRIMARY KEY,
    codigo_pedido INTEGER NOT NULL, 
    codigo_produto INTEGER NOT NULL, 
    quantidade INTEGER NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (codigo_pedido) REFERENCES pedidos(codigo_pedido),
    FOREIGN KEY (codigo_produto) REFERENCES produtos(codigo_produto)
);


CREATE TABLE entregadores (
    codigo_entregador INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    placa_veiculo VARCHAR(10) NOT NULL
);

CREATE TABLE entregas (
    codigo_entrega INTEGER PRIMARY KEY,
    codigo_pedido INTEGER NOT NULL,
    codigo_entregador INTEGER NOT NULL,
    endereco_destino VARCHAR(150) NOT NULL,
    taxa_entrega NUMERIC(12,2) NOT NULL,
    status_entrega VARCHAR(30) NOT NULL,
    FOREIGN KEY (codigo_pedido) REFERENCES pedidos(codigo_pedido),
    FOREIGN KEY (codigo_entregador) REFERENCES entregadores(codigo_entregador)
);

CREATE TABLE fornecedores (
    cnpj CHARACTER(14) PRIMARY KEY,
    nome_fantasia VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(80) NOT NULL
);

CREATE TABLE ingredientes (
    codigo_ingrediente INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    estoque_atual NUMERIC(10,2) NOT NULL
);

CREATE TABLE receitas (
    codigo_receita INTEGER PRIMARY KEY,
    codigo_produto INTEGER NOT NULL,
    codigo_ingrediente INTEGER NOT NULL,
    quantidade_necessaria NUMERIC(10,2) NOT NULL,
    modo_de_preparo VARCHAR(200) NOT NULL,
    FOREIGN KEY (codigo_produto) REFERENCES produtos(codigo_produto),
    FOREIGN KEY (codigo_ingrediente) REFERENCES ingredientes(codigo_ingrediente)
);

CREATE TABLE compras_estoque (
    codigo_compra INTEGER PRIMARY KEY,
    cnpj_fornecedor CHARACTER(14) NOT NULL,
    data_compra DATE NOT NULL,
    valor_total NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (cnpj_fornecedor) REFERENCES fornecedores(cnpj)
);

CREATE TABLE itens_compra (
    codigo_item_compra INTEGER PRIMARY KEY,
    codigo_compra INTEGER NOT NULL,
    codigo_ingrediente INTEGER NOT NULL,
    quantidade NUMERIC(10,2) NOT NULL,
    preco_unitario NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (codigo_compra) REFERENCES compras_estoque(codigo_compra),
    FOREIGN KEY (codigo_ingrediente) REFERENCES ingredientes(codigo_ingrediente)
);

CREATE TABLE pagamentos (
    codigo_pagamento_realizado INTEGER PRIMARY KEY,
    codigo_pedido INTEGER NOT NULL,
    codigo_pagamento INTEGER NOT NULL,
    valor_pago NUMERIC(12,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (codigo_pedido) REFERENCES pedidos(codigo_pedido),
    FOREIGN KEY (codigo_pagamento) REFERENCES metodos_pagamento(codigo_pagamento)
);

CREATE TABLE turnos (
    codigo_turno INTEGER PRIMARY KEY,
    nome_turno VARCHAR(30) NOT NULL,
    horario_inicio VARCHAR(10) NOT NULL,
    horario_fim VARCHAR(10) NOT NULL
);

CREATE TABLE escala_trabalho (
    codigo_escala INTEGER PRIMARY KEY,
    cpf_funcionario CHARACTER(11) NOT NULL,
    codigo_turno INTEGER NOT NULL,
    data_escala DATE NOT NULL,
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionarios(cpf),
    FOREIGN KEY (codigo_turno) REFERENCES turnos(codigo_turno)
);

CREATE TABLE promocoes (
    codigo_promocao INTEGER PRIMARY KEY,
    nome_promocao VARCHAR(80) NOT NULL,
    desconto_percentual NUMERIC(5,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL
);

CREATE TABLE avaliacoes (
    codigo_avaliacao INTEGER PRIMARY KEY,
    cpf_cliente CHARACTER(11) NOT NULL,
    codigo_pedido INTEGER NOT NULL,
    nota INTEGER NOT NULL,
    comentario VARCHAR(200),
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf),
    FOREIGN KEY (codigo_pedido) REFERENCES pedidos(codigo_pedido)
);

