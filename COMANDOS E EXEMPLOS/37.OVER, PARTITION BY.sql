/*Window Functions: Cálculos mais avançados de análise de dados, uso semelhante ao GROUP BY, porém mais avançado e personalizável.
Podem ter 3 finalidades:
	1. Cálculos de Agregação: COUNT, SUM, MAX, MIN, AVG
	2. Cálculos de deslocamento: FIRST_VALUE, LAST_VALUE, LEAD, LAG
	3. Cálculos estatísticos: ROW_NUMBER, RANK, DENSE_RANK, NTILE */

--DATABASE e Tabela para exercícios

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
   (3, 'Empórioi Mineirinho', 'Sudeste', 2300),
   (4, 'Central Paulista', 'Sudeste', 1800),
   (5, 'Rio 90 graus', 'Sudeste', 700),
   (6, 'Casa Flor & Anópolis', 'Sul', 2100),
   (7, 'Pampas & Co', 'Sul', 990),
   (8, 'Paraná Papéis', 'Sul', 2800),
   (9, 'Amazonas Prime', 'Norte', 4200),
   (10, 'Pará Bens', 'Norte', 3200),
   (11, 'Tintas Rio Branco', 'Norte', 1500),
   (12, 'Nordestemido Hall', 'Nordeste', 1910),
  (13, 'Cachoerinha Loft', 'Nordeste', 2380)

  --1.Cálculos de agregação

	--OVER: Definir qual será a 'janela' (conjunto de linhas) a ser considerado no cálculo
	--Crie uma coluna contendo a soma total das vendas da tabela Lojas.

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER() AS 'Total de vendas'--OVER sem argumento, considera todas as linhas da tabela
FROM
	Lojas

--PARTITION BY: Divide o conjunto em 'partições' nas quais as funções de janela são aplicadas.
--Crie uma coluna com as vendas por região

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total de Vendas por Região'
FROM
	Lojas

--Calcule o % de participação de cada loja em relação ao total de vendas na loja

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER() AS 'Total de vendas',
	FORMAT((Qtd_Vendida / SUM(Qtd_Vendida) OVER()), '0.00%') AS 'Porcentagem do total'
FROM
	Lojas

--Calcule o % de participação de cada loja em relação ao total de vendas de cada região

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
 	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total de Vendas por Região', --Essa coluna não precisa sser incluida
	FORMAT((Qtd_Vendida / SUM(Qtd_Vendida) OVER(PARTITION BY Regiao)), '0.00%') AS 'Porcentagem por Região'
FROM
	Lojas