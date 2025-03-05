/*Para resolver os exerc�cios 1 a 4, crie uma View chamada vwProdutos, que contenha o 
agrupamento das colunas BrandName, ColorName e os totais de quantidade vendida por 
marca/cor e tamb�m o total de receita por marca/cor. */
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

--3. Calcule o % de participa��o do total de vendas de produtos por marca.  

GO
SELECT
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Total Vendido',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Total Vendido por Marca',
	FORMAT(CAST(SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS float) / CAST(SUM(Quantidade_Vendida) OVER() AS float), '0.00%') AS '% de participa��o por marca'
FROM
	vwProdutos
ORDER BY
	Marca

--4. Crie uma consulta � View vwProdutos, selecionando as colunas Marca, Cor, Quantidade_Vendida e tamb�m criando uma coluna extra de Rank para descobrir a posi��o de cada Marca/Cor.
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
--Para responder os pr�ximos 2 exerc�cios, voc� precisar� criar uma View auxiliar. 
--A sua view deve se chamar vwHistoricoLojas e deve conter um hist�rico com a quantidade de lojas abertas a cada Ano/M�s. Os desafios s�o: 
--(1) Criar uma coluna de ID para essa View 
--(2) Relacionar as tabelas DimDate e DimStore

GO
CREATE VIEW
	vwHistoricoLojas AS
		SELECT
			ROW_NUMBER () OVER(ORDER BY CalendarMonth) AS 'ID',
			CalendarYear AS 'Ano',
			CalendarMonthLabel AS 'M�s',
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
			
/*5. A partir da view criada no exerc�cio anterior, voc� dever� fazer uma soma m�vel considerando sempre o m�s atual + 2 meses para tr�s.*/

SELECT
	*,
	SUM([Quantidade de lojas]) OVER(ORDER BY [ID] ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma m�vel 2 meses'
FROM
	vwHistoricoLojas

/*6. Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/m�s. */

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
PASSO 4: Adicione na tabela os valores de Ano, M�s, Dia, AnoMes e NomeMes (nome do m�s em portugu�s). Dica: utilize a instru��o CASE para verificar o m�s e retornar o nome certo. 
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
		WHEN Month(Data) = 3 THEN 'Mar�o'
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
a) Fa�a um c�lculo de soma m�vel de novos clientes nos �ltimos 2 meses. 
b) Fa�a um c�lculo de m�dia m�vel de novos clientes nos �ltimos 2 meses. 
c) Fa�a um c�lculo de acumulado dos novos clientes ao longo do tempo.  
d) Fa�a um c�lculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a 
dezembro de cada ano, e volta a fazer o c�lculo de acumulado no ano seguinte.*/ 

SELECT  
	*, 
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma M�vel (2 meses)', 
	AVG(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'M�dia M�vel (2 meses)', 
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado Total', 
	SUM(Novos_Clientes) OVER(PARTITION BY Ano ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado (YTD)' 
FROM
	vwNovosClientes
			
--8. Fa�a os c�lculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes, entre o m�s atual e o m�s anterior, e entre um m�s atual e o mesmo m�s do ano anterior.

SELECT 
	*, 
	FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 1) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% MoM', 
	FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 12) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% YoY' 
FROM
	vwNovosClientes 