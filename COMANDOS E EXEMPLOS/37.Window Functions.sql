/*Window Functions: C�lculos mais avan�ados de an�lise de dados, uso semelhante ao GROUP BY, por�m mais avan�ado e personaliz�vel.
Podem ter 3 finalidades:
	1. C�lculos de Agrega��o: COUNT, SUM, MAX, MIN, AVG
	2. C�lculos de deslocamento: FIRST_VALUE, LAST_VALUE, LEAD, LAG
	3. C�lculos estat�sticos: RANK, DENSE_RANK, NTILE */

--OVER: Definir qual ser� a 'janela' (conjunto de linhas) a ser considerado no c�lculo
--Crie uma coluna com a maior BaseRate de todos funcion�rios

SELECT
	EmployeeKey,
	FirstName,
	Title,
	DepartmentName,
	MAX(BaseRate) OVER() --OVER sem argumento, considera todas as linhas da tabela
FROM
	DimEmployee

--PARTITION BY: Divide o conjunto em 'parti��es' nas quais as fun��es de janela s�o aplicadas.
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