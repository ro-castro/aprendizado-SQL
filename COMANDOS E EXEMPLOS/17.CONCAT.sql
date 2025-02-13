--CONCAT: Permite juntar dois textos ou mais texto em um

	--Faça uma consulta à tabela DimCustomer onde seja possível visualizar o nome completo de cada cliente

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo'
FROM
	DimCustomer