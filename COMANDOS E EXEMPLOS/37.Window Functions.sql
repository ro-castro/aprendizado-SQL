/*Window Functions: Cálculos mais avançados de análise de dados, uso semelhante ao GROUP BY, porém mais avançado e personalizável.
Podem ter 3 finalidades:
	1. Cálculos de Agregação: COUNT, SUM, MAX, MIN, AVG
	2. Cálculos de deslocamento: FIRST_VALUE, LAST_VALUE, LEAD, LAG
	3. Cálculos estatísticos: RANK, DENSE_RANK, NTILE */

--OVER: Definir qual será a 'janela' (conjunto de linhas) a ser considerado no cálculo
--Crie uma coluna com a maior BaseRate de todos funcionários

SELECT
	EmployeeKey,
	FirstName,
	Title,
	DepartmentName,
	MAX(BaseRate) OVER() --OVER sem argumento, considera todas as linhas da tabela
FROM
	DimEmployee

--PARTITION BY: Divide o conjunto em 'partições' nas quais as funções de janela são aplicadas.
--Crie uma coluna com a maior BaseRate separado por DepartmentName

SELECT
	EmployeeKey,
	FirstName,
	Title,
	DepartmentName,
	MAX(BaseRate) OVER(PARTITION BY DepartmentName)
FROM
	DimEmployee

----Crie uma coluna com a soma de BaseRate separado por Title

SELECT
	EmployeeKey,
	FirstName,
	Title,
	DepartmentName,
	SUM(BaseRate) OVER(PARTITION BY Title)
FROM
	DimEmployee