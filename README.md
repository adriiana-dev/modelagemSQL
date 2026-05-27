# Modelagem Banco de Dados - Lanchonete

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue)
![SQL](https://img.shields.io/badge/SQL-Structured_Query_Language-orange)
![Status](https://img.shields.io/badge/status-concluido-green)

## Dominio
O dominio escolhido pela equipe foi uma lanchonete com foco em vendas e movimentacao diaria. O sistema ajuda no controle de pedidos, funcionarios responsaveis pelas vendas, estoque de produtos, formas de pagamento, fornecedores, insumos e entregas.

## Estrutura Principal
* **Cardapio:** categorias, produtos, pedidos, itens e mesas.
* **Gestao:** funcionarios, clientes, turnos e escala de trabalho.
* **Financeiro:** pagamentos, metodos de pagamento, promocoes e resumo de caixa.
* **Estoque:** ingredientes, receitas, fornecedores, compras e reposicao.
* **Entrega:** entregadores, pedidos de entrega e avaliacoes.

## Comandos Tecnicos
* Integridade referencial com criacao de tabelas pais e filhas.
* Uso de `ON DELETE CASCADE` e `ON DELETE RESTRICT` para consistencia dos dados.
* Tipos adequados como `NUMERIC(12,2)`, `DATE`, `TIME` e `INTEGER`.
* Restricoes `NOT NULL`, `UNIQUE` e `CHECK` para qualidade e seguranca.

## Ordem de Execucao
1. Execute `ddl/script_tabelas.sql` para criar a estrutura.
2. Execute `dml/inserts_dados.sql` para popular a base.
3. Execute `tcl/procedure.sql` para criar procedures, triggers, functions e views.

## Rotinas de Venda e Caixa
* **Procedures:** `AbrirPedido`, `AdicionarItemPedido`, `FecharCaixaDia`.
* **Triggers:** `ImpedirVendaSemEstoque`, `BaixaEstoqueAutomatica`, `AtualizarValorTotalPedido`.
* **Functions:** `CalcularTroco`, `ProdutoMaisVendido`, `ComissaoFuncionario`.
* **Views:** `VendasPorMetodoPagamento`, `ProdutosParaReposicao`, `DesempenhoVendasHora`.

## Testes
* Base validada com mais de 200 registros.
* Consultas com `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `GROUP BY`, `UNION` e `INTERSECT`.
* Rotinas de vendas preparadas para abertura de pedido, inclusao de itens, baixa de estoque, totalizacao automatica e fechamento de caixa.

## Pastas
* [`ddl/script_tabelas.sql`](https://github.com/adriiana-dev/modelagemSQL/blob/main/ddl/script_tabelas.sql) - criacao das tabelas.
* [`dml/inserts_dados.sql`](https://github.com/adriiana-dev/modelagemSQL/blob/main/dml/inserts_dados.sql) - insercao de dados.
* [`dql/consultas.sql`](https://github.com/adriiana-dev/modelagemSQL/blob/main/dql/consultas.sql) - consultas e testes.
* [`tcl/procedure.sql`](https://github.com/adriiana-dev/modelagemSQL/blob/main/tcl/procedure.sql) - procedures, triggers, functions e views.
