/*1. O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante da empresa:  Store. Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa análise considerando a tabela FactSales.*/

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

/*2. Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes da empresa, mas apenas de ocupação Professional.  Utilize um comando SQL para atingir esse resultado.*/

SELECT
	AVG(YearlyIncome) AS 'Salário Médio'
FROM
	DimCustomer
WHERE 
	Occupation = 'Professional'

/*3. Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na 
empresa. O seu gerente te pediu os seguintes números e informações: 
a) Quantos funcionários tem a loja com mais funcionários? */

SELECT
	MAX(EMPLOYEECOUNT) AS 'Número de funcionários'
FROM
	DimStore
--b) Qual é o nome dessa loja?

SELECT
	StoreName AS 'Loja com mais funcionários'
FROM
	DimStore
WHERE 
	EmployeeCount = 325

--c) Quantos funcionários tem a loja com menos funcionários?

SELECT
	MIN(EMPLOYEECOUNT) AS 'Número de funcionários'
FROM
	DimStore

--d) Qual é o nome dessa loja?

SELECT
	StoreName AS 'Loja com MENOS funcionários'
FROM
	DimStore
WHERE 
	EmployeeCount = 7

/*4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade 
total de funcionários do sexo Masculino e do sexo Feminino.  
a) Descubra essas duas informações utilizando o SQL.*/

SELECT
	COUNT(FirstName) AS 'Número de Funcionários Homens'
FROM
	DimEmployee
WHERE
	GENDER = 'M'

SELECT
	COUNT(FirstName) AS 'Número de Funcionários Mulheres'
FROM
	DimEmployee
WHERE
	GENDER = 'F'

/*b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as 
seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.*/

SELECT
	TOP (1)
	FirstName AS 'Funcionário',
	HireDate AS 'Data de contratação',
	EmailAddress AS 'Email'
FROM
	DimEmployee
WHERE
	Gender = 'M'
ORDER BY
	HireDate ASC

SELECT
	TOP (1)
	FirstName AS 'Funcionária',
	HireDate AS 'Data de contratação',
	EmailAddress AS 'Email'
FROM
	DimEmployee
WHERE
	Gender = 'F'
ORDER BY
	HireDate ASC

/*5. Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes 
informações: 
a) Quantidade distinta de cores de produtos.
b) Quantidade distinta de marcas 
c) Quantidade distinta de classes de produto 
Para simplificar, você pode fazer isso em uma mesma consulta.*/

SELECT
	COUNT(DISTINCT ColorName) AS 'Cores Disponíveis',
	COUNT(DISTINCT BrandName) AS 'Marcas Disponíveis',
	COUNT(DISTINCT ClassName) AS 'Classes Disponíveis'
FROM
	DimProduct
