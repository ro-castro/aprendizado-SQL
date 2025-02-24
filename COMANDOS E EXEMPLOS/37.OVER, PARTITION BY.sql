/*Window Functions: C�lculos mais avan�ados de an�lise de dados, uso semelhante ao GROUP BY, por�m mais avan�ado e personaliz�vel.
Podem ter 3 finalidades:
	1. C�lculos de Agrega��o: COUNT, SUM, MAX, MIN, AVG
	2. C�lculos de deslocamento: FIRST_VALUE, LAST_VALUE, LEAD, LAG
	3. C�lculos estat�sticos: ROW_NUMBER, RANK, DENSE_RANK, NTILE */

--DATABASE e Tabela para exerc�cios

CREATE DATABASE
	WF

USE WF

CREATE TABLE Lojas(
   ID_Loja INT,
   Nome_Loja VARCHAR(100),
   Regiao VARCHAR(100),
   Qtd_Vendida FLOAT
)

INSERT INTO Lojas(ID_Loja, Nome_Loja, Regiao, Qtd_Vendida)
VALUES
   (1, 'Botafogo Praia&Mar', 'Sudeste', 1800),
   (2, 'Lojas Vitoria', 'Sudeste', 800),
   (3, 'Emp�rioi Mineirinho', 'Sudeste', 2300),
   (4, 'Central Paulista', 'Sudeste', 1800),
   (5, 'Rio 90 graus', 'Sudeste', 700),
   (6, 'Casa Flor & An�polis', 'Sul', 2100),
   (7, 'Pampas & Co', 'Sul', 990),
   (8, 'Paran� Pap�is', 'Sul', 2800),
   (9, 'Amazonas Prime', 'Norte', 4200),
   (10, 'Par� Bens', 'Norte', 3200),
   (11, 'Tintas Rio Branco', 'Norte', 1500),
   (12, 'Nordestemido Hall', 'Nordeste', 1910),
  (13, 'Cachoerinha Loft', 'Nordeste', 2380)

  --1.C�lculos de agrega��o

	--OVER: Definir qual ser� a 'janela' (conjunto de linhas) a ser considerado no c�lculo
	--Crie uma coluna contendo a soma total das vendas da tabela Lojas.

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER() AS 'Total de vendas'--OVER sem argumento, considera todas as linhas da tabela
FROM
	Lojas

--PARTITION BY: Divide o conjunto em 'parti��es' nas quais as fun��es de janela s�o aplicadas.
--Crie uma coluna com as vendas por regi�o

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total de Vendas por Regi�o'
FROM
	Lojas

--Calcule o % de participa��o de cada loja em rela��o ao total de vendas na loja

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER() AS 'Total de vendas',
	FORMAT((Qtd_Vendida / SUM(Qtd_Vendida) OVER()), '0.00%') AS 'Porcentagem do total'
FROM
	Lojas

--Calcule o % de participa��o de cada loja em rela��o ao total de vendas de cada regi�o

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
 	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total de Vendas por Regi�o', --Essa coluna n�o precisa sser incluida
	FORMAT((Qtd_Vendida / SUM(Qtd_Vendida) OVER(PARTITION BY Regiao)), '0.00%') AS 'Porcentagem por Regi�o'
FROM
	Lojas