# Modelagem Banco de Dados - Lanchonete

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue)
![SQL](https://img.shields.io/badge/SQL-Structured_Query_Language-orange)
![Status](https://img.shields.io/badge/status-concluido-green)

## Dominio
O dominio escolhido pela equipe foi uma lanchonete com foco em vendas e movimentacao diaria, o sistema ajuda no controle de pedidos, funcionarios responsaveis pelas vendas, estoque de produtos, formas de pagamento, fornecedores, insumos e entregas. O projeto foi estruturado utilizando o modelo **On-Premise** implantação e processamento local para garantir autonomia operacional, segurança rígida e máxima velocidade de resposta nas transações, eliminando a dependência de conexões instáveis.

##  Arquitetura do Modelo On-Premise
A escolha estratégica pelo modelo local fundamenta-se nos seguintes pilares comerciais e técnicos:
* **Disponibilidade e Autonomia Local:** Toda a inteligência de negócios (Triggers, Procedures e Views) é executada diretamente no hardware do estabelecimento, Se a internet da região cair em um horário de pico, a lanchonete continua operando, vendendo e faturando normalmente.
* **Despacho e Logística Centralizada** O gerenciamento de entregas e motoboys ocorre de forma interna na rede local da loja. O banco processa os pedidos de delivery recebidos, faz as validações físicas de estoque e permite o despacho dos entregadores da própria lanchonete por meio de cupons e relatórios de rota emitidos instantaneamente pelo servidor interno.
* **Segurança e Baixo Custo de Infraestrutura:** Dados financeiros e cadastros de clientes ficam protegidos localmente em conformidade de transações ACID e restrições do PostgreSQL, eliminando custos recorrentes de tráfego de dados e servidores na nuvem.

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
4. Execute `dql/consultas.sql`para script de testes e validações de queries.

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
