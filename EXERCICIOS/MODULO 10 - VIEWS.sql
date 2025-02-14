/*1. a) A partir da tabela DimProduct, crie uma View contendoas informa��es de ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View de vwProdutos. */

GO
CREATE VIEW
	vwProdutos AS
		SELECT
			ProductName AS 'Produto',
			ColorName AS 'Cor',
			UnitPrice AS 'Pre�o',
			UnitCost AS 'Custo'
		FROM
			DimProduct

--b) A partir da tabela DimEmployee, crie uma View mostrandoFirstName, BirthDate, DepartmentName. Chame essa View de vwFuncionarios. 

GO
CREATE VIEW
	vwFuncionarios AS
		SELECT
			FirstName AS 'Nome',
			BirthDate AS 'Data de Nascimento',
			DepartmentName AS 'Departamento'
		FROM
			DimEmployee

--c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e OpenDate. Chame essa View de vwLojas. 
GO
CREATE VIEW
	vwLojas AS
		SELECT
			StoreKey AS 'ID da Loja',
			StoreName AS 'Loja',
			OpenDate AS 'Inaugura��o'
		FROM
			DimStore

--2. Crie uma View contendo as informa��es de Nome Completo (FirstName + LastName), G�nero (por extenso), E-mail e Renda Anual (formatada com R$). Utilize a tabela DimCustomer. Chame essa View de vwClientes. 

GO
CREATE VIEW
	vwClientes AS
		SELECT
			CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
			REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Sexo',
			EmailAddress AS 'Email',
			FORMAT(YearlyIncome, 'C') AS 'Renda anual'
		FROM
			DimCustomer

/*3. a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Fa�a um SELECT de todas as colunas. Chame essa View de vwLojasAtivas. */

GO
CREATE VIEW
	vwLojasAtivas AS
		SELECT
			*
		FROM
			DimStore
		WHERE
			Status = 'On'


--b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os funcion�rios da �rea de Marketing. Fa�a um SELECT das colunas: FirstName, EmailAddress e DepartmentName. Chame essa de vwFuncionariosMkt. 

GO
CREATE VIEW
	vwFuncionariosMkt AS
		SELECT
			FirstName AS 'Nome',
			EmailAddress AS 'Email',
			DepartmentName AS 'Departamento'
		FROM
			DimEmployee
		WHERE
			DepartmentName = 'Marketing'

--c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e Litware. Al�m disso, a sua View deve considerar apenas os produtos de cor Silver. Fa�a um SELECT de todas as colunas da tabela DimProduct. Chame essa View de vwContosoLitwareSilver.

GO
CREATE VIEW
	vwContosoLitwareSilver AS
		SELECT
			*
		FROM
			DimProduct
		WHERE
			BrandName IN ('Contoso', 'Litware') AND
			ColorName = 'Silver'	

/*4. Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do Produto. Chame esta View de vwTotalVendidoProdutos. 
OBS: Para isso, voc� ter� que utilizar um JOIN para relacionar as tabelas FactSales e 
DimProduct. */

GO
CREATE VIEW
	vwTotalVendidoProdutos AS
		SELECT
			ProductName AS 'Produto',
			SUM(SalesQuantity) AS'QuantidadeVendida'
		FROM
			FactSales
		INNER JOIN
			DimProduct
		ON
			FactSales.ProductKey = DimProduct.ProductKey
		GROUP BY
			ProductName
	
/*5. Fa�a as seguintes altera��es nas tabelas da quest�o 1. 
a. Na View criada na letra a da quest�o 1, adicione a coluna de BrandName.*/


GO
ALTER VIEW
	vwProdutos AS
		SELECT
			ProductName AS 'Produto',
			BrandName AS 'Marca',
			ColorName AS 'Cor',
			UnitPrice AS 'Pre�o',
			UnitCost AS 'Custo'
		FROM
			DimProduct


--b. Na View criada na letra b da quest�o 1, fa�a um filtro e considere apenas os funcion�rios do sexo feminino. 

GO
ALTER VIEW
	vwFuncionarios AS
		SELECT
			FirstName AS 'Nome',
			BirthDate AS 'Data de Nascimento',
			DepartmentName AS 'Departamento'
		FROM
			DimEmployee
		WHERE
			Gender = 'F'

--c. Na View criada na letra c da quest�o 1, fa�a uma altera��o e filtre apenas as lojas ativas.

GO
ALTER VIEW
	vwLojas AS
		SELECT
			StoreKey AS 'ID da Loja',
			StoreName AS 'Loja',
			OpenDate AS 'Inaugura��o'
		FROM
			DimStore
		WHERE 
			Status = 'On'

/*6. a) Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O resultado esperado da consulta dever� ser o total de produtos por marca. Chame essa View de vw_6a.*/

GO
CREATE VIEW
	vw_6a AS
		SELECT
			BrandName AS 'Marca',
			COUNT(ProductKey) AS 'Quantidade de Produtos'
		FROM 
			DimProduct
		GROUP BY
			BrandName

--b) Altere a View criada no exerc�cio anterior, adicionando o peso total por marca. Aten��o: sua View final dever� ter ent�o 3 colunas: Nome da Marca, Total de Produtos e Peso Total. 

GO
ALTER VIEW
	vw_6a AS
			SELECT
				BrandName AS 'Marca',
				COUNT(ProductKey) AS 'Quantidade de Produtos',
				SUM(Weight) AS 'Peso Total'
			FROM 
				DimProduct
			GROUP BY
				BrandName
	
--c) Exclua a View vw_6a.

GO
	DROP VIEW
		vw_6a