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

	--Cálculo MoM (Month over Month): Variação de um mês em relação à outro
		-- (Valor mês atual) / (Valor mês anterior) - 1

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	FORMAT((Faturamento_MM / LAG(Faturamento_MM, 1) OVER(ORDER BY Data_Fechamento)) - 1, '0.00%') AS '% MoM'
FROM
	Resultado

	--Outra forma de resolver usando o terceiro argumento do LAG
		--NULLIF: Caso o valor do primeiro seja diferente do segundo, retorna o primeiro, caso seja igual, retorna NULL

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	FORMAT((Faturamento_MM / NULLIF(LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento), 0)) - 1, '0.00%') AS '% MoM'
FROM
	Resultado

	--FIRST_VALUE: Retorna o primeiro valor da coluna especificada

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	FIRST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento ASC) AS 'Primeiro valor'
FROM
	Resultado
ORDER BY
	Data_Fechamento 

	--LAST_VALUE: Retorna o último valor da coluna especificada
		--Necessário especificar também as linhas, se não vai retornar o valor da linha atual

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	LAST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Último valor'
FROM
	Resultado
ORDER BY
	Data_Fechamento 