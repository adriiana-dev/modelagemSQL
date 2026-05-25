# Modelagem  Banco de Dados - Lanchonete 

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue)
![SQL](https://img.shields.io/badge/SQL-Structured_Query_Language-orange)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)

## O domínio escolhido pela nossa equipe foi uma lanchonete onde o problema principal é a falta de controle de vendas, em um ambiente de grande fluxo e movimentação diária. Pensando nisso, esse sistema visa aumentar o faturamento e diminuir gastos e prejuízos. Sendo assim, o proprietário passa a ter acesso a quem vendeu, o que foi vendido, gastos com fornecedores e insumos na produção, quantidade de produtos no estoque, forma de pagamento, além de gestão e acompanhamento de entregas por delivery.

## Estrutura Principal

 * **Cardápio:** Categorias, produtos, pedidos, itens e mesas.   
 * **Gestão:** Funcionários, clientes, turnos e escala de trabalho.
 * **Financeiro:** Pagamentos, métodos de pagamento e promoções.
 * **Estoque:** Ingredientes, receitas, fornecedores e compras.
 * **Entrega:** Entregadores, pedidos de entrega e avaliações.
 
 ## Comandos Técnicos
 * Integridade referencial com criação de tabelas *pais* → *filhas.*
 * Uso de *ON DELETE CASCADE* para manter consistência dos dados.
 * Tipos adequados como *NUMERIC(12,2)*, *SERIAL* e *INTEGER.*
 * Restrições *NOT NULL* e *UNIQUE* para garantir qualidade e segurança.



## Testes
* Base validada com mais de 200 registros.
* Uso de *JOINs* (*INNER, LEFT, RIGHT*) para análise de dados.
* Consultas com *GROUP BY*, *UNION* e *INTERSECT* para validação e relatórios.

## PASTAS
## [/ddl/](https://github.com/adriiana-dev/modelagemSQL/blob/main/ddl/script_tabelas.sql) → criação das tabelas

## [/dml/](https://github.com/adriiana-dev/modelagemSQL/blob/main/dml/inserts_dados.sql) → inserção de dados

## [/dql/](https://github.com/adriiana-dev/modelagemSQL/blob/main/dql/consultas.sql) → consultas e testes


