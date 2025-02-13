--Funções Condicionais

--CASE WHEN: permite tratar condições no SQL, começa com CASE e termina com END

/*
SELECT
	CASE
		WHEN teste_logico THEN 'resultado1'
		ELSE 'resultado2'
	END
*/

-- Exemplo 1: Determine a situação do aluno. Se a Média for >= 6, então está aprovado. Caso contrário, reprovado.

DECLARE
	@varNota float = 7

SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situação'			

-- Exemplo 2: A data de vencimento de um produto é no dia 10/03/2022. Faça um teste lógico para verificar se um produto passou da validade ou não.

DECLARE
	@validadeproduto date = '10/03/2027'

SELECT
	CASE
		WHEN @validadeproduto > GETDATE() THEN 'Não vencido'
		ELSE 'Vencido'
	END AS 'Condição'


--CASE WHEN WHEN: Permite mais testes lógicos. Faz os testes lógicos de cima para baixo.

/*
SELECT
	CASE
		WHEN teste_logico1 THEN 'resultado1'
		WHEN teste_logico2 THEN 'resultado2'
		ELSE 'resultado3'
	END

Exemplo 1:

Crie um código para verificar a nota do aluno e determinar a situação:
- Aprovado: nota maior ou igual a 6
- Prova final: noa entre 4 e 6
- Reprovado: nota abaixo de 4 */

DECLARE @varNota1 FLOAT = 6
SELECT
	CASE
		WHEN @varNota1 >= 6 THEN 'Aprovado'
		WHEN @varNota1 >= 4 THEN 'Recuperação'
		ELSE 'Reprovado'
	END AS 'Situação'

-- Exemplo 2: Classifique o produto de acordo com o seu preço:
-- Preço >= 40000: Luxo
-- Preço >= 10000 e Preço < 40000: Econômico
-- Preço < 10000: Básico

DECLARE
	@preco float = 1000
SELECT
	CASE	
		WHEN @preco >= 4000 THEN 'Luxo' 
		WHEN @preco >= 1000 THEN 'Econômico'
		ELSE 'Básico'
	END AS 'Classificação'

--Exemplo Contoso
--a.Faça um select das colunas CustomerKey, FirstName e Gender da tabela DimCustomer e utilize o CASE para criar uma quarta coluna com a informação 'Maculino' ou 'Feminino'

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

--b Verifique se será necessário fazer alguma correção

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

--Faça uma consulta à tabela DimProduct, e retorne o as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna do preço com desconto
--a.)Caso o produto seja da Contoso e da cor Red, o desconto do produto será de 10%. Caso contrário. não terá desconto.

SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Preço',
	CASE
		WHEN BrandName = 'Contoso' AND
		ColorName = 'Red' THEN (CAST(UnitPrice - UnitPrice * 0.1 AS float))
		ELSE UnitPrice
	END AS 'Preço com desconto'
FROM
	DimProduct

--b. Caso o produto seja da marca Litware ou Fabrikan, ele recebe um desconto de 5%, caso contrário, não recebe desconto.

SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Preço',
	CASE
		WHEN BrandName = 'Litware' OR
		BrandName = 'Fabrikan' THEN (CAST(UnitPrice - UnitPrice * 0.05 AS float))
		ELSE 0
	END AS 'Preço com desconto'
FROM
	DimProduct

--CASE Aninhado: Uma condição dentro de outra condição

--Situação: Cálculo do bônus

--Sales Group Manager: Se fot assalariado, 30%, se não, 20%
--Sales Region Manager: 15%
--Sales State Manager: 7%
--Sales Store Manager: 2%

--Assalariado (SelariedFlag)
-- 0 = não asslariado
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
	END AS 'Bônus'
FROM
	DimEmployee

--CASE Aditivo: adição de condições

-- Os produtos da categoria 'TV and Video' terão um desconto de 10%
-- Se além de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receberá mais 5%. Total, 15%

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


