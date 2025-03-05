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
			
/*5. A partir da view criada no exercício anterior, você deverá fazer uma soma móvel considerando sempre o mês atual + 2 meses para trás.*/

SELECT
	*,
	SUM([Quantidade de lojas]) OVER(ORDER BY [ID] ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma móvel 2 meses'
FROM
	vwHistoricoLojas

/*6. Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/mês. */

SELECT
	*,
	SUM([Quantidade de lojas]) OVER(ORDER BY [ID] ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado'
FROM
	vwHistoricoLojas

--DESAFIO 2
/*
PASSO 1: Crie um novo banco de dados chamado Desafio e selecione esse banco de dados criado. 
PASSO 2: Crie uma tabela de datas entre o dia 1 de janeiro do ano com a compra (DateFirstPurchase) mais antiga e o dia 31 de dezembro do ano com a compra mais recente.   
PASSO 3: Crie colunas auxiliares na tabela Calendario chamadas: Ano, Mes, Dia, AnoMes tipo INT e NomeMes tipo VARCHAR.
PASSO 4: Adicione na tabela os valores de Ano, Mês, Dia, AnoMes e NomeMes (nome do mês em português). Dica: utilize a instrução CASE para verificar o mês e retornar o nome certo. 
PASSO 5: Crie a View vwNovosClientes, que deve ter as colunas mostradas abaixo. */

--Passo 1
CREATE DATABASE
	Desafio
--Passo 2
CREATE TABLE
	Calendario (data DATE)
DECLARE
	@varAnoInicial INT = YEAR((SELECT MIN(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))
DECLARE
	@varAnoFinal INT = YEAR((SELECT MAX(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))
DECLARE
	@varDataInicial DATE = DATEFROMPARTS(@varAnoInicial, 1, 1)
DECLARE
	@varDataFinal DATE = DATEFROMPARTS(@varAnoFinal, 12, 31)
WHILE
	@varDataInicial <= @varDataFinal
BEGIN
	INSERT INTO	
		Calendario(data) VALUES(@varDataInicial)
	SET
		@varDataInicial = DATEADD(DAY, 1, @varDataInicial)
END
--Passo 3
ALTER TABLE
	Calendario
ADD
	Ano INT,
	Mes INT,
	Dia INT,
	AnoMes INT,
	NomeMes VARCHAR (50)
--Passo 4
UPDATE Calendario SET Ano = Year(data)
UPDATE Calendario SET Mes = Month(data)
UPDATE Calendario SET Dia = Day(data)
UPDATE Calendario SET AnoMes = CONCAT(Year(data), Format(MONTH(Data), '00'))
UPDATE Calendario SET NomeMes = 
	CASE
		WHEN Month(Data) = 1 THEN 'Janeiro'
		WHEN Month(Data) = 2 THEN 'Fevereiro'
		WHEN Month(Data) = 3 THEN 'Março'
		WHEN Month(Data) = 4 THEN 'Abril'
		WHEN Month(Data) = 5 THEN 'Maio'
		WHEN Month(Data) = 6 THEN 'Junho'
		WHEN Month(Data) = 7 THEN 'Julho'
		WHEN Month(Data) = 8 THEN 'Agosto'
		WHEN Month(Data) = 9 THEN 'Setembro'
		WHEN Month(Data) = 10 THEN 'Outubro'
		WHEN Month(Data) = 11 THEN 'Novembro'
		WHEN Month(Data) = 12 THEN 'Dezembro'
	END
--Passo 5
GO
CREATE VIEW
	vwNovosClientes AS
		SELECT
			ROW_NUMBER() OVER(ORDER BY AnoMes) AS 'ID',
			Ano,
			NomeMes,
			COUNT(DimCustomer.DateFirstPurchase) AS 'Novos_Clientes'
		FROM
			Calendario
		LEFT JOIN
			ContosoRetailDW.dbo.DimCustomer
		ON
			Calendario.data = DimCustomer.DateFirstPurchase
		GROUP BY Ano, NomeMes, AnoMes
GO
SELECT
	*
FROM
	vwNovosClientes
/*7.  
a) Faça um cálculo de soma móvel de novos clientes nos últimos 2 meses. 
b) Faça um cálculo de média móvel de novos clientes nos últimos 2 meses. 
c) Faça um cálculo de acumulado dos novos clientes ao longo do tempo.  
d) Faça um cálculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a 
dezembro de cada ano, e volta a fazer o cálculo de acumulado no ano seguinte.*/ 

SELECT  
	*, 
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel (2 meses)', 
	AVG(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Média Móvel (2 meses)', 
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado Total', 
	SUM(Novos_Clientes) OVER(PARTITION BY Ano ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado (YTD)' 
FROM
	vwNovosClientes
			
--8. Faça os cálculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes, entre o mês atual e o mês anterior, e entre um mês atual e o mesmo mês do ano anterior.

SELECT 
	*, 
	FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 1) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% MoM', 
	FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 12) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% YoY' 
FROM
	vwNovosClientes 