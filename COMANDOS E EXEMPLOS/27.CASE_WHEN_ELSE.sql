--Fun��es Condicionais

--CASE WHEN: permite tratar condi��es no SQL, come�a com CASE e termina com END

/*
SELECT
	CASE
		WHEN teste_logico THEN 'resultado1'
		ELSE 'resultado2'
	END
*/

-- Exemplo 1: Determine a situa��o do aluno. Se a M�dia for >= 6, ent�o est� aprovado. Caso contr�rio, reprovado.

DECLARE
	@varNota float = 7

SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situa��o'			

-- Exemplo 2: A data de vencimento de um produto � no dia 10/03/2022. Fa�a um teste l�gico para verificar se um produto passou da validade ou n�o.

DECLARE
	@validadeproduto date = '10/03/2027'

SELECT
	CASE
		WHEN @validadeproduto > GETDATE() THEN 'N�o vencido'
		ELSE 'Vencido'
	END AS 'Condi��o'


--CASE WHEN WHEN: Permite mais testes l�gicos. Faz os testes l�gicos de cima para baixo.

/*
SELECT
	CASE
		WHEN teste_logico1 THEN 'resultado1'
		WHEN teste_logico2 THEN 'resultado2'
		ELSE 'resultado3'
	END

Exemplo 1:

Crie um c�digo para verificar a nota do aluno e determinar a situa��o:
- Aprovado: nota maior ou igual a 6
- Prova final: noa entre 4 e 6
- Reprovado: nota abaixo de 4 */

DECLARE @varNota1 FLOAT = 6
SELECT
	CASE
		WHEN @varNota1 >= 6 THEN 'Aprovado'
		WHEN @varNota1 >= 4 THEN 'Recupera��o'
		ELSE 'Reprovado'
	END AS 'Situa��o'

-- Exemplo 2: Classifique o produto de acordo com o seu pre�o:
-- Pre�o >= 40000: Luxo
-- Pre�o >= 10000 e Pre�o < 40000: Econ�mico
-- Pre�o < 10000: B�sico

DECLARE
	@preco float = 1000
SELECT
	CASE	
		WHEN @preco >= 4000 THEN 'Luxo' 
		WHEN @preco >= 1000 THEN 'Econ�mico'
		ELSE 'B�sico'
	END AS 'Classifica��o'

--Exemplo Contoso
--a.Fa�a um select das colunas CustomerKey, FirstName e Gender da tabela DimCustomer e utilize o CASE para criar uma quarta coluna com a informa��o 'Maculino' ou 'Feminino'

SELECT
	CustomerKey AS 'ID do Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo (abrev.)',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		ELSE 'Feminino'
	END AS 'Sexo'
FROM	
	DimCustomer

--b Verifique se ser� necess�rio fazer alguma corre��o

SELECT
	CustomerKey AS 'ID do Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo (abrev.)',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		WHEN Gender = 'F' THEN 'Feminino'
		ELSE 'Empresa'
	END AS 'Sexo'
FROM	
	DimCustomer

--CASE WHEN + AND/OR

--Fa�a uma consulta � tabela DimProduct, e retorne o as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna do pre�o com desconto
--a.)Caso o produto seja da Contoso e da cor Red, o desconto do produto ser� de 10%. Caso contr�rio. n�o ter� desconto.

SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o',
	CASE
		WHEN BrandName = 'Contoso' AND
		ColorName = 'Red' THEN (CAST(UnitPrice - UnitPrice * 0.1 AS float))
		ELSE UnitPrice
	END AS 'Pre�o com desconto'
FROM
	DimProduct

--b. Caso o produto seja da marca Litware ou Fabrikan, ele recebe um desconto de 5%, caso contr�rio, n�o recebe desconto.

SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o',
	CASE
		WHEN BrandName = 'Litware' OR
		BrandName = 'Fabrikan' THEN (CAST(UnitPrice - UnitPrice * 0.05 AS float))
		ELSE 0
	END AS 'Pre�o com desconto'
FROM
	DimProduct

--CASE Aninhado: Uma condi��o dentro de outra condi��o

--Situa��o: C�lculo do b�nus

--Sales Group Manager: Se fot assalariado, 30%, se n�o, 20%
--Sales Region Manager: 15%
--Sales State Manager: 7%
--Sales Store Manager: 2%

--Assalariado (SelariedFlag)
-- 0 = n�o asslariado
-- 1 = assalariado

SELECT
	FirstName,
	Title,
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' THEN
		CASE
			WHEN SalariedFlag = 1 THEN 0.3
			ELSE 0.2
		END
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title = 'Sales State Manager' THEN 0.07
		ELSE 0.02
	END AS 'B�nus'
FROM
	DimEmployee

--CASE Aditivo: adi��o de condi��es

-- Os produtos da categoria 'TV and Video' ter�o um desconto de 10%
-- Se al�m de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receber� mais 5%. Total, 15%

SELECT
	ProductKey,
	ProductName,
	ProductCategoryName,
	ProductSubcategoryName,	
	UnitPrice,
		CASE	
			WHEN ProductCategoryName = 'TV and Video' THEN 0.1
			ELSE 0
		END
		+
		CASE	
			WHEN ProductSubcategoryName = 'Televisions' THEN 0.05
			ELSE 0
		END AS 'Desconto'
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey


