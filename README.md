# Modelagem de Banco de Dados - Justificativa

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

## *Hierarquia e dependências:* A estrutura dos comandos *DROP* das tabelas filhas para as pais e *CREATE* de pais para filhas se justifica pela necessidade de respeito a integridade referencial. para impedir erros de chaves estrangeiras e garantir que nenhuma tabela depedente  seja construída sem uma mestre. 
## *Automoção ON DELETE CASCADE:* Implementamos essa função para garantir a limpeza do banco, se um pedido for cancelado nosso sistema elimina pagamentos e itens vinculados isso mantem a organização e impede registros fantasmas. 
## *NUMERIC(12,2):* foi escolhido para proteger e garantir que o saldo financeiro seja exato em relação aos centavos e que o banco suporte valores altos até em grande fluxos como consultas anuais.
## *NOT NULL e UNIQUE:* Restrições implementadas para qualidade dos dados. o `NOT NULL` impede que o sistema cadastre um produto com informações incompletas e o `UNIQUE` É a camada de segurança impedindo fraudes de login e ou duplicação de cpf e email de clientes.
## *SERIAL e INTEGER:* Utilizamos o `SERIAL` para automatizar a criação de IDs, eliminando erro humano na contagem de pedidos. Já o `INTERGER` foi aplicado onde o controle deve ser humano e exato, como na contagem de estoque físico e numeração de mesas.

## Testes: O projeto justifica sua robustez através de um teste com 30 registros por tabela principal, com aproximadamente 200 linhas de dados funcionais. esse teste prova que o sistema mantém a performance e a integridade das relações mesmo sob fluxo constante de informações.

# Testes de Relacionamento (DQL)
## Utilizamos consultas com JOINs para extrair informações estratégicas do banco os testes realizados incluem:

**Integridade de Vendas (INNER JOIN):** Cruzamento de Pedidos, Produtos e Funcionários para garantir que cada item vendido esteja vinculado a um responsável e a um valor de caixa correto.
**Análise de Ociosidade (LEFT JOIN):** Listagem de todos os funcionários e produtos, permitindo identificar quem não realizou vendas no período ou itens do cardápio que estão sem saída.
**Controle de Métodos (RIGHT JOIN):** Verificação de todas as formas de pagamento e categorias cadastradas, garantindo que mesmo as opções nunca utilizadas apareçam nos relatórios gerenciais para análise de expansão.



## O banco foi testado com 30 registros nas tabelas principais e chegando a 206 linhas com os dados validados e funcionado.

### O script segue a ordem  de exclusão DROP das tabelas "filhas" para as "pais" e criação CREATE das "pais" para as "filhas" evitando erros de Chave Estrangeira.
### *ON Delete CASCADE:* Se um pedido for excluído o sistema limpa automaticamente os itens e pagamentos vinculados mantendo a organização do banco.
### Usamos *NUMERIC(12,2)* para que o banco possa  guardar até 12 dígitos no total e o 2 garante que sempre haverá duas casas decimais para os centavos.
### *NOT NULL* Foi escolhido para evitar que o banco fique com espaços vazios então se alguem tentar cadastrar produto ou funcionário sem nome não é aceito.
### *UNIQUE* É usado em campo como cpf, login ou email evitando também que dois funcionários usem a mesma senha para acesso ou que um cliente seja cadastrado duas vezes. 
### *INTEGER* Serve para contagens de números inteiros que não pode dividir, ele é registrado manualmente você atualiza a quantidade de itens e números das mesas.
### *SERIAL* Contador de números inteiros automáticos, ao inserir um cliente novo ou pedido o banco analisa o último e cria o proximo sozinho. 
### *DROP* Faz a limpeza começando pelas tabelas filhas e depois pais, ele não permite o banco apagar uma tabela pai se tiver uma tabela filha ligada a uma chave estrangeira.
### *CREATE* Inverte a lógica as tabelas pai são as primeiras criadas como base e depois as outras.

## *CONSULTAS* Para validar a integridade dos dados foram implementados 12 cenários de junção de tabelas:
### `Inner Joins` Utilizados para extrair informações que dependem obrigatoriamente de um vínculo entre tabelas. Exemplos: Pedido/Produto, Pedido/Equipe e Faturamento.
### `Left Joins` Essenciais para identificar lacunas ou registros que ainda não possuem movimentação. Exemplos: Equipe quem ainda não vendeu e Controle de Estoque lanches sem receita. 
### `Right Joins` Utilizados para garantir que as tabelas de configurações sejam listadas integralmente. Exemplos: Métodos de Pagamento e Categorias do Cardápio.

## Estrutura do projeto
## `/ddl/script_tabelas.sql` Contém o arquivo de criação das tabelas, drop table definições de tipos e restrições de PRIMARY KEY, NOT NULL, UNIQUE etc.
## `/dml/inserts_dados.sql` Contém todos os dados para testes, incluindo os 206 registros distribuídos entre as 30 entidades principais e as outras.
## `/dql/consultas.sql` Pasta contendo as consultas e validando as regras e os 12 testes de JOINS solicitados.

