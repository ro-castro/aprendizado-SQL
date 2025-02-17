--UPDATE: Atualiza informações na Tabela. Sem o filtro, afeta todas as linhas

SELECT * FROM Produtos_teste

UPDATE
	Produtos_teste
SET
	preco_produto = 7.99
WHERE
	id_produto = 1

--DELETE: Delata dados em uma tabela. Sem o filtro, afeta todas as linhas

DELETE
FROM 
	Produtos_teste
WHERE
	id_produto = 2