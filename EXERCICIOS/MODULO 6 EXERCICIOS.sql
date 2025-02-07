/*1. a) Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Voc� deve ordenar a tabela final de acordo com SalesQuantity, em ordem decrescente. */

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


--b) Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName). 
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

--c) Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s (CalendarMonthLabel) e ano (CalendarYear).

SELECT
	DimDate.CalendarYear AS 'Ano',
	DimDate.CalendarMonthLabel AS 'M�s',
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

/*2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor total vendido (SalesAmount) por produto. */
--a) Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity).

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
(ProductCategoryName). Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o 
entre FactSales e DimProductCategory n�o � direta.*/

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

/*4. a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity). */

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

--b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto. 

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

/*5. Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o 
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

--6. Fa�a uma tabela resumo mostrando a taxa de c�mbio m�dia de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100. 

SELECT
	DimCurrency.CurrencyDescription AS 'Moeda',
	AVG(FactExchangeRate.AverageRate) AS 'Taxa M�dia de C�mbio'
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

/*7.  Calcule a SOMA TOTAL de AMOUNT referente � tabela FactStrategyPlan destinado aos cen�rios: Actual e Budget. Dica: A tabela DimScenario ser� importante para esse exerc�cio. */

SELECT
	DimScenario.ScenarioName AS 'Cen�rio',
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

--8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico por ano.

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

/*9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em considera��o em sua an�lise apenas a marca Contoso e a cor Silver.*/

SELECT
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	COUNT(DimProduct.ProductKey) AS 'N�mero de Produtos'
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

/*10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna BrandName. */

SELECT
	DimProduct.BrandName AS 'Marca',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	COUNT(DimProduct.ProductKey) AS 'N�mero de Produtos'
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