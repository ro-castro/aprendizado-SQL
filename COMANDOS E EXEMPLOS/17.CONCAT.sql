--CONCAT: Permite juntar dois textos ou mais texto em um

	--Fa�a uma consulta � tabela DimCustomer onde seja poss�vel visualizar o nome completo de cada cliente

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo'
FROM
	DimCustomer