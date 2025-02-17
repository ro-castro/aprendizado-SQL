--Manipular Views e Tabelas

--SQL Views

--Tabela virtual criada a partir de uma consulta de uma ou mais tabelas (ou mesmo de outras viewa) no banco de dados
--Mesma estrutura de uma tabela real, aceita JOIN, WHERE e outras fun��ess
--Atualiza junto com o Banco de Dados
--View fica armazenada no sistema 

--3 A��es (Criar, alterar, excluir)

--CREATE VIEW: 
	/*Crie uma view contendo as seguintes informa��es da tabela DimCustomer:
	FirstName, EmailAddress e BirthDate. Achame de vwClientes*/

GO
CREATE VIEW 
	vwClientes AS 
		SELECT
			FirstName AS 'Nome',
			EmailAddress AS 'Email',
			BirthDate AS 'Data de Nascimento'
		FROM
			DimCustomer 
GO
SELECT
	*
FROM
	vwClientes

	/*Crie uma View contendo as seguintes informa��es da tabela DimProduct:
	ProductKey, ProductName, ProductSubcategoryKey, BrandName e UnitPrice e nomeie vwProdutos.*/
GO
CREATE VIEW
	vwProdutos AS
		SELECT
			ProductKey AS 'ID do Produto',
			ProductName AS 'Produto',
			ProductSubcategoryKey AS 'ID da Subcategoria',
			BrandName AS 'Marca',
			UnitPrice AS 'Pre�o'
		FROM
			DimProduct
GO
SELECT
	*
FROM
	vwProdutos
ORDER BY 
	[ID da Subcategoria] DESC

--ALTER VIEW:
	--Altere a View Criada 'vwClientes' para incluir apenas clientes do sexo feminino

SELECT
	*
FROM
	vwClientes
GO
ALTER VIEW
	vwClientes AS
		SELECT
			FirstName AS 'Nome',
			EmailAddress AS 'Email',
			BirthDate AS 'Data de Nascimento',
			Gender AS 'Sexo'
		FROM
			DimCustomer
		WHERE
			Gender = 'F'
GO

--DROP VIEW
	--Exclua as Views vwClientes e vwProdutos

DROP VIEW 
	vwClientes

DROP VIEW 
	vwProdutos

--Antes de manipular tabelas, ser� criado um Banco de Dados para teste:

CREATE DATABASE
	BDTeste

--Caso seja necess�rio excluir, usar o comando DROP:

DROP DATABASE
	BDTeste

--Criar Tabelas:

CREATE TABLE 
	Produtos_teste(
		id_produto int,
		nome_produto varchar (50),
		data_validade date,
		preco_produto decimal (6,2)
)

DROP TABLE
	Produtos_teste

