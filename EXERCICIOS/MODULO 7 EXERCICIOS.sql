/*1. Declare 4 variáveis inteiras. Atribua os seguintes valores a elas: 
valor1 = 10 
valor2 = 5 
valor3 = 34 
valor4 = 7 */

DECLARE
	@valor1 int = 10,
	@valor2 int = 5,
	@valor3 int = 34,
	@valor4 int = 7

--a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame essa variável de soma.

DECLARE
	@soma int = @valor1 + @valor2
SELECT
	@soma AS 'Soma'

--b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao. 

DECLARE
	@subtracao int = @valor3 - @valor4
SELECT
	@subtracao AS 'Subtração'

--c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao. 

DECLARE
	@multiplicacao int = @valor1 * @valor4
SELECT
	@multiplicacao AS 'Multiplicação'

--d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro. 

DECLARE
	@divisao FLOAT = CAST(@valor3 AS float) / CAST(@valor4 AS float)
SELECT
	@divisao AS 'Divisão'

--e) Arredonde o resultado da letra d) para 2 casas decimais.

SELECT
	ROUND(4.85714285714286, 2) AS 'Divisão 2'

/*2. Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser 
especificado. 
a) Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’. */

DECLARE
	@produto varchar (30) = 'Celular'
SELECT
	@produto AS 'Produto'

--b) Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.  

DECLARE
	@quantidade int = 12
SELECT
	@quantidade AS 'Quantidade'

--c) Declare uma variável chamada ‘preco’ e atribua o valor 9.99. 

DECLARE
	@preco float = 9.99
SELECT
	@preco AS 'Preço'

--d) Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’.  

DECLARE
	@faturamento float = 
		@quantidade * @preco
SELECT
	@faturamento AS 'Faturamento'

--e) Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT.

SELECT
	@produto AS 'Produto',
	@quantidade AS 'Quantidade',
	@Preco AS 'Preco',
	@faturamento AS 'Faturamento'

/*3. Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de usuários. Em resumo, esses dados são: - Nome do usuário - Data de nascimento - Quantidade de pets que aquele usuário possui Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este usuário. Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente. O resultado final a ser alcançado é mostrado abaixo:*/

--Meu nome é André, nasci em 10/02/1998 e tenho 2 pets.

DECLARE
	@nome varchar(30) = 'André',
	@data_nascimento datetime = '10/02/1998',
	@num_pets int = 2
SELECT
	'Meu nome é ' + @nome + 
	', nasci em ' + FORMAT(@data_nascimento, 'dd/MM/yyy') + 
	' e tenho ' + CAST(@num_pets AS varchar) + ' pets.'

/*4. Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as lojas da empresa.  
A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio é descobrir o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho. 

O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura: 

‘As lojas fechadas no ano de 2008 foram:  ’ + nome_das_lojas  
Obs: utilize o comando PRINT (e não o SELECT!) para mostrar o resultado. */

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

/*5. Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria específica: ‘Lamps’.  
Utilize o conceito de variáveis para chegar neste resultado.*/

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
	


