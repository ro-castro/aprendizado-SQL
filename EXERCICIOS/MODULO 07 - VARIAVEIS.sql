/*1. Declare 4 vari�veis inteiras. Atribua os seguintes valores a elas: 
valor1 = 10 
valor2 = 5 
valor3 = 34 
valor4 = 7 */

DECLARE
	@valor1 int = 10,
	@valor2 int = 5,
	@valor3 int = 34,
	@valor4 int = 7

--a) Crie uma nova vari�vel para armazenar o resultado da soma entre valor1 e valor2. Chame essa vari�vel de soma.

DECLARE
	@soma int = @valor1 + @valor2
SELECT
	@soma AS 'Soma'

--b) Crie uma nova vari�vel para armazenar o resultado da subtra��o entre valor3 e valor 4. Chame essa vari�vel de subtracao. 

DECLARE
	@subtracao int = @valor3 - @valor4
SELECT
	@subtracao AS 'Subtra��o'

--c) Crie uma nova vari�vel para armazenar o resultado da multiplica��o entre o valor 1 e o valor4. Chame essa vari�vel de multiplicacao. 

DECLARE
	@multiplicacao int = @valor1 * @valor4
SELECT
	@multiplicacao AS 'Multiplica��o'

--d) Crie uma nova vari�vel para armazenar o resultado da divis�o do valor3 pelo valor4. Chame essa vari�vel de divisao. Obs: O resultado dever� estar em decimal, e n�o em inteiro. 

DECLARE
	@divisao FLOAT = CAST(@valor3 AS float) / CAST(@valor4 AS float)
SELECT
	@divisao AS 'Divis�o'

--e) Arredonde o resultado da letra d) para 2 casas decimais.

SELECT
	ROUND(4.85714285714286, 2) AS 'Divis�o 2'

/*2. Para cada declara��o das vari�veis abaixo, aten��o em rela��o ao tipo de dado que dever� ser 
especificado. 
a) Declare uma vari�vel chamada �produto� e atribua o valor de �Celular�. */

DECLARE
	@produto varchar (30) = 'Celular'
SELECT
	@produto AS 'Produto'

--b) Declare uma vari�vel chamada �quantidade� e atribua o valor de 12.  

DECLARE
	@quantidade int = 12
SELECT
	@quantidade AS 'Quantidade'

--c) Declare uma vari�vel chamada �preco� e atribua o valor 9.99. 

DECLARE
	@preco float = 9.99
SELECT
	@preco AS 'Pre�o'

--d) Declare uma vari�vel chamada �faturamento� e atribua o resultado da multiplica��o entre �quantidade� e �preco�.  

DECLARE
	@faturamento float = 
		@quantidade * @preco
SELECT
	@faturamento AS 'Faturamento'

--e) Visualize o resultado dessas 4 vari�veis em uma �nica consulta, por meio do SELECT.

SELECT
	@produto AS 'Produto',
	@quantidade AS 'Quantidade',
	@Preco AS 'Preco',
	@faturamento AS 'Faturamento'

/*3. Voc� � respons�vel por gerenciar um banco de dados onde s�o recebidos dados externos de usu�rios. Em resumo, esses dados s�o: - Nome do usu�rio - Data de nascimento - Quantidade de pets que aquele usu�rio possui Voc� precisar� criar um c�digo em SQL capaz de juntar as informa��es fornecidas por este usu�rio. Para simular estes dados, crie 3 vari�veis, chamadas: nome, data_nascimento e num_pets. Voc� dever� armazenar os valores �Andr�, �10/02/1998� e 2, respectivamente. O resultado final a ser alcan�ado � mostrado abaixo:*/

--Meu nome � Andr�, nasci em 10/02/1998 e tenho 2 pets.

DECLARE
	@nome varchar(30) = 'Andr�',
	@data_nascimento datetime = '10/02/1998',
	@num_pets int = 2
SELECT
	'Meu nome � ' + @nome + 
	', nasci em ' + FORMAT(@data_nascimento, 'dd/MM/yyy') + 
	' e tenho ' + CAST(@num_pets AS varchar) + ' pets.'

/*4. Voc� acabou de ser promovido e o seu papel ser� realizar um controle de qualidade sobre as lojas da empresa.  
A primeira informa��o que � passada a voc� � que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio � descobrir o nome dessas lojas que fecharam no ano de 2008, para que voc� possa entender o motivo e mapear planos de a��o para evitar que outras lojas importantes tomem o mesmo caminho. 

O seu resultado dever� estar estruturado em uma frase, com a seguinte estrutura: 

�As lojas fechadas no ano de 2008 foram:  � + nome_das_lojas  
Obs: utilize o comando PRINT (e n�o o SELECT!) para mostrar o resultado. */

DECLARE
	@nome_das_lojas varchar(50)
SET
	@nome_das_lojas  = ''

SELECT
	@nome_das_lojas  =
			@nome_das_lojas  + 
			StoreName +
			', '
	FROM
		DimStore
	WHERE
		CloseDate BETWEEN '20080101' and '20081231'
PRINT
	'As lojas fechadas no ano de 2008 foram: ' + @nome_das_lojas

/*5. Voc� precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria espec�fica: �Lamps�.  
Utilize o conceito de vari�veis para chegar neste resultado.*/

DECLARE
	@IDsubcategoria int,
	@subcategoria varchar(50)
SET
	@subcategoria = 'Lamps'
SET
	@IDsubcategoria = 
		(SELECT
			ProductSubcategoryKey
		FROM
			DimProductSubcategory
		WHERE
			ProductSubcategoryName = @subcategoria)
SELECT
	*
FROM
	DimProduct
WHERE
	ProductSubcategoryKey = @IDsubcategoria
	


