--CTE: Common Table Expression, armazena temporariamente uma consulta para ser usada posteriormente

/*Crie um CTE para armazenar o resultado de uma consulta que contenha: ProductKey, ProductName,
BrandName, ColorName e UnitPrice, apenas para a marca Contoso */

WITH cte1 AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName,
		ColorName,
		UnitPrice
	FROM 
		DimProduct
	WHERE
		BrandName = 'Contoso'
	)
SELECT
	*
FROM
	cte1

--Calculando agregações com CTE

--Crie u,a CTE que seja o resultado do agrupamento de total de produtos por marca. Faça uma média de produtos por marca.

GO
WITH cte2 (Marca, Total) AS ( --Nome das colunas pode ser especificado logo após o nome da CTE
	SELECT
		BrandName,
		COUNT(ProductKey)
	FROM  
		DimProduct
	GROUP BY
		BrandName
	)
SELECT
	AVG(Total) AS 'Média de Produtos por Marca'
FROM
	cte2

--Crie 2 CTE's:
-- A primeira, chamada produtos_contoso, deve conter as seguintes colunas (DimProduct): ProductKey, ProductName, BrandName
-- A segunda, chamada vendas_top100, deve ser um top 100 vendas mais recentes, considerando as seguintes colunas da tabela FactSales: SalesKey, ProductKey, DateKey, SalesQuantity

-- Por fim, faça um INNER JOIN dessas tabelas

GO
WITH produtos_contoso AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName
	FROM
		DimProduct
	WHERE
		BrandName = 'Contoso'
	), --Não precisa de outro WITH, basta separar as CTEs por virgula
vendas_top100 AS (
	SELECT TOP (100)
		SalesKey,
		ProductKey, 
		DateKey, 
		SalesQuantity
	FROM
		FactSales
	ORDER BY
		DateKey DESC
	)
SELECT
	*
FROM
	vendas_top100
INNER JOIN
	produtos_contoso
ON
	vendas_top100.ProductKey = produtos_contoso.ProductKey
		



	
