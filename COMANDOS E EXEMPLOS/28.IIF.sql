--IIF:Alternativa ao CASE, 3 argumentos (Teste lógico, resultado true, resultado false)

-- Exemplo 1: Qual é a categoria de risco do projeto abaixo, de acordo com a sua nota:
-- Risco Alto: Classicacao >= 5
-- Risco Baixo: Classificacao < 5

DECLARE
	@varClassificacao int = 9
SELECT
	IIF(
		@varClassificacao >= 5,
		'Risco Alto',
		'Risco Baixo') AS 'Classificação'

-- Exemplo 2: Crie uma coluna única de 'Cliente', contendo o nome do cliente, seja ele uma pessoa ou uma empresa. Traga também a coluna de CustomerKey e CustomerType.

SELECT
	FirstName AS 'Nome',
	CustomerKey AS 'ID do Cliente',
	CustomerType AS 'Tipo do cliente',
	IIF(
		CustomerType = 'Person',
		FirstName,
		CompanyName) as 'Nome Cliente'
FROM
	DimCustomer

--IFF Composto: IF dentro do IF

-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Faça um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do responsável pelo produto, de acordo com o tipo de estoque. A regra deverá ser a seguinte:
-- João é responsável pelos produtos High
-- Maria é responsável pelos produtos Mid
-- Luis é responsável pelos produtos Low

SELECT
	ProductKey,
	ProductName,
		IIF(
			StockTypeName = 'High',
			'João',
			IIF(
				StockTypeName = 'Mid',
				'Maria',
				'Luis')) AS 'Responsável'	
FROM
	DimProduct