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