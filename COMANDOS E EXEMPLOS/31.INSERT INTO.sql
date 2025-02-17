--Tabela usada para o exemplo
CREATE TABLE 
	Produtos_teste(
		id_produto int,
		nome_produto varchar (100	),
		data_disponibilidade datetime,
		preco_produto decimal (6,2)
)

--INSERT INTO SELECT: Insere informações de um SELECT na tabela

INSERT INTO
	Produtos_teste
		(id_produto,
		nome_produto,
		data_disponibilidade,
		preco_produto)
	SELECT
		ProductKey,
		ProductName,
		AvailableForSaleDate,
		UnitPrice
	FROM
		ContosoRetailDW.dbo.DimProduct --como Produtos_teste está em outro BD, tem que especificar qual

--INSERT INTO VALUES: Insere informações inseridas em uma tabela

INSERT INTO
	Produtos_teste
		(id_produto,
		nome_produto,
		data_disponibilidade,
		preco_produto)
VALUES
	(1, 'Arroz', '2025-15-03', 22.50),
	(2, 'Feijão', '2025-16-03', 8.99)
