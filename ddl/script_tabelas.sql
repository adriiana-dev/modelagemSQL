CREATE DATABASE lanchonete;

DROP TABLE IF EXISTS categorias;
CREATE TABLE categorias (
    id_unico INTEGER PRIMARY KEY,
    nome_categoria VARCHAR(80) NOT NULL
);

DROP TABLE IF EXISTS metodos_pagamento;
CREATE TABLE metodos_pagamento (
    id_pagamento INTEGER PRIMARY KEY,
    formas_transacao VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS funcionarios;
CREATE TABLE funcionarios (
    cpf VARCHAR(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    cargo VARCHAR(40) NOT NULL,
    login_usuario VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    cpf VARCHAR(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    endereco VARCHAR(150),
    data_cadastro DATE NOT NULL
);

DROP TABLE IF EXISTS mesas;
CREATE TABLE mesas (
    numero_mesa INTEGER PRIMARY KEY,
    capacidade INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS produtos;
CREATE TABLE produtos (
    id_produto INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    valor_unitario NUMERIC(12,2) NOT NULL,
    estoque INTEGER NOT NULL,
    id_categoria INTEGER NOT NULL, 
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_unico)
);

DROP TABLE IF EXISTS pedidos;
CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    cpf_funcionario VARCHAR(11) NOT NULL, 
    cpf_cliente VARCHAR(11), 
    numero_mesa INTEGER, 
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionarios(cpf),
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf),
    FOREIGN KEY (numero_mesa) REFERENCES mesas(numero_mesa)
);

DROP TABLE IF EXISTS item_produto;
CREATE TABLE item_produto (
    id_item INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL, 
    id_produto INTEGER NOT NULL, 
    quantidade INTEGER NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

DROP TABLE IF EXISTS entregadores;
CREATE TABLE entregadores (
    id_entregador INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    placa_veiculo VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS entregas;
CREATE TABLE entregas (
    id_entrega INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_entregador INTEGER NOT NULL,
    endereco_destino VARCHAR(150) NOT NULL,
    taxa_entrega NUMERIC(12,2) NOT NULL,
    status_entrega VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_entregador) REFERENCES entregadores(id_entregador)
);

DROP TABLE IF EXISTS fornecedores;
CREATE TABLE fornecedores (
    cnpj VARCHAR(14) PRIMARY KEY,
    nome_fantasia VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(80) NOT NULL
);

DROP TABLE IF EXISTS ingredientes;
CREATE TABLE ingredientes (
    id_ingrediente INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    estoque_atual NUMERIC(10,2) NOT NULL
);

DROP TABLE IF EXISTS receitas;
CREATE TABLE receitas (
    id_receita INTEGER PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,
    quantidade_necessaria NUMERIC(10,2) NOT NULL,
    modo_de_preparo VARCHAR(200) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)
);

DROP TABLE IF EXISTS compras_estoque;
CREATE TABLE compras_estoque (
    id_compra INTEGER PRIMARY KEY,
    cnpj_fornecedor VARCHAR(14) NOT NULL,
    data_compra DATE NOT NULL,
    valor_total NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (cnpj_fornecedor) REFERENCES fornecedores(cnpj)
);

DROP TABLE IF EXISTS itens_compra;
CREATE TABLE itens_compra (
    id_item_compra INTEGER PRIMARY KEY,
    id_compra INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,
    quantidade NUMERIC(10,2) NOT NULL,
    preco_unitario NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES compras_estoque(id_compra),
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)
);

DROP TABLE IF EXISTS pagamentos;
CREATE TABLE pagamentos (
    id_pagamento_realizado INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_pagamento INTEGER NOT NULL,
    valor_pago NUMERIC(12,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_pagamento) REFERENCES metodos_pagamento(id_pagamento)
);

DROP TABLE IF EXISTS turnos;
CREATE TABLE turnos (
    id_turno INTEGER PRIMARY KEY,
    nome_turno VARCHAR(30) NOT NULL,
    horario_inicio VARCHAR(10) NOT NULL,
    horario_fim VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS escala_trabalho;
CREATE TABLE escala_trabalho (
    id_escala INTEGER PRIMARY KEY,
    cpf_funcionario VARCHAR(11) NOT NULL,
    id_turno INTEGER NOT NULL,
    data_escala DATE NOT NULL,
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionarios(cpf),
    FOREIGN KEY (id_turno) REFERENCES turnos(id_turno)
);

DROP TABLE IF EXISTS promocoes;
CREATE TABLE promocoes (
    id_promocao INTEGER PRIMARY KEY,
    nome_promocao VARCHAR(80) NOT NULL,
    desconto_percentual NUMERIC(5,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL
);

DROP TABLE IF EXISTS avaliacoes;
CREATE TABLE avaliacoes (
    id_avaliacao INTEGER PRIMARY KEY,
    cpf_cliente VARCHAR(11) NOT NULL,
    id_pedido INTEGER NOT NULL,
    nota INTEGER NOT NULL,
    comentario VARCHAR(200),
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
