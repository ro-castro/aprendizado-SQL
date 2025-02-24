--2. C�lculos estat�sticos

	--ROW_NUMER: Numera os resultados de acordo com classifica��o indicada
	--RANK: Parecido, por�m, quando tem um empate, o valor do RANK � igual. O �ltimo valor � o n�mero de linhas
	--DENSE_RANK: Igual o RANK, por�m o �ltimo valor � o n�mero de linhas com valores distintos
	--NTILE: Divide os resultados em grupos, �nica que leva argumento (n�mero de grupos)

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'Row Number',
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'Rank',
	DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'Dense Rank',
	NTILE(2) OVER(ORDER BY Qtd_Vendida DESC) AS 'NTILE'
FROM
	Lojas

--Integrando com PARTITION BY
	--Faz a numera��o de acordo com o PARTITION BY

SELECT
	ID_Loja, 
	Nome_Loja, 
	Regiao, 
	Qtd_Vendida,
	ROW_NUMBER() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'Row Number',
	RANK() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'Rank',
	DENSE_RANK() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'Dense Rank',
	NTILE(3) OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'NTILE'
FROM
	Lojas
ORDER BY
	ID_Loja

--Integrando com GROUP BY

	--Crie uma tabela com o total de vendas por regi�o e adicione uma coluna de rank

SELECT
	Regiao, 
	SUM(Qtd_Vendida) AS 'Total de vendas',
	RANK() OVER(ORDER BY SUM(Qtd_Vendida) DESC) AS 'Rank'
FROM
	Lojas
GROUP BY
	Regiao
ORDER BY
	[Total de vendas] DESC
	