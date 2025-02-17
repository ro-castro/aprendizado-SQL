/*1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct.*/

SELECT
	DimProduct.ProductKey AS 'ID do Produto',
	DimProduct.ProductName AS 'Nome do Produto',
	DimProduct.ProductSubcategoryKey AS 'ID da Categoria',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria'
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductCategoryKey

/*2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. Utilize essa coluna para complementar informações na tabela DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.*/

SELECT
	DimProductSubcategory.ProductSubcategoryKey AS 'ID da Subcategoria',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	DimProductSubcategory.ProductCategoryKey AS 'ID da Categoria',
	DimProductCategory.ProductCategoryName AS 'Categoria'
FROM
	DimProductSubcategory
LEFT JOIN
	DimProductCategory
ON
	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

/*3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount,ContinentName e RegionCountryName. Utilizeno LEFT JOIN neste exercício.*/

SELECT
	DimStore.StoreKey AS 'ID da Loja',
	DimStore.StoreName AS 'Loja',
	DimStore.EmployeeCount AS 'Número de Funcionários',
	DimGeography.ContinentName AS 'Continente',
	DimGeography.RegionCountryName AS 'País'
FROM 
	DimStore
LEFT JOIN
	DimGeography
ON
	DimStore.GeographyKey = DimGeography.GeographyKey

/*4. Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes.*/

SELECT
	DimProduct.ProductName AS 'Produto',
	DimProduct.BrandName AS 'Marca',
	DimProduct.ProductDescription AS 'Descrição do Produto',
	DimProduct.ColorID AS 'Cor',
	DimProductCategory.ProductCategoryDescription AS 'Categoria'
FROM
	DimProduct
LEFT JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		LEFT JOIN
			DimProductCategory
		ON
			DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

/*5. A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha 
representa um montante destinado a uma determinada AccountKey.  
a) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela. 
b) Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada 
AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: 
• StrategyPlanKey 
• DateKey 
• AccountName 
• Amount */

SELECT
	FactStrategyPlan.StrategyPlanKey AS 'ID do Aporte',
	FactStrategyPlan.Datekey AS 'Data',
	DimAccount.AccountName AS 'Nome',
	FactStrategyPlan. Amount AS 'Quantidade'
FROM
	FactStrategyPlan
INNER JOIN
	DimAccount
ON
	FactStrategyPlan.AccountKey = DimAccount.AccountKey

/*6. Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que 
identifica o tipo de conta, há também uma outra coluna chamada ScenarioKey. Essa coluna 
possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão. 
Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey 
da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: 
• StrategyPlanKey 
• DateKey 
• ScenarioName  
• Amount */

SELECT
	FactStrategyPlan.StrategyPlanKey AS 'ID do Aporte',
	FactStrategyPlan.Datekey AS 'Data',
	DimScenario.ScenarioName AS 'Cenário',
	FactStrategyPlan. Amount AS 'Quantidade'
FROM
	FactStrategyPlan
INNER JOIN
	DimScenario
ON
	FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey

/*7. Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que 
subcategorias são essas. */

SELECT
	DimProduct.ProductName AS 'Nome do Produto',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria'
FROM
	DimProduct
RIGHT JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	ProductName IS NULL

/*8. A tabela abaixo mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso, Fabrikam e Litware. Crie um código SQL para chegar no mesmo resultado.

BrandName | ChannelName
----------|------------
Contoso   | Catalog
Contoso   | Online
Contoso   | Reseller
Contoso   | Store
Fabrikam  | Catalog
Fabrikam  | Online
Fabrikam  | Reseller
Fabrikam  | Store
Litware   | Catalog
Litware   | Online
Litware   | Reseller
Litware   | Store		*/

SELECT 
	DISTINCT DimProduct.BrandName,
	DimChannel.ChannelName
FROM
	DimProduct
CROSS JOIN
	DimChannel
WHERE 
	BrandName IN ('Contoso', 'Fabrikam', 'Litware')

/*9. Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. Identifique a coluna que as duas tabelas têm em comum e utilize-a para criar esse relacionamento. 
Retorne uma tabela contendo as seguintes colunas: 
• OnlineSalesKey 
• DateKey 
• PromotionName 
• SalesAmount 
A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com desconto (PromotionName <> ‘No Discount’). Além disso, você deverá ordenar essa tabela de acordo com a coluna DateKey, em ordem crescente.*/

SELECT
	FactOnlineSales.OnlineSalesKey AS 'ID da Venda Online',
	FactOnlineSales.DateKey AS 'Data da Venda',
	DimPromotion.PromotionName AS 'Tipo da Promoção',
	FactOnlineSales.SalesAmount AS 'Valor da Venda'

FROM
	FactOnlineSales
INNER JOIN
	DimPromotion
ON
	FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
WHERE
	DimPromotion.PromotionName <> 'No Discount'
ORDER BY
	DateKey ASC

/*10. A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, DimStore e DimProduct. Recrie esta consulta e classifique em ordem decrescente de acordo com SalesAmount.

SalesKey | ChannelName | StoreName | ProductName | SalesAmount */

SELECT TOP (1000)
	FactSales.SalesKey AS 'ID da Venda Online',
	DimChannel.ChannelName AS 'Canal da Venda',
	DimStore.StoreName AS 'Loja',
	DimProduct.ProductName AS 'Produto',
	FactSales.SalesAmount AS 'Valor da Venda'
FROM
	FactSales
LEFT JOIN
	DimChannel
ON
	FactSales.ChannelKey = DimChannel.ChannelKey
LEFT JOIN
	DimStore
ON
	FactSales.StoreKey = DimStore.StoreKey
LEFT JOIN 
	DimProduct
ON 
	FactSales.ProductKey = DimProduct.ProductKey
ORDER BY
	SalesAmount DESC