# Modelagem de Banco de Dados

## O domínio escolhido pela nossa equipe foi uma lanchonete onde o problema principal é a falta de controle de vendas, em um ambiente de grande fluxo e movimentação diária. Pensando nisso, esse sistema visa aumentar o faturamento e diminuir gastos e prejuízos. Sendo assim, o proprietário passa a ter acesso a quem vendeu, o que foi vendido, gastos com fornecedores e insumos na produção, quantidade de produtos no estoque, forma de pagamento, além de gestão e acompanhamento de entregas por delivery.

## Entidades e funções
  ## Cardapio
 * **Categorias:** Responsável pela organização dos produtos em grupos facilitando a gestão do negócio.  
 * **Produtos:** Parte essencial no sistema responsável por preço, nome e estoque facilitando o controle e evitando que a lanchonete fique com o estoque vazio.
 * **Pedidos:** O fluxo diário, com ele registramos data, o status do atendimento e vinculando ao funcionário.
 * **Item_Produto:** Parte mais detalhada da venda, detalhando a quantidade vendida e valor no momento da compra importante para o histórico financeiro. 
 * **Mesas:** Atua no gerenciamento do espaço fisíco permtindo ter controle de messas ocupadas e vazias.
  ## Segurança
* **Funcionário:** É importante para a segurança permitindo identificar qual funcionário realizou cada compra e qual cargo ele ocupa.
* **Clientes:** Cadastro para controle e futuras estratégias de retenção.
* **Turnos:** Define os horários de funcionamento (Manhã, Tarde e Noite).
* **Escala_Trabalho:** Entra na parte de organização da equipe e vincular cada funcionário a seu turno evitando erros.
  ## Financeiro
* **Métodos_pagamento:** Com as várias opções de pagamento atual pix, cartão e dinheiro ter essa entidade permite controle bancário diário.
* **Pagamentos:** Responsável pelo registro pela transação de todos pedidos finalizados e garantir que as contas bata com o faturamento. 
* **Promoções:** Controlando desconto e ofertas disponibilizadas e movimentando o estoque.
  ## Estoque
* **Ingredientes:** Controlando insumos por por unidade de medida kg, mg, L e unidade. 
* **Receitas:** Atuando com ponte entre produto e ingrediente, ela faz o controle do quanto se gasta para fazer um misto por exemplo, deixando isso permite que o estoque tenha mais precisão de gastos. 
* **Fornecedores:** É feito um cadastro de parceiros o que acaba facilitando tanto reposição quanto ampliando redes de contatos. 
* **Compras_Estoque:** Registra todas entradas de mercadorias e investimentos feitos pelo proprietário.
* **Itens_Compra:** Detalha os ingredientes comprados e preço de cada um pago ao fornecedor.

  ## Entrega
* **Entregadores:** Cadastrando os funcionários responsáveis pela entrega delivery e registrando a placa do veículo para segurança.
* **Entrega:** Monitorando o destino, status e também as taxas extras cobradas.
* **Avaliações** Registrando a nota e feedback do cliente importante para identificar problemas com o atendimento ou com produtos. 

## O banco foi testado com 30 registros nas tabelas chegando a próximo de 200 linhas com os dados funcionado.

### O script segue a ordem  de exclusão DROP das tabelas "filhas" para as "pais" e criação CREATE das "pais" para as "filhas" evitando erros de Chave Estrangeira.
### *ON Delete CASCADE:* Se um pedido for excluído o sistema limpa automaticamente os itens e pagamentos vinculados mantendo a organização do banco.
### Usamos *NUMERIC(12,2)* para que o banco possa  guardar até 12 dígitos no total e o 2 garante que sempre haverá duas casas decimais para os centavos.
### *NOT NULL* Foi escolhido para evitar que o banco fique com espaços vazios então se alguem tentar cadastrar produto ou funcionário sem nome não é aceito.
### *UNIQUE* É usado em campo como cpf, login ou email evitando também que dois funcionários usem a mesma senha para acesso ou que um cliente seja cadastrado duas vezes. 
### *INTEGER* Serve para contagens de números inteiros que não pode dividir, ele é registrado manualmente você atualiza a quantidade de itens e números das mesas.
### *SERIAL* Contador de números inteiros automáticos, ao inserir um cliente novo ou pedido o banco analisa o último e cria o proximo sozinho. 
### *DROP* Faz a limpeza começando pelas tabelas filhas e depois pais, ele não permite o banco apagar uma tabela pai se tiver uma tabela filha ligada a uma chave estrangeira.
### *CREATE* Inverte a lógica as tabelas pai são as primeiras criadas como base e depois as outras.


