SELECT 
	*
FROM 
	DimEmployee
WHERE 
	NOT DepartmentName = 'MARKETING'

SELECT
	*
FROM
	DimEmployee
WHERE 
	 Gender = 'F' AND DepartmentName = 'FINANCE'

SELECT
	*
FROM
	DimProduct
WHERE 
	BrandName = 'CONTOSO' AND UNITPRICE >= 100 AND ColorName = 'RED'

SELECT
	*
FROM 
	DimProduct
WHERE 
	BrandName = 'LITWARE' OR BRANDNAME = 'FARIKAM' OR COLORNAME = 'BLACK'

SELECT
	*
FROM
	DimSalesTerritory
WHERE 
	SalesTerritoryGroup = 'EUROPE' AND NOT SalesTerritoryCountry = 'ITALY'

SELECT
	*
FROM 
	DIMPRODUCT
WHERE 
	(ColorName = 'BLACK' OR ColorName = 'RED') AND BrandName = 'FABRIKAM'

	SELECT
	*
FROM
	DimProduct
WHERE 
	ColorName IN  ('silver', 'blue', 'white', 'black')

SELECT
	*
FROM
	DimEmployee 
WHERE
	DepartmentName IN ('PRODUCTION', 'MARKETING', 'ENGINEERING')
	