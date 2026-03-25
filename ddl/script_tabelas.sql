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
    status VARCHAR(50) NOT NULL,
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
    taxa_entrega NUMERIC(12,2) NOT NULL,
    status_entrega VARCHAR(30) NOT NULL,
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
    data_compra DATE NOT NULL,
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
