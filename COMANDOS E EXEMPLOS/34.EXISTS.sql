--EXISTS
--Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) que possuem alguma venda no dia 01/01/2007

--Sem EXISTS

SELECT DISTINCT
	DimProduct.ProductKey,
	ProductName
FROM
	DimProduct
INNER JOIN
	FactSales
ON
	DimProduct.ProductKey = FactSales.ProductKey
WHERE
	DateKey = '20070101'

--Com EXISTS

SELECT
	ProductKey,
	ProductName
FROM
	DimProduct
WHERE
	EXISTS(
		SELECT
			ProductKey
		FROM
			FactSales
		WHERE
			DateKey = '01/01/2007' AND
			FactSales.ProductKey = DimProduct.ProductKey --Igualdade necessária para identificar se IDs dos produtos correspondem aos IDs encontrados na FactSales
		)