SELECT
	*
FROM
	DimProduct

SELECT
	MAX(UNITPRICE) AS 'Maior Pre�o',
	MIN(UNITPRICE) AS 'Menor Pre�o'
FROM
	DimProduct