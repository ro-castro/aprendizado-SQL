--INSERT INTO: Insere informações em uma tabela

CREATE TABLE 
	Produtos_teste(
		id_produto int,
		nome_produto varchar (50),
		data_validade datetime,
		preco_produto decimal (6,2)
)

INSERT INTO
	Produtos_teste
		(id_produto,
		nome_produto,
		data_validade,
		preco_produto)
VALUES
	(1, 'Arroz', '2025-15-03', 22.50),
	(2, 'Feijão', '2025-16-03', 8.99)
