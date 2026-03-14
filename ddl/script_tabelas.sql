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
    login_usuario VARCHAR(20) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    cpf VARCHAR(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL UNIQUE,
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
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_unico) ON DELETE CASCADE
);

DROP TABLE IF EXISTS pedidos;
CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    cpf_funcionario VARCHAR(11) NOT NULL, 
    cpf_cliente VARCHAR(11), 
    numero_mesa INTEGER, 
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionarios(cpf) ON DELETE CASCADE,
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf) ON DELETE CASCADE,
    FOREIGN KEY (numero_mesa) REFERENCES mesas(numero_mesa) ON DELETE CASCADE
);

DROP TABLE IF EXISTS item_produto;
CREATE TABLE item_produto (
    id_item INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL, 
    id_produto INTEGER NOT NULL, 
    quantidade INTEGER NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE CASCADE
);

DROP TABLE IF EXISTS entregadores;
CREATE TABLE entregadores (
    id_entregador INTEGER PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    placa_veiculo VARCHAR(10) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS entregas;
CREATE TABLE entregas (
    id_entrega INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_entregador INTEGER NOT NULL,
    endereco_destino VARCHAR(150) NOT NULL,
    taxa_entrega NUMERIC(12,2) NOT NULL,
    status_entrega VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_entregador) REFERENCES entregadores(id_entregador) ON DELETE CASCADE
);

DROP TABLE IF EXISTS fornecedores;
CREATE TABLE fornecedores (
    cnpj VARCHAR(14) PRIMARY KEY,
    nome_fantasia VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(80) NOT NULL UNIQUE
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
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente) ON DELETE CASCADE
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
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_pagamento) REFERENCES metodos_pagamento(id_pagamento) ON DELETE CASCADE
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
    FOREIGN KEY (cpf_cliente) REFERENCES clientes(cpf) ON DELETE CASCADE,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE
);

INSERT INTO categorias (id_unico, nome_categoria) VALUES 
(1, 'Smash Burgers'), (2, 'Hambúrgueres Artesanais'), (3, 'Porções e Entradas'), 
(4, 'Bebidas Naturais e Refri'), (5, 'Sobremesas e Shakes');

INSERT INTO metodos_pagamento (id_pagamento, formas_transacao) VALUES 
(1, 'PIX'), (2, 'Cartão de Crédito (Master/Visa)'), (3, 'Cartão de Débito'), (4, 'Dinheiro (Com Troco)'), (5, 'Vale Refeição (VR/Alelo)');

INSERT INTO mesas (numero_mesa, capacidade, status) VALUES 
(1, 2, 'Livre'), (2, 4, 'Ocupada'), (3, 4, 'Livre'), 
(4, 6, 'Reservada'), (5, 2, 'Aguardando Limpeza');

INSERT INTO entregadores (id_entregador, nome, telefone, placa_veiculo) VALUES 
(1, 'Tiago "Moto-bala" Silva', '11977771111', 'RTL-8A99'), 
(2, 'Roberto Santos', '11977772222', 'QKW-2B34'), 
(3, 'Fernando Costa', '11977773333', 'PLM-9C12');

INSERT INTO fornecedores (cnpj, nome_fantasia, telefone, email) VALUES 
('12345678000199', 'Frigorífico Boi Nobre', '1130001010', 'vendas@boinobre.com.br'),
('98765432000188', 'Hortifruti Raiz', '1130002020', 'pedidos@hortiraiz.com.br'),
('45612378000177', 'Distribuidora Gela Guela', '1130003030', 'contato@gelaguela.com.br');

INSERT INTO ingredientes (id_ingrediente, nome, unidade_medida, estoque_atual) VALUES 
(1, 'Pão Brioche', 'Unidade', 150.00), (2, 'Blend Bovino Angus 160g', 'Unidade', 200.00),
(3, 'Queijo Cheddar Inglês', 'Fatia', 400.00), (4, 'Alface Americana', 'Maço', 15.00),
(5, 'Tomate Carmem', 'Kg', 12.00), (6, 'Bacon Defumado em Tiras', 'Kg', 18.00),
(7, 'Batata Crinkle', 'Kg', 80.00), (8, 'Maionese Verde da Casa', 'Litro', 5.00);

INSERT INTO turnos (id_turno, nome_turno, horario_inicio, horario_fim) VALUES 
(1, 'Abertura e Almoço', '10:00', '16:00'), 
(2, 'Happy Hour e Jantar', '16:00', '22:00'), 
(3, 'Madrugada', '22:00', '04:00');

INSERT INTO promocoes (id_promocao, nome_promocao, desconto_percentual, data_inicio, data_fim) VALUES 
(1, 'Terça do Smash em Dobro', 50.00, '2026-03-01', '2026-12-31'),
(2, 'Combo Galera (Sextou)', 15.00, '2026-03-06', '2026-03-06'),
(3, 'Mês de Aniversário', 10.00, '2026-03-01', '2026-03-31');

INSERT INTO funcionarios (cpf, nome_completo, cargo, login_usuario) VALUES 
('10101010101', 'Marina Oliveira', 'Gerente de Salão', 'marina.oli'),
('20202020202', 'Kleber "Chapa Quente" Dias', 'Chapeiro Master', 'kleber.chapa'),
('30303030303', 'Julia Mendes', 'Atendente/Caixa', 'julia.cx');

INSERT INTO clientes (cpf, nome_completo, telefone, endereco, data_cadastro) VALUES 
('11111111101', 'Lucas de Almeida Souza', '11988881001', 'Av. Getúlio Vargas, 1500, Apto 42', '2025-11-10'),
('11111111102', 'Mariana Castilho', '11988881002', 'Rua São Domingos, 45', '2025-11-15'),
('11111111103', 'Pedro Henrique Nogueira', '11988881003', 'Av. Maria Quitéria, 880', '2025-12-02'),
('11111111104', 'Juliana Costa e Silva', '11988881004', 'Rua Marechal Deodoro, 120, Casa 2', '2025-12-05'),
('11111111105', 'Fernanda Lima Botelho', '11988881005', 'Av. João Durval, 3400', '2025-12-10'),
('11111111106', 'Rafael "Rafa" Silva', '11988881006', 'Condomínio Parque das Árvores, Bloco C', '2026-01-05'),
('11111111107', 'Amanda Rocha', '11988881007', 'Rua Barão do Rio Branco, 55', '2026-01-08'),
('11111111108', 'Diego Martins Oliveira', '11988881008', 'Travessa dos Bandeirantes, 12', '2026-01-12'),
('11111111109', 'Carla Mendes Assis', '11988881009', 'Rua Visconde de Mauá, 909', '2026-01-15'),
('11111111110', 'Bruno Souza Ferreira', '11988881010', 'Av. Presidente Dutra, 2100', '2026-01-18'),
('11111111111', 'Camila Dias de Moraes', '11988881011', 'Rua Castro Alves, 33', '2026-01-20'),
('11111111112', 'Rodrigo Alves Pinto', '11988881012', 'Praça da Matriz, S/N', '2026-01-22'),
('11111111113', 'Tatiana Pires', '11988881013', 'Rua Voluntários da Pátria, 404', '2026-01-25'),
('11111111114', 'Thiago Gomes', '11988881014', 'Av. Sete de Setembro, 100', '2026-01-28'),
('11111111115', 'Patricia Melo', '11988881015', 'Rua do Comércio, 88', '2026-02-01'),
('11111111116', 'Leandro Ramos Junior', '11988881016', 'Residencial Flores, Apto 101', '2026-02-03'),
('11111111117', 'Aline Farias Peixoto', '11988881017', 'Rua Machado de Assis, 77', '2026-02-05'),
('11111111118', 'Gustavo Nogueira', '11988881018', 'Av. Brasil, 5000', '2026-02-10'),
('11111111119', 'Vanessa Moura', '11988881019', 'Alameda das Rosas, 21', '2026-02-12'),
('11111111120', 'Felipe Castro Barbosa', '11988881020', 'Rua da Consolação, 134', '2026-02-15'),
('11111111121', 'Renata Borges', '11988881021', 'Condomínio Vila Rica, Casa 5', '2026-02-18'),
('11111111122', 'Alexandre Vieira', '11988881022', 'Rua Tiradentes, 890', '2026-02-20'),
('11111111123', 'Sabrina Monteiro', '11988881023', 'Av. Independência, 303', '2026-02-22'),
('11111111124', 'Eduardo Peixoto', '11988881024', 'Rua Rui Barbosa, 15', '2026-02-25'),
('11111111125', 'Monica Assis', '11988881025', 'Travessa Bela Vista, 9', '2026-02-28'),
('11111111126', 'Ricardo Lopes', '11988881026', 'Rua Aurora, 456', '2026-03-01'),
('11111111127', 'Beatriz Campos', '11988881027', 'Edifício Central, Sala 20', '2026-03-03'),
('11111111128', 'Marcelo Barros', '11988881028', 'Av. dos Estados, 111', '2026-03-05'),
('11111111129', 'Larissa Freitas', '11988881029', 'Rua do Bosque, 73', '2026-03-08'),
('11111111130', 'Vinicius Moraes Neto', '11988881030', 'Loteamento Nova Esperança, Q2 L4', '2026-03-10');

-- 3.2 Produtos (Preços realistas e lanches atrativos)
INSERT INTO produtos (id_produto, nome, valor_unitario, estoque, id_categoria) VALUES 
(1, 'Smash Clássico (1x 90g, Queijo Prato, Pão)', 22.90, 50, 1),
(2, 'Smash Salad (1x 90g, Alface, Tomate, Molho Especial)', 24.90, 50, 1),
(3, 'Smash Duplo Bacon (2x 90g, Cheddar, Bacon Crocante)', 32.90, 40, 1),
(4, 'Smash Triplo Monstro (3x 90g, Triplo Cheddar)', 39.90, 30, 1),
(5, 'Burger Costela BBQ (160g, Queijo Coalho, Cebola Crispy)', 36.90, 30, 2),
(6, 'Chicken Burger (Sobrecoxa Empanada, Salada, Maionese)', 29.90, 20, 2),
(7, 'Futuro Veggie (Burger Vegetal, Shimeji, Rúcula)', 38.00, 15, 2),
(8, 'Gorgonzola Premium (160g, Creme de Gorgonzola, Mel)', 37.90, 40, 2),
(9, 'X-Tudo Raiz (Carne, Ovo, Bacon, Salsicha, Presunto)', 34.90, 35, 2),
(10, 'Cheddar Melt Onion (160g, Cheddar Cremoso, Cebola Caramelizada)', 35.90, 25, 2),
(11, 'Coca-Cola Original 350ml', 6.50, 100, 4),
(12, 'Guaraná Antarctica 350ml', 6.50, 100, 4),
(13, 'Suco de Laranja Natural 500ml', 10.00, 50, 4),
(14, 'Água Mineral sem Gás 500ml', 4.50, 80, 4),
(15, 'Soda Italiana de Maçã Verde', 12.00, 60, 4),
(16, 'Cerveja Heineken Long Neck', 13.00, 80, 4),
(17, 'Milkshake de Nutella com Ninho 400ml', 22.00, 30, 5),
(18, 'Milkshake de Morango com Chantilly', 19.90, 30, 5),
(19, 'Pudim de Leite Condensado (Fatia)', 14.00, 20, 5),
(20, 'Brownie Quente com Sorvete de Creme', 24.90, 15, 5),
(21, 'Porção de Fritas Tradicional (Serve 2)', 22.90, 50, 3),
(22, 'Fritas com Cheddar Cremoso e Bacon', 34.90, 40, 3),
(23, 'Coxinha de Costela (6 unidades)', 29.90, 30, 3),
(24, 'Onion Rings com Molho Barbecue', 24.00, 25, 3),
(25, 'Dadinhos de Tapioca com Geleia de Pimenta', 26.90, 40, 3),
(26, 'Combo Smash Clássico (+ Fritas P + Refri Lata)', 38.90, 20, 1),
(27, 'Combo Costela BBQ (+ Fritas P + Refri Lata)', 52.90, 25, 2),
(28, 'Combo Casal (2x Smash Duplo, 1x Fritas Cheddar, 2x Refris)', 89.90, 20, 1),
(29, 'Combo Kids (Mini Burger, Fritas Smile, Suco)', 29.90, 10, 1),
(30, 'Adicional de Maionese Verde (Pote 30ml)', 3.50, 150, 3);

-- 3.3 Pedidos (Datas focadas na semana atual para dar contexto)
INSERT INTO pedidos (id_pedido, data, status, cpf_funcionario, cpf_cliente, numero_mesa) VALUES 
(1, '2026-03-08', 'Finalizado', '30303030303', '11111111101', 1),
(2, '2026-03-08', 'Finalizado', '10101010101', '11111111102', 2),
(3, '2026-03-08', 'Finalizado', '30303030303', '11111111103', NULL), -- Delivery
(4, '2026-03-09', 'Finalizado', '10101010101', '11111111104', 3),
(5, '2026-03-09', 'Finalizado', '30303030303', '11111111105', NULL),
(6, '2026-03-09', 'Finalizado', '10101010101', '11111111106', 4),
(7, '2026-03-09', 'Cancelado', '30303030303', '11111111107', 1),
(8, '2026-03-10', 'Finalizado', '10101010101', '11111111108', NULL),
(9, '2026-03-10', 'Finalizado', '30303030303', '11111111109', 2),
(10, '2026-03-10', 'Finalizado', '10101010101', '11111111110', NULL),
(11, '2026-03-10', 'Finalizado', '30303030303', '11111111111', 3),
(12, '2026-03-10', 'Finalizado', '10101010101', '11111111112', 4),
(13, '2026-03-11', 'Finalizado', '30303030303', '11111111113', NULL),
(14, '2026-03-11', 'Finalizado', '10101010101', '11111111114', 1),
(15, '2026-03-11', 'Finalizado', '30303030303', '11111111115', 2),
(16, '2026-03-11', 'Finalizado', '10101010101', '11111111116', NULL),
(17, '2026-03-11', 'Finalizado', '30303030303', '11111111117', 3),
(18, '2026-03-11', 'Finalizado', '10101010101', '11111111118', NULL),
(19, '2026-03-11', 'Finalizado', '30303030303', '11111111119', 4),
(20, '2026-03-11', 'Finalizado', '10101010101', '11111111120', 1),
(21, '2026-03-11', 'Finalizado', '30303030303', '11111111121', NULL),
(22, '2026-03-11', 'Em Rota de Entrega', '10101010101', '11111111122', NULL),
(23, '2026-03-11', 'Em Preparo', '30303030303', '11111111123', 3),
(24, '2026-03-11', 'Aguardando Motoboy', '10101010101', '11111111124', NULL),
(25, '2026-03-11', 'Em Preparo', '30303030303', '11111111125', 4),
(26, '2026-03-11', 'Em Preparo', '10101010101', '11111111126', 1),
(27, '2026-03-11', 'Novo', '30303030303', '11111111127', NULL),
(28, '2026-03-11', 'Aguardando Pagamento', '10101010101', '11111111128', 2),
(29, '2026-03-11', 'Novo', '30303030303', '11111111129', 3),
(30, '2026-03-11', 'Novo', '10101010101', '11111111130', NULL);

-- 3.4 Item_Produto (Quantidades e valores batendo com os novos produtos)
INSERT INTO item_produto (id_item, id_pedido, id_produto, quantidade, valor) VALUES 
(1, 1, 1, 1, 22.90),
(2, 2, 3, 2, 65.80),
(3, 3, 26, 1, 38.90),
(4, 4, 10, 1, 35.90),
(5, 5, 11, 2, 13.00),
(6, 6, 22, 1, 34.90),
(7, 7, 5, 1, 36.90),
(8, 8, 28, 1, 89.90),
(9, 9, 17, 1, 22.00),
(10, 10, 8, 2, 75.80),
(11, 11, 23, 1, 29.90),
(12, 12, 7, 1, 38.00),
(13, 13, 27, 1, 52.90),
(14, 14, 14, 3, 13.50),
(15, 15, 10, 1, 35.90),
(16, 16, 4, 1, 39.90),
(17, 17, 20, 2, 49.80),
(18, 18, 2, 3, 74.70),
(19, 19, 12, 1, 6.50),
(20, 20, 24, 1, 24.00),
(21, 21, 26, 2, 77.80),
(22, 22, 6, 1, 29.90),
(23, 23, 19, 1, 14.00),
(24, 24, 29, 1, 29.90),
(25, 25, 16, 4, 52.00),
(26, 26, 2, 1, 24.90),
(27, 27, 4, 2, 79.80),
(28, 28, 21, 1, 22.90),
(29, 29, 25, 1, 26.90),
(30, 30, 30, 3, 10.50);

-- 4. Inserções em outras tabelas para garantir relacionamentos completos

INSERT INTO receitas (id_receita, id_produto, id_ingrediente, quantidade_necessaria, modo_de_preparo) VALUES 
(1, 3, 1, 1.00, 'Tostar o pão brioche na manteiga'),
(2, 3, 2, 2.00, 'Fazer o smash da carne (2x 90g) na chapa bem quente'),
(3, 3, 3, 2.00, 'Derreter o cheddar por cima das carnes e adicionar o bacon crocante');

INSERT INTO compras_estoque (id_compra, cnpj_fornecedor, data_compra, valor_total) VALUES 
(1, '12345678000199', '2026-03-01', 2500.00),
(2, '98765432000188', '2026-03-05', 450.00),
(3, '45612378000177', '2026-03-10', 1200.00);

INSERT INTO itens_compra (id_item_compra, id_compra, id_ingrediente, quantidade, preco_unitario) VALUES 
(1, 1, 2, 100.00, 25.00),
(2, 2, 4, 20.00, 4.50),
(3, 3, 8, 50.00, 18.00);

INSERT INTO escala_trabalho (id_escala, cpf_funcionario, id_turno, data_escala) VALUES 
(1, '10101010101', 1, '2026-03-11'),
(2, '20202020202', 2, '2026-03-11'),
(3, '30303030303', 2, '2026-03-11');

INSERT INTO entregas (id_entrega, id_pedido, id_entregador, endereco_destino, taxa_entrega, status_entrega) VALUES 
(1, 3, 1, 'Av. Maria Quitéria, 880', 7.00, 'Entregue'),
(2, 5, 2, 'Av. João Durval, 3400', 8.50, 'Entregue'),
(3, 8, 3, 'Travessa dos Bandeirantes, 12', 6.00, 'Entregue');

INSERT INTO pagamentos (id_pagamento_realizado, id_pedido, id_pagamento, valor_pago, data_pagamento) VALUES 
(1, 1, 1, 22.90, '2026-03-08'),
(2, 2, 2, 65.80, '2026-03-08'),
(3, 3, 1, 38.90, '2026-03-08');

INSERT INTO avaliacoes (id_avaliacao, cpf_cliente, id_pedido, nota, comentario) VALUES 
(1, '11111111101', 1, 5, 'Melhor smash da cidade, sem dúvidas! O pão estava super macio.'),
(2, '11111111102', 2, 4, 'O lanche é sensacional, mas o motoboy demorou uns 10 minutinhos a mais.'),
(3, '11111111103', 3, 5, 'A maionese verde de vocês é viciante. Chegou quentinho!');
