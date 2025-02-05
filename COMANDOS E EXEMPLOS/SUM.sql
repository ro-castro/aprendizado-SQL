SELECT
	TOP (100) *
FROM
	FactSales

SELECT
	SUM(SALESQUANTITY) AS 'Total Vendido',
	SUM(RETURNQUANTITY) AS 'Total Devolvido'
FROM 
	FactSales