--Funções de Offset: Cria uma coluna com os valores deslocados N linhas
--3 argumentos (Coluna deslocada, numero de linhas deslocadas, valor considerado em NULL)
	--LAG: Desloca as linhas para baixo

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Lag' --Ordenou pela data, e deslocou os valores do Faturamento, uma linha abaixo
FROM
	Resultado

	--Lead: Desloca as linhas para cima
	
SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	LEAD(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Lead' --Ordenou pela data, e deslocou os valores do Faturamento, uma linha a cima
FROM
	Resultado