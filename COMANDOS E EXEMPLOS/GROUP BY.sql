--GROUP BY
	--COUNT

SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'Quantidade Total'
FROM
	DimProduct
GROUP BY 
	BrandName

	--SUM

SELECT
	StoreType AS 'Tipo de Loja',
	SUM(EmployeeCount) 'N�mero de Funcion�rios'
FROM
	DimStore
GROUP BY 
	StoreType

	--AVG

SELECT
	BrandName AS 'Marca',
	AVG(UnitCost) AS 'M�dia de Custo'
FROM
	DimProduct
GROUP BY
	BrandName

	--MAX/MIN

SELECT
	ClassName AS 'Classe',
	MAX(UnitPrice) AS 'Pre�o mais alto',
	MIN(UnitPrice) AS 'Pre�o mais baixo'
From
	DimProduct
GROUP BY ClassName

	--ORDER BY

SELECT
	StoreType AS 'Tipo de Loja',
	SUM(EmployeeCount) 'N�mero de Funcion�rios'
FROM
	DimStore
GROUP BY StoreType
ORDER BY SUM(EMPLOYEECOUNT) DESC

	--WHERE

SELECT
	ColorName AS 'Cor do Produto',
	COUNT(*) AS 'Total de Produtos'
FROM	
	DimProduct
WHERE BrandName = 'Contoso'
GROUP BY ColorName
ORDER BY COUNT(*)

	--HAVING

SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Total por Marca'
FROM
	DimProduct
GROUP BY
	BrandName
HAVING 
	COUNT(BrandName) >= 200

