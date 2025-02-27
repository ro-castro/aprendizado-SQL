/*Para resolver os exercícios 1 a 4, crie uma View chamada vwProdutos, que contenha o 
agrupamento das colunas BrandName, ColorName e os totais de quantidade vendida por 
marca/cor e também o total de receita por marca/cor. */
GO
CREATE VIEW 
	vwProdutos AS 
		SELECT 
			BrandName AS 'Marca', 
			ColorName AS 'Cor', 
			SUM(SalesQuantity) AS 'Quantidade_Vendida', 
			ROUND(SUM(SalesAmount), 2) AS 'Receita_Total' 
		FROM 
			DimProduct 
		INNER JOIN 
			FactSales 
		ON 
			DimProduct.ProductKey = FactSales.ProductKey 
		GROUP BY 
			BrandName, 
			ColorName

--1. Utilize a View vwProdutos para criar uma coluna extra calculando a quantidade total vendida dos produtos.

GO
SELECT
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Total Vendido'
FROM
	vwProdutos
ORDER BY
	Marca

--2. Crie mais uma coluna na consulta anterior, incluindo o total de produtos vendidos para cada marca. 

GO
SELECT
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Total Vendido',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Total Vendido por Marca'
FROM
	vwProdutos
ORDER BY
	Marca

--3. Calcule o % de participação do total de vendas de produtos por marca.  

GO
SELECT
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Total Vendido',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Total Vendido por Marca',
	FORMAT(CAST(SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS float) / CAST(SUM(Quantidade_Vendida) OVER() AS float), '0.00%') AS '% de participação por marca'
FROM
	vwProdutos
ORDER BY
	Marca

--4. Crie uma consulta à View vwProdutos, selecionando as colunas Marca, Cor, Quantidade_Vendida e também criando uma coluna extra de Rank para descobrir a posição de cada Marca/Cor.
--Obs: Sua consulta deve ser filtrada para que seja mostrada apenas a marca Contoso. 

SELECT
	Marca,
	Cor,
	Quantidade_Vendida,
	RANK() OVER(ORDER BY Quantidade_Vendida DESC) AS 'Rank'
FROM
	vwProdutos
WHERE
	Marca = 'Contoso'

--DESAFIO 1
--Para responder os próximos 2 exercícios, você precisará criar uma View auxiliar. 
--A sua view deve se chamar vwHistoricoLojas e deve conter um histórico com a quantidade de lojas abertas a cada Ano/Mês. Os desafios são: 
--(1) Criar uma coluna de ID para essa View 
--(2) Relacionar as tabelas DimDate e DimStore

GO
CREATE VIEW
	vwHistoricoLojas AS
		SELECT
			ROW_NUMBER () OVER(ORDER BY CalendarMonth) AS 'ID',
			CalendarYear AS 'Ano',
			CalendarMonthLabel AS 'Mês',
			COUNT (OpenDate) AS 'Quantidade de lojas'
		FROM
			DimDate
		LEFT JOIN
			DimStore
		ON 
			DimDate.Datekey = DimStore.OpenDate
		GROUP BY 
			CalendarMonth,
			CalendarYear,
			CalendarMonthLabel			