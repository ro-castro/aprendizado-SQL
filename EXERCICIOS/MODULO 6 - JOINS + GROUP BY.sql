/*1. a) Faça um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Você deve ordenar a tabela final de acordo com SalesQuantity, em ordem decrescente. */

SELECT
	DimChannel.ChannelName AS 'Canal da Venda',
	SUM(FactSales.SalesQuantity) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN
	DimChannel
ON
	FactSales.channelKey = DimChannel.ChannelKey
GROUP BY
	ChannelName
ORDER BY
	SUM(SalesQuantity) DESC


--b) Faça um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName). 
SELECT
	DimStore.StoreName AS 'Loja',
	SUM(FactSales.SalesQuantity) AS 'Total Vendido',
	SUM(FactSales.ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales
INNER JOIN
	DimStore
ON
	FactSales.StoreKey = DimStore.StoreKey
GROUP BY
	StoreName
ORDER BY
	StoreName

--c) Faça um resumo do valor total vendido (Sales Amount) para cada mês (CalendarMonthLabel) e ano (CalendarYear).

SELECT
	DimDate.CalendarYear AS 'Ano',
	DimDate.CalendarMonthLabel AS 'Mês',
	SUM(FactSales.SalesAmount) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN
	DimDate
ON
	FactSales.DateKey = DimDate.Datekey
GROUP BY
	CalendarYear, CalendarMonthLabel, CalendarMonth
ORDER BY
	CalendarMonth ASC

/*2. Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesAmount) por produto. */
--a) Descubra qual é a cor de produto que mais é vendida (de acordo com SalesQuantity).

SELECT
	DimProduct.ColorName AS 'Cor',
	SUM(FactSales.SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales
INNER JOIN
	DimProduct
ON
	FactSales.ProductKey = DimProduct.ProductKey
GROUP BY
	ColorName
ORDER BY
	SUM(SalesQuantity) DESC

--b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.

SELECT
	DimProduct.ColorName AS 'Cor',
	SUM(FactSales.SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales
INNER JOIN
	DimProduct
ON
	FactSales.ProductKey = DimProduct.ProductKey
GROUP BY
	ColorName
HAVING
	SUM(SalesQuantity) >= 3000000
ORDER BY
	SUM(SalesQuantity) DESC

/*3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto 
(ProductCategoryName). Obs: Você precisará fazer mais de 1 INNER JOIN, dado que a relação 
entre FactSales e DimProductCategory não é direta.*/

SELECT
	DimProductCategory.ProductCategoryName AS 'Nome da Categoria',
	SUM(FactSales.SalesQuantity) AS 'Quantidade Vendida'
FROM 
	FactSales
INNER JOIN
	DimProduct
ON
	FactSales.ProductKey = DimProduct.ProductKey
		INNER JOIN
			DimProductSubcategory
		ON
			Dimproduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
				INNER JOIN
					DimProductCategory
				ON
					DimProductCategory.ProductCategoryKey = DimProductSubcategory.ProductCategoryKey
GROUP BY
	ProductCategoryName
ORDER BY
	SUM(FactSales.SalesQuantity) ASC

/*4. a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity). */

SELECT TOP (1000)
	DimCustomer.CustomerKey,
	DimCustomer.FirstName AS 'Nome',
	DimCustomer.LastName AS 'Sobrenome',
	SUM(FactOnlineSales.SalesQuantity) AS 'Quantidade Comprada'
FROM
	FactOnlineSales
INNER JOIN
	DimCustomer
ON
	FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person'
GROUP BY
	DimCustomer.CustomerKey, DimCustomer.FirstName, DimCustomer.LastName
ORDER BY
	SUM(FactOnlineSales.SalesQuantity) DESC

--b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto. 

SELECT TOP 10
	DimCustomer.FirstName AS 'Nome',
	DimCustomer.LastName AS 'Sobrenome',
	DimProduct.ProductName AS 'Produto',
	SUM(FactOnlineSales.SalesQuantity) AS 'Quantidade de Compras'
FROM
	FactOnlineSales
INNER JOIN
	DimCustomer
ON
	FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
		INNER JOIN
			DimProduct
		ON
			FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE 
	FactOnlineSales.CustomerKey = 7665
GROUP BY 
	ProductName, FactOnlineSales.CustomerKey, DimCustomer.FirstName, DimCustomer.LastName
ORDER BY
	SUM(FactOnlineSales.SalesQuantity) DESC

/*5. Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o 
sexo dos clientes.*/

SELECT
	DimCustomer.Gender AS 'Sexo',
	SUM(FactOnlineSales.SalesQuantity) AS 'Quantidade de Compras'
FROM
	FactOnlineSales
INNER JOIN
	DimCustomer
ON
	FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE
	Gender IN ('M', 'F')
GROUP BY
	DimCustomer.Gender

--6. Faça uma tabela resumo mostrando a taxa de câmbio média de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100. 

SELECT
	DimCurrency.CurrencyDescription AS 'Moeda',
	AVG(FactExchangeRate.AverageRate) AS 'Taxa Média de Câmbio'
FROM
	FactExchangeRate
INNER JOIN
	DimCurrency
ON
	FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY
	DimCurrency.CurrencyDescription
HAVING
	AVG(FactExchangeRate.AverageRate) BETWEEN '10' AND '100'

/*7.  Calcule a SOMA TOTAL de AMOUNT referente à tabela FactStrategyPlan destinado aos cenários: Actual e Budget. Dica: A tabela DimScenario será importante para esse exercício. */

SELECT
	DimScenario.ScenarioName AS 'Cenário',
	SUM(FactStrategyPlan.Amount) AS 'Total'
FROM
	FactStrategyPlan
INNER JOIN
	DimScenario
ON
	FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
WHERE
	DimScenario.ScenarioName IN ('Actual', 'Budget')
GROUP BY
	DimScenario.ScenarioName

--8. Faça uma tabela resumo mostrando o resultado do planejamento estratégico por ano.

SELECT
	DimDate.CalendarYear AS 'Ano',
	SUM(FactStrategyPlan.Amount) AS 'Total'
FROM
	FactStrategyPlan
INNER JOIN
	DimDate
ON
	FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY
	DimDate.CalendarYear

/*9. Faça um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em consideração em sua análise apenas a marca Contoso e a cor Silver.*/

SELECT
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	COUNT(DimProduct.ProductKey) AS 'Número de Produtos'
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	DimProduct.BrandName = 'Contoso' and
	DimProduct.ColorName = 'Silver'
GROUP BY
	DimProductSubcategory.ProductSubcategoryName

/*10. Faça um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final deverá ser ordenada de acordo com a coluna BrandName. */

SELECT
	DimProduct.BrandName AS 'Marca',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	COUNT(DimProduct.ProductKey) AS 'Número de Produtos'
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY
	DimProduct.BrandName, DimProductSubcategory.ProductSubcategoryName
ORDER BY
	BrandName ASC