SELECT
	*
FROM
	DimProduct

SELECT
	MAX(UNITPRICE) AS 'Maior Preço',
	MIN(UNITPRICE) AS 'Menor Preço'
FROM
	DimProduct