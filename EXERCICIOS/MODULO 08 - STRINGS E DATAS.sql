/*1. Quando estamos manipulando tabelas, é importante pensar em como os dados serão apresentados em um relatório. Imagine os nomes dos produtos da tabela DimProduct. Os textos são bem grandes e pode ser que mostrar os nomes completos dos produtos não seja a opção mais interessante, pois provavelmente não vão caber em um gráfico e a visualização ficará ruim.
a) Seu gestor te pede para listar todos os produtos para que seja criado um gráfico para ser apresentado na reunião diária de equipe. Faça uma consulta à tabela DimProduct que retorne (1) o nome do produto e (2) a quantidade de caracteres que cada produto tem, e ordene essa tabela do produto com a maior quantidade de caracteres para a menor. */

SELECT
	ProductName AS 'Nome do produto',
	LEN(ProductName) AS 'Número de caracteres'
FROM
	DimProduct
ORDER BY
	LEN(ProductName) DESC

--b) Qual é a média de caracteres dos nomes dos produtos? 

SELECT
	AVG(LEN(ProductName)) AS 'Média de caracteres'
FROM
	DimProduct

--c) Analise a estrutura dos nomes dos produtos e verifique se seria possível reduzir o tamanhodo nome dos produtos. (Dica: existem informações redundantes nos nomes dos produtos? Seria possível substituí-las?)

SELECT
	REPLACE(REPLACE(ProductName, BrandName, ''),ColorName, '') AS 'Nome otimizado',
	LEN(REPLACE(REPLACE(ProductName, BrandName, ''),ColorName, '')) AS 'Número de caracteres otimizado'
FROM	
	DimProduct

--d) Qual é a média de caracteres nesse novo cenário?

SELECT
	AVG(LEN(REPLACE(REPLACE(ProductName, BrandName, ''),ColorName, ''))) AS 'Média de caracteres otimizado'
FROM
	DimProduct

/*2.  A coluna StyleName da tabela DimProduct possui alguns códigos identificados por números distintos, que vão de 0 até 9, como no exemplo:

Product0101001

Porém, o setor de controle decidiu alterar a identificação do StyleName, e em vez de usar números, a ideia agora é passar a usar letras para substituir os números, conforme exemplo abaixo:

0 -> A, 1 -> B, 2 -> C, 3 -> D, 4 -> E, 5 -> F, 6 -> G, 7 -> H, 8 -> I, 9 - J

É de sua responsabilidade alterar os números por letras na coluna StyleName da tabela DimProduct. Utilize uma função que permita fazer essas substituições de forma prática e rápida. */

SELECT
	ProductName AS 'Produto',
	StyleName AS 'Identificação antiga',
	TRANSLATE(StyleName, '0123456789', 'ABDCEFGHIJ') AS 'Nova identificação'
FROM
	DimProduct

/*3. O setor de TI está criando um sistema para acompanhamento individual de cada funcionário da empresa Contoso. Cada funcionário receberá um login e senha. O login de cada funcionário será o ID do e-mail, por exemplo, do kevin0@contoso.com será kevin0. Já a senha será o FirtName + o dia do ano em que o funcionário nasceu, em MAIÚSCULA. Por exemplo, o funcionário com E-mail: mark0@contoso.com e data de nascimento 15/01/1990 deverá ter a seguinte senha:

Login: mark0 
Senha: MARK15

O responsável pelo TI pediu a sua ajuda para retornar uma tabela contendo as seguintes colunas da tabela DimEmployee: Nome completo (FirstName + LastName), E-mail, Login e Senha. Portanto, faça uma consulta à tabela DimEmployee e retorne esse resultado. */

SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	LEFT(EmailAddress, (CHARINDEX('@', EmailAddress) - 1)) AS 'Login',
	UPPER(CONCAT(FirstName, DATENAME(DAYOFYEAR, BirthDate))) AS 'Senha'
FROM
	DimEmployee

/*4. A tabela DimCustomer possui o primeiro registro de vendas no ano de 2001.  Como forma de reconhecer os clientes que compraram nesse ano, o setor de Marketing solicitou a você que retornasse uma tabela com todos os clientes que fizeram a sua primeira compra neste ano para que seja enviado uma encomenda com um presente para cada um. Para fazer esse filtro, você pode utilizar a coluna DateFirstPurchase, que contém a informação da data da primeira compra de cada cliente na tabela DimCustomer. Você deverá retornar as colunas de FirstName, EmailAddress, AddressLine1 e DateFirstPurchase da tabela DimCustomer, considerando apenas os clientes que fizeram a primeira compra no ano de 2001.*/

SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'Email',
	AddressLine1 AS 'Endereço',
	FORMAT(DateFirstPurchase, 'dd/MM/yyyy') AS 'Data da primeira compra'
FROM
	DimCustomer
WHERE
	YEAR(DateFirstPurchase) = 2001

/*5. A tabela DimEmployee possui uma informação de data de contratação (HireDate). A área de RH, no entanto, precisa das informações dessas datas de forma separada em dia, mês e ano, pois será feita uma automatização para criação de um relatório de RH, e facilitaria muito se essas informações estivessem separadas em uma tabela. Você deverá realizar uma consulta à tabela DimEmployee e retornar uma tabela contendo as seguintes informações: FirstName, EmailAddress, HireDate, além das colunas de Dia, Mês e Ano de contratação.

Obs1: A coluna de Mês deve conter o nome do mês por extenso, e não o número do mês. 
Obs2: Lembre-se de nomear cada uma dessas colunas em sua consulta para garantir que o 
entendimento de cada informação ficará 100% claro.  */

SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'Email',
	HireDate AS 'Data da contratação',
	DATENAME(DAY, HireDate) AS 'Dia da contratação',
	DATENAME(MONTH, HireDate) AS 'Mês da contratação',
	DATENAME(YEAR, HireDate) AS 'Ano da contratação'
FROM
	DimEmployee

/*6. Descubra qual é a loja que possui o maior tempo de atividade (em dias). Você deverá fazer essa 
consulta na tabela DimStore, e considerar a coluna OpenDate como referência para esse cálculo. */

SELECT
	StoreName AS 'Loja',
	FORMAT(OpenDate, 'dd/MM/yyyy') AS 'Inauguração',
	DATEDIFF(DAY, OpenDate, GETDATE()) AS 'Dias em atividade'
FROM
	DimStore
WHERE
	Status = 'On'
ORDER BY
	DATEDIFF(DAY, OpenDate, GETDATE()) DESC
