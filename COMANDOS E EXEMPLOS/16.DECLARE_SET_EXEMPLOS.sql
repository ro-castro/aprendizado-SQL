--VARI�VEIS - APLICA��ES 
	--Exerc�cio 1: Aplique um desconto de 10% em todos os pre�os de produtos. Sua consulta final deve conter as colunas ProductKey, ProductNmae, UnitPrice e Pre�o com desconto.
	
DECLARE
	@desconto float
SET
	@desconto = 0.10
SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Produto',
	UnitPrice AS 'Pre�o',
	ROUND(UnitPrice * (1 - @desconto), 2) AS 'Pre�o com desconto'
FROM
	DimProduct

	--Exerc�cio 2: Crie uma vari�vel de data para otimizar a consulta abaixo

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
	'Funcion�rio' AS 'Tipo'
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
	'Funcion�rio' AS 'Tipo'
FROM	
	DimEmployee
WHERE 
	BirthDate >= @data
ORDER BY 
	Nascimento

--Armazenando valor de SELECT em uma vari�vel
	--Exerc�cio 3: Crie uma vari�vel para armazenar a quantidade total de funcion�rios da tabela DimEmployee

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

	--Exerc�cio 4: Crie uma vari�vel para armazenar a quantidade total de lojas com o Status 'Off'

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

--Armazenando um registro de uma consulta em uma vari�vel
	--Exerc�cio 5: Qual � o nome do produto que teve a maior quantidade vendida em uma �nica venda da tabela FactSales

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

--Acumulando valores em uma vari�vel
	--Exerc�cio 6: Printe na tela uma lisa com os nomes das funcion�rias do departamento de Marketing

DECLARE
	@varListaNomes varchar (50)
SET
	@varListaNomes = '' --Atribui valor "vazio" para a vari�vel

SELECT
	@varListaNomes = 
		@varListaNomes + 
		FirstName + --Adiciona o primeiro nome � vari�vel
		', ' + 
		CHAR(10) --CHAR(10) comando para pular linha
FROM
	DimEmployee
WHERE
	Gender = 'F' and
	DepartmentName = 'Marketing'
PRINT
	@varListaNomes