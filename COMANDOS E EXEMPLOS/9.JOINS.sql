--EXEMPLOS INNER JOIN, LEFT JOIN e RIGHT JOIN

--TABELAS UTILIZADAS

SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryKey
FROM
	DimProduct

SELECT
	ProductSubcategoryKey,
	ProductSubcategoryName
FROM
	DimProductSubcategory

--INNER JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
INNER JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

--LEFT JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

--RIGHT JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
RIGHT JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

--FULL JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
FULL JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

--LEFT ANTI JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	ProductSubcategoryName IS NULL

--RIGHT ANTI JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
RIGHT JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	ProductKey IS NULL

--FULL ANTI JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
FULL JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	ProductSubcategoryName IS NULL OR ProductKey IS NULL

