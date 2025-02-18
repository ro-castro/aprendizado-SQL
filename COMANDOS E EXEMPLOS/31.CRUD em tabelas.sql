--Tabelas
--Antes de manipular tabelas, será criado um Banco de Dados para teste:

--CREATE:Cria uma tabela ou banco de dados

CREATE DATABASE
	BDTeste

--DROP: Caso seja necessário excluir, usar o comando 

DROP DATABASE
	BDTeste

--Criar tabela:

USE BDTeste --USE: Especifica o Banco de Dados

CREATE TABLE 
	Funcionarios(
		id_funcionario int,
		nome_funcionario varchar(100),
		salario float,
		data_nascimento date
	)


--Alterar tabelas
	--INSERT INTO VALUE: Insere valores na tabela

INSERT INTO 
	Funcionarios(
		id_funcionario, 
		nome_funcionario, 
		salario, 
		data_nascimento)
VALUES
	(1, 'Lucas'		, 1500, '20/03/1990'),
	(2, 'Andressa'	, 2300, '07/12/1988'),
	(3, 'Felipe'	, 4000, '13/02/1993'),
	(4, 'Marcelo'	, 7100, '10/04/1993'),
	(5, 'Carla'		, 3200, '02/09/1986'),
	(6, 'Juliana'	, 5500, '21/01/1989'),
	(7, 'Mateus'	, 1900, '02/11/1993'),
	(8, 'Sandra'	, 3900, '09/05/1990'),
	(9, 'André'		, 1000, '13/03/1994'),
	(10, 'Julio'	, 4700, '05/07/1992')

	--INSERT INTO SELECT: Insere um SELECT na tabela

INSERT INTO 
	Funcionarios(
		id_funcionario, 
		nome_funcionario, 
		salario, 
		data_nascimento)
SELECT
	EmployeeKey,
	FirstName,
	BaseRate,
	BirthDate
FROM
	ContosoRetailDW.dbo.DimEmployee

	--UPDATE: Atualiza informações na Tabela. Sem o filtro, afeta todas as linhas

UPDATE
	Funcionarios
SET
	salario = 1200
WHERE	
	id_funcionario = 9

	--DELETE: Delata dados em uma tabela. Sem o filtro, afeta todas as linhas

DELETE
FROM 
	Funcionarios
WHERE
	id_funcionario = 2

	--ALTER TABLE: Adicionar colunas, alterar tipo de dados de uma coluna e deletar coluna
		--ADD: Adiciona colunas

ALTER TABLE
	Funcionarios
ADD
	cargo varchar(100),
	bonus float

		--ALTER COLUMN: Altera tipo dos dados

ALTER TABLE
	Funcionarios
ALTER COLUMN
	Salario int

		--DROP COLUMN: Deleta coluna

ALTER TABLE
	Funcionarios
DROP COLUMN
	cargo, bonus


--Deletar tabelas:	
	--DELETE: Deleta a tabela especificada

DROP TABLE
	Funcionarios




