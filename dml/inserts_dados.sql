-- SCRIPT DE MANIPULAÇÃO DE DADOS DML
-- Ordem de execução:Tabelas independentes para dependentes

INSERT INTO categorias (id_categoria, nome_categoria) VALUES 
(1, 'Smash Burgers'), (2, 'Hambúrgueres Artesanais'), (3, 'Porções e Entradas'), (4, 'Bebidas Naturais e Refri'), (5, 'Sobremesas e Shakes');

INSERT INTO metodos_pagamento (id_pagamento, formas_transacao) VALUES 
(1, 'PIX'), (2, 'Cartão de Crédito'), (3, 'Cartão de Débito'), (4, 'Dinheiro'), (5, 'Vale Refeição');

INSERT INTO mesas (id_mesa, capacidade, status) VALUES 
(1, 2, 'Livre'), (2, 4, 'Ocupada'), (3, 4, 'Livre'), (4, 6, 'Reservada'), (5, 2, 'Livre');

INSERT INTO turnos (id_turno, nome_turno, horario_inicio, horario_fim) VALUES 
(1, 'Almoço', '10:00', '16:00'), (2, 'Jantar', '16:00', '22:00'), (3, 'Madrugada', '22:00', '04:00');

INSERT INTO entregadores (id_entregador, nome, telefone, placa_veiculo) VALUES 
(1, 'Tiago Silva', '11977771111', 'RTL-8A99'), (2, 'Roberto Santos', '11977772222', 'QKW-2B34'), (3, 'Fernando Costa', '11977773333', 'PLM-9C12');

INSERT INTO fornecedores (id_fornecedor, cnpj, nome_fantasia, telefone, email) VALUES 
(1, '12345678000199', 'Boi Nobre', '1130001010', 'vendas@boinobre.com.br'), 
(2, '98765432000188', 'Hortifruti Raiz', '1130002020', 'pedidos@hortiraiz.com.br'), 
(3, '45612378000177', 'Gela Guela', '1130003030', 'contato@gelaguela.com.br');

INSERT INTO ingredientes (id_ingrediente, nome, unidade_medida, estoque_atual) VALUES 
(1, 'Pão Brioche', 'Unid', 150), (2, 'Blend Bovino', 'Unid', 200), (3, 'Queijo Cheddar', 'Fatia', 400), 
(4, 'Alface', 'Maço', 15), (5, 'Tomate', 'Kg', 12), (6, 'Bacon', 'Kg', 18), 
(7, 'Batata', 'Kg', 80), (8, 'Maionese Verde', 'L', 5);

INSERT INTO promocoes (id_promocao, nome_promocao, desconto_percentual, data_inicio, data_fim) VALUES 
(1, 'Terça do Smash', 50.00, '2026-03-01', '2026-12-31'), 
(2, 'Combo Galera', 15.00, '2026-03-06', '2026-03-06'), 
(3, 'Mês de Aniversário', 10.00, '2026-03-01', '2026-03-31');

INSERT INTO funcionarios (id_funcionario, cpf, nome_completo, cargo, login_usuario) VALUES 
(1, '10101010101', 'Marina Oliveira', 'Gerente', 'marina.oli'), (2, '20202020202', 'Kleber Dias', 'Chapeiro', 'kleber.chapa'), 
(3, '30303030303', 'Julia Mendes', 'Atendente', 'julia.cx'), (4, '40404040404', 'Carlos Silva', 'Atendente', 'carlos.at'), 
(5, '50505050505', 'Beatriz Lima', 'Cozinha', 'bia.cozinha'), (6, '60606060606', 'Ricardo Santos', 'Chapeiro', 'ricardo.ch'),
(7, '70707070707', 'Ana Paula', 'Caixa', 'ana.paula'), (8, '80808080808', 'Felipe Jorge', 'Atendente', 'felipe.j'), 
(9, '90909090909', 'Leticia Cruz', 'Gerente', 'leticia.cr'), (10, '11223344556', 'Marcos Rocha', 'Atendente', 'marcos.ro'), 
(11, '22334455667', 'Fernanda Souza', 'Caixa', 'fer.souza'), (12, '33445566778', 'Gabriel Reis', 'Cozinha', 'gabriel.r'),
(13, '44556677889', 'Talita Neves', 'Atendente', 'talita.n'), (14, '55667788990', 'Igor Guimarães', 'Chapeiro', 'igor.g'), 
(15, '66778899001', 'Bruna Amaral', 'Caixa', 'bruna.a'), (16, '77889900112', 'Vitor Hugo', 'Atendente', 'vitor.h'), 
(17, '88990011223', 'Sonia Abrantes', 'Cozinha', 'sonia.a'), (18, '99001122334', 'Paulo Roberto', 'Atendente', 'paulo.r'),
(19, '12121212121', 'Daniela Meira', 'Gerente', 'dani.meira'), (20, '23232323232', 'Hugo Vasques', 'Chapeiro', 'hugo.v'), 
(21, '34343434343', 'Larissa Manoela', 'Atendente', 'lari.at'), (22, '45454545454', 'Mateus Solano', 'Caixa', 'mateus.s'), 
(23, '56565656565', 'Camila Pitanga', 'Cozinha', 'camila.p'), (24, '67676767676', 'Lázaro Ramos', 'Atendente', 'lazaro.r'),
(25, '78787878787', 'Paola Oliveira', 'Gerente', 'paola.o'), (26, '89898989898', 'Cauã Reymond', 'Chapeiro', 'caua.r'), 
(27, '91919191919', 'Grazi Massafera', 'Atendente', 'grazi.m'), (28, '13131313131', 'Tony Ramos', 'Caixa', 'tony.r'), 
(29, '24242424242', 'Gloria Pires', 'Cozinha', 'gloria.p'), (30, '35353535353', 'Lima Duarte', 'Atendente', 'lima.d');

INSERT INTO clientes (id_cliente, cpf, nome_completo, telefone, endereco, data_cadastro) VALUES 
(1, '11111111101', 'Lucas de Almeida Souza', '11988881001', 'Av. Getúlio Vargas, 1500', '2025-11-10'),
(2, '11111111102', 'Mariana Castilho', '11988881002', 'Rua São Domingos, 45', '2025-11-15'),
(3, '11111111103', 'Pedro Henrique Nogueira', '11988881003', 'Av. Maria Quitéria, 880', '2025-12-02'),
(4, '11111111104', 'Juliana Costa e Silva', '11988881004', 'Rua Marechal Deodoro, 120', '2025-12-05'),
(5, '11111111105', 'Fernanda Lima Botelho', '11988881005', 'Av. João Durval, 3400', '2025-12-10'),
(6, '11111111106', 'Rafael Silva', '11988881006', 'Cond. Parque das Árvores', '2026-01-05'),
(7, '11111111107', 'Amanda Rocha', '11988881007', 'Rua Barão do Rio Branco, 55', '2026-01-08'),
(8, '11111111108', 'Diego Martins Oliveira', '11988881008', 'Trav. dos Bandeirantes, 12', '2026-01-12'),
(9, '11111111109', 'Carla Mendes Assis', '11988881009', 'Rua Visconde de Mauá, 909', '2026-01-15'),
(10, '11111111110', 'Bruno Souza Ferreira', '11988881010', 'Av. Presidente Dutra, 2100', '2026-01-18'),
(11, '11111111111', 'Camila Dias de Moraes', '11988881011', 'Rua Castro Alves, 33', '2026-01-20'),
(12, '11111111112', 'Rodrigo Alves Pinto', '11988881012', 'Praça da Matriz, S/N', '2026-01-22'),
(13, '11111111113', 'Tatiana Pires', '11988881013', 'Rua Voluntários da Pátria, 404', '2026-01-25'),
(14, '11111111114', 'Thiago Gomes', '11988881014', 'Av. Sete de Setembro, 100', '2026-01-28'),
(15, '11111111115', 'Patricia Melo', '11988881015', 'Rua do Comércio, 88', '2026-02-01'),
(16, '11111111116', 'Leandro Ramos Junior', '11988881016', 'Residencial Flores, 101', '2026-02-03'),
(17, '11111111117', 'Aline Farias Peixoto', '11988881017', 'Rua Machado de Assis, 77', '2026-02-05'),
(18, '11111111118', 'Gustavo Nogueira', '11988881018', 'Av. Brasil, 5000', '2026-02-10'),
(19, '11111111119', 'Vanessa Moura', '11988881019', 'Alameda das Rosas, 21', '2026-02-12'),
(20, '11111111120', 'Felipe Castro Barbosa', '11988881020', 'Rua da Consolação, 134', '2026-02-15'),
(21, '11111111121', 'Renata Borges', '11988881021', 'Condomínio Vila Rica', '2026-02-18'),
(22, '11111111122', 'Alexandre Vieira', '11988881022', 'Rua Tiradentes, 890', '2026-02-20'),
(23, '11111111123', 'Sabrina Monteiro', '11988881023', 'Av. Independência, 303', '2026-02-22'),
(24, '11111111124', 'Eduardo Peixoto', '11988881024', 'Rua Rui Barbosa, 15', '2026-02-25'),
(25, '11111111125', 'Monica Assis', '11988881025', 'Travessa Bela Vista, 9', '2026-02-28'),
(26, '11111111126', 'Ricardo Lopes', '11988881026', 'Rua Aurora, 456', '2026-03-01'),
(27, '11111111127', 'Beatriz Campos', '11988881027', 'Edifício Central, Sala 20', '2026-03-03'),
(28, '11111111128', 'Marcelo Barros', '11988881028', 'Av. dos Estados, 111', '2026-03-05'),
(29, '11111111129', 'Larissa Freitas', '11988881029', 'Rua do Bosque, 73', '2026-03-08'),
(30, '11111111130', 'Vinicius Moraes Neto', '11988881030', 'Loteamento Nova Esperança', '2026-03-10');

INSERT INTO produtos (id_produto, nome, valor_unitario, estoque, id_categoria) VALUES 
(1, 'Smash Clássico', 22.90, 50, 1), (2, 'Smash Salad', 24.90, 50, 1), (3, 'Smash Duplo Bacon', 32.90, 40, 1), 
(4, 'Smash Triplo Monstro', 39.90, 30, 1), (5, 'Burger Costela BBQ', 36.90, 30, 2), (6, 'Chicken Burger', 29.90, 20, 2), 
(7, 'Futuro Veggie', 38.00, 15, 2), (8, 'Gorgonzola Premium', 37.90, 40, 2), (9, 'X-Tudo Raiz', 34.90, 35, 2), 
(10, 'Cheddar Melt Onion', 35.90, 25, 2), (11, 'Coca-Cola 350ml', 6.50, 100, 4), (12, 'Guaraná 350ml', 6.50, 100, 4),
(13, 'Suco Laranja 500ml', 10.00, 50, 4), (14, 'Água Mineral 500ml', 4.50, 80, 4), (15, 'Soda Italiana', 12.00, 60, 4), 
(16, 'Cerveja Heineken', 13.00, 80, 4), (17, 'Milkshake Nutella', 22.00, 30, 5), (18, 'Milkshake Morango', 19.90, 30, 5), 
(19, 'Pudim Fatia', 14.00, 20, 5), (20, 'Brownie Sorvete', 24.90, 15, 5), (21, 'Fritas Tradicional', 22.90, 50, 3), 
(22, 'Fritas Cheddar/Bacon', 34.90, 40, 3), (23, 'Coxinha Costela 6un', 29.90, 30, 3), (24, 'Onion Rings', 24.00, 25, 3),
(25, 'Dadinhos Tapioca', 26.90, 40, 3), (26, 'Combo Smash Clássico', 38.90, 20, 1), (27, 'Combo Costela BBQ', 52.90, 25, 2), 
(28, 'Combo Casal', 89.90, 20, 1), (29, 'Combo Kids', 29.90, 10, 1), (30, 'Adicional Maionese', 3.50, 150, 3);

INSERT INTO pedidos (id_pedido, data, status, id_funcionario, id_cliente, id_mesa) VALUES 
(1, '2026-03-08', 'Finalizado', 3, 1, 1), (2, '2026-03-08', 'Finalizado', 1, 2, 2),
(3, '2026-03-08', 'Finalizado', 3, 3, NULL), (4, '2026-03-09', 'Finalizado', 1, 4, 3),
(5, '2026-03-09', 'Finalizado', 3, 5, NULL), (6, '2026-03-09', 'Finalizado', 1, 6, 4),
(7, '2026-03-09', 'Cancelado', 3, 7, 1), (8, '2026-03-10', 'Finalizado', 1, 8, NULL),
(9, '2026-03-10', 'Finalizado', 3, 9, 2), (10, '2026-03-10', 'Finalizado', 1, 10, NULL),
(11, '2026-03-10', 'Finalizado', 3, 11, 3), (12, '2026-03-10', 'Finalizado', 1, 12, 4),
(13, '2026-03-11', 'Finalizado', 3, 13, NULL), (14, '2026-03-11', 'Finalizado', 1, 14, 1),
(15, '2026-03-11', 'Finalizado', 3, 15, 2), (16, '2026-03-11', 'Finalizado', 1, 16, NULL),
(17, '2026-03-11', 'Finalizado', 3, 17, 3), (18, '2026-03-11', 'Finalizado', 1, 18, NULL),
(19, '2026-03-11', 'Finalizado', 3, 19, 4), (20, '2026-03-11', 'Finalizado', 1, 20, 1),
(21, '2026-03-11', 'Finalizado', 3, 21, NULL), (22, '2026-03-11', 'Em Rota', 1, 22, NULL),
(23, '2026-03-11', 'Em Preparo', 3, 23, 3), (24, '2026-03-11', 'Aguardando', 1, 24, NULL),
(25, '2026-03-11', 'Em Preparo', 3, 25, 4), (26, '2026-03-11', 'Em Preparo', 1, 26, 1),
(27, '2026-03-11', 'Novo', 3, 27, NULL), (28, '2026-03-11', 'Aguardando', 1, 28, 2),
(29, '2026-03-11', 'Novo', 3, 29, 3), (30, '2026-03-11', 'Novo', 1, 30, NULL);

INSERT INTO item_produto (id_item, id_pedido, id_produto, quantidade, valor) VALUES 
(1,1,1,1,22.90), (2,2,3,2,65.80), (3,3,26,1,38.90), (4,4,10,1,35.90), (5,5,11,2,13.00), (6,6,22,1,34.90), 
(7,7,5,1,36.90), (8,8,28,1,89.90), (9,9,17,1,22.00), (10,10,8,2,75.80), (11,11,23,1,29.90), (12,12,7,1,38.00), 
(13,13,27,1,52.90), (14,14,14,3,13.50), (15,15,10,1,35.90), (16,16,4,1,39.90), (17,17,20,2,49.80), (18,18,2,3,74.70), 
(19,19,12,1,6.50), (20,20,24,1,24.00), (21,21,26,2,77.80), (22,22,6,1,29.90), (23,23,19,1,14.00), (24,24,29,1,29.90), 
(25,25,16,4,52.00), (26,26,2,1,24.90), (27,27,4,2,79.80), (28,28,21,1,22.90), (29,29,25,1,26.90), (30,30,30,3,10.50);

INSERT INTO receitas (id_receita, id_produto, id_ingrediente, quantidade_necessaria, modo_de_preparo) VALUES 
(1, 3, 1, 1.00, 'Tostar pão'), (2, 3, 2, 2.00, 'Fazer smash'), (3, 3, 3, 2.00, 'Derreter cheddar');

INSERT INTO compras_estoque (id_compra, id_fornecedor, data_compra, valor_total) VALUES 
(1, 1, '2026-03-01', 2500.00), (2, 2, '2026-03-05', 450.00), (3, 3, '2026-03-10', 1200.00);

INSERT INTO itens_compra (id_item_compra, id_compra, id_ingrediente, quantidade, preco_unitario) VALUES 
(1, 1, 2, 100.00, 25.00), (2, 2, 4, 20.00, 4.50), (3, 3, 8, 50.00, 18.00);

INSERT INTO escala_trabalho (id_escala, id_funcionario, id_turno, data_escala) VALUES 
(1, 1, 1, '2026-03-11'), (2, 2, 2, '2026-03-11'), (3, 3, 2, '2026-03-11');

INSERT INTO entregas (id_entrega, id_pedido, id_entregador, endereco_destino, taxa_entrega, status_entrega) VALUES 
(1, 3, 1, 'Av. Maria Quitéria, 880', 7.00, 'Entregue'), (2, 5, 2, 'Av. João Durval, 3400', 8.50, 'Entregue'), (3, 8, 3, 'Trav. Bandeirantes, 12', 6.00, 'Entregue');

INSERT INTO pagamentos (id_pagamento_realizado, id_pedido, id_pagamento, valor_pago, data_pagamento) VALUES 
(1, 1, 1, 22.90, '2026-03-08'), (2, 2, 2, 65.80, '2026-03-08'), (3, 3, 1, 38.90, '2026-03-08');

INSERT INTO avaliacoes (id_avaliacao, id_cliente, id_pedido, nota, comentario) VALUES 
(1, 1, 1, 5, 'Melhor smash!'), (2, 2, 2, 4, 'Muito bom!'), (3, 3, 3, 5, 'Maionese viciante!');
