/*1. O gerente comercial pediu a voc� uma an�lise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante da empresa:  Store. Utilize uma fun��o SQL para fazer essas consultas no seu banco de dados. Obs: Fa�a essa an�lise considerando a tabela FactSales.*/

SELECT
	SUM(RETURNQUANTITY) AS 'Quantidade devolvida em loja',
	SUM(SALESQUANTITY) AS 'Quantidade vendida em loja'
FROM 
	FACTSALES
WHERE channelKey = 1

SELECT
	*
FROM
	DimStore
WHERE StoreKey = 209

SELECT
	TOP (100) *
FROM
	FactSales
WHERE 
	channelKey = 1

/*2. Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial de todos os clientes da empresa, mas apenas de ocupa��o Professional.  Utilize um comando SQL para atingir esse resultado.*/

SELECT
	AVG(YearlyIncome) AS 'Sal�rio M�dio'
FROM
	DimCustomer
WHERE 
	Occupation = 'Professional'

/*3. Voc� precisar� fazer uma an�lise da quantidade de funcion�rios das lojas registradas na 
empresa. O seu gerente te pediu os seguintes n�meros e informa��es: 
a) Quantos funcion�rios tem a loja com mais funcion�rios? */

SELECT
	MAX(EMPLOYEECOUNT) AS 'N�mero de funcion�rios'
FROM
	DimStore
--b) Qual � o nome dessa loja?

SELECT
	StoreName AS 'Loja com mais funcion�rios'
FROM
	DimStore
WHERE 
	EmployeeCount = 325

--c) Quantos funcion�rios tem a loja com menos funcion�rios?

SELECT
	MIN(EMPLOYEECOUNT) AS 'N�mero de funcion�rios'
FROM
	DimStore

--d) Qual � o nome dessa loja?

SELECT
	StoreName AS 'Loja com MENOS funcion�rios'
FROM
	DimStore
WHERE 
	EmployeeCount = 7

/*4. A �rea de RH est� com uma nova a��o para a empresa, e para isso precisa saber a quantidade 
total de funcion�rios do sexo Masculino e do sexo Feminino.  
a) Descubra essas duas informa��es utilizando o SQL.*/

SELECT
	COUNT(FirstName) AS 'N�mero de Funcion�rios Homens'
FROM
	DimEmployee
WHERE
	GENDER = 'M'

SELECT
	COUNT(FirstName) AS 'N�mero de Funcion�rios Mulheres'
FROM
	DimEmployee
WHERE
	GENDER = 'F'

/*b) O funcion�rio e a funcion�ria mais antigos receber�o uma homenagem. Descubra as 
seguintes informa��es de cada um deles: Nome, E-mail, Data de Contrata��o.*/

SELECT
	TOP (1)
	FirstName AS 'Funcion�rio',
	HireDate AS 'Data de contrata��o',
	EmailAddress AS 'Email'
FROM
	DimEmployee
WHERE
	Gender = 'M'
ORDER BY
	HireDate ASC

SELECT
	TOP (1)
	FirstName AS 'Funcion�ria',
	HireDate AS 'Data de contrata��o',
	EmailAddress AS 'Email'
FROM
	DimEmployee
WHERE
	Gender = 'F'
ORDER BY
	HireDate ASC

/*5. Agora voc� precisa fazer uma an�lise dos produtos. Ser� necess�rio descobrir as seguintes 
informa��es: 
a) Quantidade distinta de cores de produtos.
b) Quantidade distinta de marcas 
c) Quantidade distinta de classes de produto 
Para simplificar, voc� pode fazer isso em uma mesma consulta.*/

SELECT
	COUNT(DISTINCT ColorName) AS 'Cores Dispon�veis',
	COUNT(DISTINCT BrandName) AS 'Marcas Dispon�veis',
	COUNT(DISTINCT ClassName) AS 'Classes Dispon�veis'
FROM
	DimProduct
