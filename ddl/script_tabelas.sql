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

CREATE TABLE produtos (
    codigo_produto INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    valor_unitario NUMERIC(12,2) NOT NULL,
    estoque INTEGER NOT NULL,
    codigo_categorias INTEGER NOT NULL
);

CREATE TABLE pedidos (
    codigo_pedido INTEGER PRIMARY KEY,
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    cpf_funcionario VARCHAR(14) NOT NULL
);

CREATE TABLE item_produto (
    codigo_item INTEGER PRIMARY KEY,
    pedido INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    valor NUMERIC(12,2) NOT NULL
);
