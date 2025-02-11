--REPLACE: Substitui um determinado texto por outro texto

	--Crie uma consulta a partir de DimCustomer onde você retorna o nome completo dos clientes, a coluna de sexo (abreviado) e uma outra coluna de sexo, substituindo M por masculino e F por feminino.
		--Tomar cuidado para a substiruição interna não interferir na externa
SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Nome completo',
	Gender AS 'Sexo abreviado',
	REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Sexo'
FROM
	DimCustomer