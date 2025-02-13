--IIF:Alternativa ao CASE, 3 argumentos (Teste l�gico, resultado true, resultado false)

-- Exemplo 1: Qual � a categoria de risco do projeto abaixo, de acordo com a sua nota:
-- Risco Alto: Classicacao >= 5
-- Risco Baixo: Classificacao < 5

DECLARE
	@varClassificacao int = 9
SELECT
	IIF(
		@varClassificacao >= 5,
		'Risco Alto',
		'Risco Baixo') AS 'Classifica��o'

-- Exemplo 2: Crie uma coluna �nica de 'Cliente', contendo o nome do cliente, seja ele uma pessoa ou uma empresa. Traga tamb�m a coluna de CustomerKey e CustomerType.

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

-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Fa�a um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do respons�vel pelo produto, de acordo com o tipo de estoque. A regra dever� ser a seguinte:
-- Jo�o � respons�vel pelos produtos High
-- Maria � respons�vel pelos produtos Mid
-- Luis � respons�vel pelos produtos Low

SELECT
	ProductKey,
	ProductName,
		IIF(
			StockTypeName = 'High',
			'Jo�o',
			IIF(
				StockTypeName = 'Mid',
				'Maria',
				'Luis')) AS 'Respons�vel'	
FROM
	DimProduct