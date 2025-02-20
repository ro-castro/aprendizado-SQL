/* SUBQUERY: uma Subconculta, ou seja, uma consulta dentro da consulta, podemos utilizar o resultado de uma query (Consulta ou SELECT)
dentro de outra. Resumindo, � um SELECT, dentro de outro SELECT

Onde utilizar?

Pode ser utilizada em 3 situa��es poss�veis:

1. Junto com o WHERE, funcionando como um filtro vari�vel
2. Junto com o SELECT, como uma nova coluna na tabela
3. Junto com o FROM, como uma nova tabela 

1. Subquery com WHERE
	a.Subquery como um filtro din�mico e escalar (valor �nico)

SELECT
	coluna1,
	coluna2
FROM
	tabela
WHERE
	coluna1 = (SELECT) */

--Consulte a DimProduct listando apenas produtos com custo acima dam�dia

SELECT
	*
FROM
	DimProduct
WHERE
	UnitCost > (
		SELECT 
			AVG(UnitCost) 
		FROM 
			DimProduct
	)

	
/*	b.Subquery como um filtro din�mico e em lista (v�rios valores)

SELECT
	coluna1,
	coluna2
FROM
	tabela
WHERE
	coluna1 IN (SELECT) */

--Filtre a tabela DimProduct retornando apenas produtos das subcategorias 'Televisions' e 'Monitors'

SELECT
	*
FROM
	DimProduct
WHERE
	ProductSubcategoryKey IN (
		SELECT 
			ProductSubcategoryKey 
		FROM 
			DimProductSubcategory
		WHERE 
			ProductSubcategoryName IN ('Televisions', 'Monitors')
	)

/*2. Subquery com SELECT, como uma nova coluna

SELECT
	coluna1,
	coluna2,
	SELECT
FROM
	tabela */

--Retorne uma tabela com todos os produtos (ID Produto e Nome Produto) e o total de vendas para cada produto

SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Nome do Produto',
	(
	SELECT
		(COUNT(ProductKey))
	FROM
		FactSales
	WHERE
		FactSales.ProductKey = DimProduct.ProductKey) AS 'Total de Vendas'
FROM
	DimProduct

/*3. Subquery com FROM, como uma nova tabela

SELECT
	coluna1,
	coluna2
FROM
	(SELECT) AS T */

--Retorne a quantidade de produtos da marca 'Contoso'

SELECT	
	COUNT(*) AS 'N�mero de produtos Contoso'
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'

SELECT
	COUNT(*) AS 'N�mero de produtos Contoso'
FROM
	(SELECT	
		*
	FROM
		DimProduct
	WHERE
		BrandName = 'Contoso') AS Tabela

--Subquery aninhada (subquery dentro de outra subquery)

--Descubra o nome dos clientes que ganham o segundo maior sal�rio

SELECT
	FirstName AS 'Nome',
	YearlyIncome AS 'Sal�rio Anual'
FROM
	DimCustomer
WHERE
	YearlyIncome = (
		SELECT
			MAX(YearlyIncome)
		FROM
			DimCustomer
		WHERE
			YearlyIncome < (
				SELECT
					MAX(YearlyIncome)
				FROM
					DimCustomer
				WHERE	
					CustomerType = 'Person'
		)
	)


