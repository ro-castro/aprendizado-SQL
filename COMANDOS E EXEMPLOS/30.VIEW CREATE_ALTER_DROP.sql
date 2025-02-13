--SQL Views

--Tabela virtual criada a partir de uma consulta de uma ou mais tabelas (ou mesmo de outras viewa) no banco de dados
--Mesma estrutura de uma tabela real, aceita JOIN, WHERE e outras funçõess
--Atualiza junto com o Banco de Dados
--View fica armazenada no sistema 

--3 Ações (Criar, alterar, excluir)

--CREATE VIEW: 
	/*Crie uma view contendo as seguintes informações da tabela DimCustomer:
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

	/*Crie uma View contendo as seguintes informações da tabela DimProduct:
	ProductKey, ProductName, ProductSubcategoryKey, BrandName e UnitPrice e nomeie vwProdutos.*/
GO
CREATE VIEW
	vwProdutos AS
		SELECT
			ProductKey AS 'ID do Produto',
			ProductName AS 'Produto',
			ProductSubcategoryKey AS 'ID da Subcategoria',
			BrandName AS 'Marca',
			UnitPrice AS 'Preço'
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
