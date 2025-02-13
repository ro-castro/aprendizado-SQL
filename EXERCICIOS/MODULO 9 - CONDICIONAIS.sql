/*1. O setor de vendas decidiu aplicar um desconto aos produtos de acordo com a sua classe. O percentual aplicado deverá ser de: 
Economy -> 5% 
Regular -> 7% 
Deluxe -> 9% 

a) Faça uma consulta à tabela DimProduct que retorne as seguintes colunas: ProductKey, ProductName, e outras duas colunas que deverão retornar o % de Desconto e UnitPrice com desconto.   */

SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Produto',
	CASE 
		WHEN ClassName = 'Economy' THEN 9
		WHEN ClassName = 'Regular' THEN 7
		ELSE 5
	END AS 'Desconto (%)',
	CASE
		WHEN ClassName = 'Economy' THEN ROUND((CAST(UnitPrice * .91 AS float)), 2)
		WHEN ClassName = 'Regular' THEN ROUND((CAST(UnitPrice * .93 AS float)), 2)
		ELSE ROUND((CAST(UnitPrice * .95 AS float)), 2)
	END AS 'Preço com desconto'
FROM
	DimProduct

--b) Faça uma adaptação no código para que os % de desconto de 5%, 7% e 9% sejam facilmente modificados (dica: utilize variáveis).

DECLARE
	@descontoeconomy float = 9,
	@descontoregular float = 7,
	@descontodeluxe float = 5
SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Produto',
	CASE 
		WHEN ClassName = 'Economy' THEN @descontoeconomy
		WHEN ClassName = 'Regular' THEN @descontoregular
		ELSE @descontodeluxe
	END AS 'Desconto (%)',
	CASE
		WHEN ClassName = 'Economy' THEN ROUND((CAST(UnitPrice * (1 - (@descontoeconomy / 100)) AS float)), 2)
		WHEN ClassName = 'Regular' THEN ROUND((CAST(UnitPrice * (1 - (@descontoregular / 100)) AS float)), 2)
		ELSE ROUND((CAST(UnitPrice * (1 - (@descontodeluxe / 100)) AS float)), 2)
	END AS 'Preço com desconto'
FROM
	DimProduct

/*2. Você ficou responsável pelo controle de produtos da empresa e deverá fazer uma análise da quantidade de produtos por Marca. 
A divisão das marcas em categorias deverá ser a seguinte: 
CATEGORIA A: Mais de 500 produtos  
CATEGORIA B: Entre 100 e 500 produtos  
CATEGORIA C: Menos de 100 produtos 

Faça uma consulta à tabela DimProduct e retorne uma tabela com um agrupamento de Total de Produtos por Marca, além da coluna de Categoria, conforme a regra acima.*/

SELECT
	BrandName as 'Marca',
	COUNT(ProductKey) AS 'Quantidade de Produtos',
	CASE
		WHEN COUNT(ProductKey) >= 500 THEN 'Categoria A'
		WHEN COUNT(ProductKey) >= 100 THEN 'Categoria B'
		ELSE 'Categoria C'
	END AS 'Categoria'
FROM
	DimProduct
GROUP BY BrandName

/*3. 3. Será necessário criar uma categorização de cada loja da empresa considerando a quantidade de funcionários de cada uma. A lógica a ser seguida será a lógica abaixo: 
EmployeeCount >= 50; 'Acima de 50 funcionários' 
EmployeeCount >= 40; 'Entre 40 e 50 funcionários' 
EmployeeCount >= 30; 'Entre 30 e 40 funcionários' 
EmployeeCount >= 20; 'Entre 20 e 30 funcionários' 
EmployeeCount >= 10; 'Entre 10 e 20 funcionários' 
Caso contrário: 'Abaixo de 10 funcionários'

Faça uma consulta à tabela DimStore que retorne as seguintes informações: StoreName, 
EmployeeCount e a coluna de categoria, seguindo a regra acima.*/

SELECT
	StoreName AS 'Loja',
	EmployeeCount AS 'Número de funcionários',
	CASE
		WHEN EmployeeCount >= 50 THEN 'Acima de 50 funcionários'
		WHEN EmployeeCount >= 40 THEN 'Entre 40 e 50 funcionários'
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 40 funcionários'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 30 funcionários'
		WHEN EmployeeCount >= 10 THEN 'Entre 10 e 20 funcionários'
		ELSE 'Abaixo de 10 funcionários'
	END AS 'Categoria'
FROM
	DimStore
WHERE
	EmployeeCount IS NOT NULL

/* 4. O setor de logística deverá realizar um transporte de carga dos produtos que estão no depósito de Seattle para o depósito de Sunnyside.  
Não se tem muitas informações sobre os produtos que estão no depósito, apenas se sabe que existem 100 exemplares de cada Subcategoria. Ou seja, 100 laptops, 100 câmeras digitais, 100 ventiladores, e assim vai. 
O gerente de logística definiu que os produtos serão transportados por duas rotas distintas. Além disso, a divisão dos produtos em cada uma das rotas será feita de acordo com as subcategorias (ou seja, todos os produtos de uma mesma subcategoria serão transportados pela mesma rota): 
Rota 1: As subcategorias que tiverem uma soma total menor que 1000 kg deverão ser 
transportados pela Rota 1. 
Rota 2: As subcategorias que tiverem uma soma total maior ou igual a 1000 kg deverão ser 
transportados pela Rota 2. 

Você deverá realizar uma consulta à tabela DimProduct e fazer essa divisão das subcategorias por cada rota. Algumas dicas: 
- Dica 1: A sua consulta deverá ter um total de 3 colunas: Nome da Subcategoria, Peso Total e Rota. 
- Dica 2: Como não se sabe quais produtos existem no depósito, apenas que existem 100 exemplares de cada subcategoria, você deverá descobrir o peso médio de cada subcategoria e multiplicar essa média por 100, de forma que você descubra aproximadamente qual é o peso total dos produtos por subcategoria. 
- Dica 3: Sua resposta final deverá ter um JOIN e um GROUP BY.*/

SELECT
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	AVG(Weight) * 100 AS 'Peso Total',
	CASE
		WHEN (AVG(Weight) * 100) >= 1000 THEN 'Rota 2'
		ELSE 'Rota 1'
	END AS 'Rota'
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY
	DimProductSubcategory.ProductSubcategoryName

/*5. O setor de marketing está com algumas ideias de ações para alavancar as vendas em 2021. Uma delas consiste em realizar sorteios entre os clientes da empresa.  
Este sorteio será dividido em categorias: 
‘Sorteio Mãe do Ano’: Nessa categoria vão participar todas as mulheres com filhos. 
‘Sorteio Pai do Ano’: Nessa categoria vão participar todos os pais com filhos. 
‘Caminhão de Prêmios’: Nessa categoria vão participar todas os demais clientes (homens e 
mulheres sem filhos). 

Seu papel será realizar uma consulta à tabela DimCustomer e retornar 5 colunas: - FirstName AS ‘Nome’ - Gender AS ‘Sexo’ - TotalChildren AS ‘Qtd. Filhos’ - EmailAdress AS ‘E-mail’ - Ação de Marketing: nessa coluna você deverá dividir os clientes de acordo com as categorias ‘Sorteio Mãe do Ano’, ‘Sorteio Pai do Ano’ e ‘Caminhão de Prêmios’.*/

SELECT
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	TotalChildren AS 'Qtd. Filhos',
	EmailAddress AS 'Email',
	CASE
		WHEN Gender = 'F' AND 
			TotalChildren > 0 THEN 'Sorteio Mãe do Ano'
		WHEN Gender = 'M' AND
			TotalChildren > 0 THEN 'Sorteio Pai do Ano'
		ELSE 'Caminhão de Prêmios'
	END AS 'Ação de Marketing'
FROM
	DimCustomer
WHERE
	CustomerType = 'Person'

/*6. Descubra qual é a loja que possui o maior tempo de atividade (em dias). Você deverá fazer essa consulta na tabela DimStore, e considerar a coluna OpenDate como referência para esse cálculo. 
Atenção: lembre-se que existem lojas que foram fechadas.*/

SELECT --TOP (1)
	StoreName AS 'Loja',
	FORMAT(OpenDate, 'dd/MM/yyyy') AS 'Inauguração',
	FORMAT(CloseDate, 'dd/MM/yyyy') AS 'Fechamento',
	CASE
		WHEN Status = 'On' THEN DATEDIFF(DAY, OpenDate, GETDATE())
		ELSE DATEDIFF(DAY, OpenDate, CloseDate)
	END AS 'Dias em atividade'
FROM
	DimStore
ORDER BY
	CASE
		WHEN Status = 'On' THEN DATEDIFF(DAY, OpenDate, GETDATE())
		ELSE DATEDIFF(DAY, OpenDate, CloseDate)
	END DESC