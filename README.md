# Modelagem de Banco de Dados

## O Dominio escolhido pela nossa equipe foi uma lanchonete onde o problema principal é a falta de controle de vendas, em um ambiente de grande fluxo e movimentação diária sem um controle pode acontecer erros e futuros prejuizos. Pensando nisso esse sistema vai ajudar o proprietério a ter acesso em quem vendeu, o que foi vendido, a quantidade de produtos no estoque e a forma de pagamento utilizada. 

## Entidades e funções
 
 * **Categorias:** Responsável pela organização do cardápio com ela o proprietário pode saber qual produto a lanchonete vende mais. 
 
 * **Métodos_pagamento:**: Com as várias opções de pagamento atual pix, cartão e dinheiro ter essa entidade permite controle bncário diário.
 
 * **Funcionário:** É importante para a segurança permitindo identificar qual funcionário realizou cada compra e qual cargo ele ocupa. 
 
* **Produtos:** Parte essencial no sistema responsável por preço e estoque facilitando o controle e evitando que a lanchonete fique com o estoque vazio.

* **Pedidos:** É o coração das vendas da lanchonete. Essa entidade registra a data, o status de andamento de cada solicitação e vincula o funcionário responsável pelo atendimento, garantindo total controle sobre o fluxo diário.

* **Item_pedido:** Funciona como o detalhamento da venda, conectando o pedido aos produtos escolhidos pelo cliente. Ela registra a quantidade vendida e o valor exato no momento da compra, sendo fundamental para fechar o valor do caixa e dar baixa no estoque.
