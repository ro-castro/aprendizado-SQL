--VARIÁVEIS - APLICAÇÕES 
	--Exercício 1: Aplique um desconto de 10% em todos os preços de produtos. Sua consulta final deve conter as colunas ProductKey, ProductNmae, UnitPrice e Preço com desconto.
	
DECLARE
	@desconto float
SET
	@desconto = 0.10
SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Produto',
	UnitPrice AS 'Preço',
	ROUND(UnitPrice * (1 - @desconto), 2) AS 'Preço com desconto'
FROM
	DimProduct

	--Exercício 2: Crie uma variável de data para otimizar a consulta abaixo

SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Cliente' AS 'Tipo'
FROM	
	DimCustomer
WHERE 
	BirthDate >= '01/01/1980'

UNION

SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Funcionário' AS 'Tipo'
FROM	
	DimEmployee
WHERE 
	BirthDate >= '01/01/1980'
ORDER BY 
	Nascimento

--Resposta

	DECLARE
	@data datetime
SET
	@data = '01/01/1980'
SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Cliente' AS 'Tipo'
FROM	
	DimCustomer
WHERE 
	BirthDate >= @data

UNION

SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Funcionário' AS 'Tipo'
FROM	
	DimEmployee
WHERE 
	BirthDate >= @data
ORDER BY 
	Nascimento

--Armazenando valor de SELECT em uma variável
	--Exercício 3: Crie uma variável para armazenar a quantidade total de funcionários da tabela DimEmployee

DECLARE
	@varTotalFuncionarios int
SET
	@varTotalFuncionarios =
		(SELECT
			COUNT(EmployeeKey) 
		FROM
			DimEmployee)
SELECT
	@varTotalFuncionarios

	--Exercício 4: Crie uma variável para armazenar a quantidade total de lojas com o Status 'Off'

DECLARE
	@varLojasFechadas int
SET
	@varLojasFechadas = 
		(SELECT
			COUNT(StoreKey)
		FROM
			DimStore
		WHERE
			Status = 'Off')
SELECT
	@varLojasFechadas

--Armazenando um registro de uma consulta em uma variável
	--Exercício 5: Qual é o nome do produto que teve a maior quantidade vendida em uma única venda da tabela FactSales

DECLARE
	@varIDdoProduto int,
	@varQuantidadeVendida int

	SELECT TOP (1)
		@varIDdoProduto = ProductKey,
		@varQuantidadeVendida = SalesQuantity
	FROM
		FactSales
	ORDER BY
		SalesQuantity DESC
PRINT
	'ID do produto mais vendido: ' + CAST(@varIDdoProduto AS varchar)
PRINT
	'Quantidade vendida: ' + CAST(@varQuantidadeVendida AS varchar)

SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Produto'
FROM
	DimProduct
WHERE
	ProductKey = @varIDdoProduto

--Acumulando valores em uma variável
	--Exercício 6: Printe na tela uma lisa com os nomes das funcionárias do departamento de Marketing

DECLARE
	@varListaNomes varchar (50)
SET
	@varListaNomes = '' --Atribui valor "vazio" para a variável

SELECT
	@varListaNomes = 
		@varListaNomes + 
		FirstName + --Adiciona o primeiro nome À variável
		', ' + 
		CHAR(10) --CHAR(10) comando para pular linha
FROM
	DimEmployee
WHERE
	Gender = 'F' and
	DepartmentName = 'Marketing'
PRINT
	@varListaNomes