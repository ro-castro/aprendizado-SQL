/* 
Declarando Vari�veis

1. O que � uma vari�vel?
Um objeto que armazena o valor de um dado.

2. Estrutura*/

DECLARE 
	@var int
SET 
	@var = 10
SELECT
	@var

/*3. Aplica��o

Sem vari�vel*/

SELECT
	1000
SELECT
	1000 * 1000
SELECT
	FORMAT(1000 * 1000, 'N')
	
/*Com vari�vel*/

DECLARE
	@numero float
SET
	@numero = 1000

SELECT
	@numero
SELECT
	@numero
SELECT
	FORMAT(@numero * @numero, 'N')


--Exemplo 1: Declare a vari�vel chamada 'idade' e armazene o valor 30

DECLARE
	@idade int
SET
	@idade = 30
SELECT
	@idade AS 'Idade'

--Exemplo 2 Declare uma vari�vel 'pre�o' e armazene o valor 10.98

DECLARE
	@preco1 float
SET 
	@preco1 = 10.98
SELECT
	@preco1 AS 'Pre�o'

--Exemplo 3 Declare uma vari�vel 'nome' e armazene o valor 'Mateus'

DECLARE
	@nome1 varchar(20)
SET 
	@nome1 = 'Mateus'
SELECT
	@nome1 AS 'Nome'

--Exemplo 4: Declare uma vari�vel chamada 'data' e armazene a data de hoje

DECLARE
	@data1 date
SET
	@data1 = '20250208'
SELECT
	FORMAT(@data1, 'dd/MM/yyyy')  AS 'Data'

	--Declarando mais de uma vari�vel

--Op��o 1
DECLARE	
	@var1 int,
	@texto2 varchar(30),
	@data2 datetime

SET
	@var1 = 10
SET
	@texto2 = 'Texto Qualquer'
SET
	@data2 = '08/02/2025'

SELECT
	@var1 AS 'N�mero',
	@texto2 AS 'Texto',
	@data2 AS 'Data'

--Op��o 2
DECLARE	
	@var2 int = 10,
	@texto3 varchar(30) = 'Texto',
	@data3 datetime = '08/02/2025'
SELECT
	@var2 AS 'N�mero',
	@texto3 AS 'Texto',
	@data3 AS 'Data'

--Exemplo 1: A sua loja fez uma venda de 100 camisa, cada uma custando 89,99. Fa�a um SELECT para obter o resultado do faturamento (multiplica��o da quantidade de vezes o pre�o)

DECLARE
	@vendas int,
	@preco float 
SET
	@vendas= 20
SET
	@preco = 89.99
SELECT
	@vendas * @preco AS 'Faturamento'
