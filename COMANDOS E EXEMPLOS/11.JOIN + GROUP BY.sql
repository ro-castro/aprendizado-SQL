--GROUP BY + JOIN
--1a. Crie um agrupamento mostrando o total de vendas (SalesQuantity) por ano (CalendarYear)

SELECT
	DimDate.CalendarYear AS 'Ano',
	SUM(FactSales.SalesQuantity) AS 'Total Vendido'
FROM 
	FactSales
INNER JOIN
	DimDate
ON
	FactSales.DateKey = DimDate.Datekey
GROUP BY 
	CalendarYear

--1b. Considere apenas o mês (CalendarMonthLabel) de 'January'.

SELECT
	DimDate.CalendarYear AS 'Ano',
	SUM(FactSales.SalesQuantity) AS 'Total Vendido'
FROM 
	FactSales
INNER JOIN
	DimDate
ON
	FactSales.DateKey = DimDate.Datekey
WHERE
	CalendarMonthLabel = 'January'
GROUP BY 
	CalendarYear

--1c. Na tabela resultante, mostre apenas os anos com um total de vendas maior ou igual a de 1200000

SELECT
	DimDate.CalendarYear AS 'Ano',
	SUM(FactSales.SalesQuantity) AS 'Total Vendido'
FROM 
	FactSales
INNER JOIN
	DimDate
ON
	FactSales.DateKey = DimDate.Datekey
WHERE
	CalendarMonthLabel = 'January'
GROUP BY 
	CalendarYear
HAVING
	SUM(FactSales.SalesQuantity) >= 1200000


