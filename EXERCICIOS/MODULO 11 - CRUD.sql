--1. a) Crie um banco de dados chamado BD_Teste. 

CREATE DATABASE
	BD_Teste

--b) Exclua o banco de dados criado no item anterior. 

DROP DATABASE
	BD_Teste

--c) Crie um banco de dados chamado Exercicios.

CREATE DATABASE
	Exercicios

/*2. No banco de dados criado no exercício anterior, crie 3 tabelas, cada uma contendo as seguintes 
colunas: 

Tabela 1: dCliente - ID_Cliente - Nome_Cliente - Data_de _Nascimento 
Tabela 2: dGerente - ID_Gerente - Nome_Gerente - Data_de_Contratacao - Salario 
Tabela 3: fContratos - ID_Contrato - Data_de_Assinatura - ID_Cliente - ID_Gerente - Valor_do_Contrato 

Lembre-se dos seguintes pontos: 

Garantir que o Banco de Dados Exercicios está selecionado. 

Definir qual será o tipo de dados mais adequado para cada coluna das tabelas. Lembrando que 
os tipos de dados mais comuns são: INT, FLOAT, VARCHAR e DATETIME. 

Por fim, faça um SELECT para visualizar cada tabela.  */

USE 
	Exercicios
		CREATE TABLE
			dCliente(
				ID_Cliente int,
				Nome_Cliente varchar(100),
				Data_de_Nascimento datetime
			)
		CREATE TABLE
			dGerente(
				ID_Gerente int,
				Nome_Gerente varchar(100),
				Data_de_Contratacao datetime,
				Salario float
			)
		CREATE TABLE
			fContratos(
				ID_Contrato int,
				Data_de_Assinatura datetime,
				ID_Cliente int,
				ID_Gerente int,
				Valor_do_Contrato float
			)
SELECT
	*
FROM
	dCliente
SELECT
	*
FROM
	dGerente
SELECT
	*
FROM
	fContratos
				
--3. Em cada uma das 3 tabelas, adicione os seguintes valores: 

/* dCliente:

ID_Cliente | Nome_Cliente | Data_de_Nascimento
	1		André Martins		1989-02-12
	2		Bárbara Campos		1992-05-07
	3		Carol Freitas		1985-04-23	
	4		Diego Cardoso		1994-10-11
	5		Eduardo Pereira		1988-09-02
	6		Fabiana Silva		1989-09-02
	7		Gustavo Barbosa		1993-06-27
	8		Helen Viana			1990-02-11

	dGerente

ID_Gerente | Nome_Gerente | Data_de_Contratacao | Salario
	1		Lucas Sampaio		2015-03-21			6700
	2		Mariana Padilha		2011-01-10			9900
	3		Nathália Santos		2018-10-03			7200
	4		Otávio Costa		2017-04-18			11000

	fContratos

ID_Contrato | Data_de_Assinatura | ID_Cliente | ID_Gerente | Valor_do_Contrato
	1			2019-01-12				8			1				23000
	2			2019-02-10				3			2				15500
	3			2019-03-07				7			2				6500
	4			2019-03-15				1			3				33000
	5			2019-03-21				5			4				11100
	6			2019-03-23				4			2				5500
	7			2019-03-28				9			3				55000
	8			2019-04-04				2			1				31000
	9			2019-04-05				10			4				3400
	10			2019-04-05				6			2				9200
*/

INSERT INTO
	dCliente(
		ID_Cliente,
		Nome_Cliente,
		Data_de_Nascimento)
VALUES
	(1, 'André Martins', '19890212'),
	(2, 'Bárbara Campos', '19920507'),
	(3, 'Carol Freitas', '19850423'),
	(4, 'Diego Cardoso', '19941011'),
	(5, 'Eduardo Pereira', '19880902'),
	(6, 'Fabiana Silva', '19890902'),
	(7, 'Gustavo Barbosa', '19930627'),
	(8, 'Helen Viana', '19900211')

INSERT INTO
	dGerente(
		ID_Gerente,
		Nome_Gerente,
		Data_de_Contratacao,
		Salario)
VALUES
	(1, 'Lucas Sampaio', '20150321' ,6700),
	(2, 'Mariana Padilha', '20110110' ,9900),
	(3, 'Nathália Santos', '20181003' ,7200),
	(4, 'Otávio Costa', '20170418', 11000)

INSERT INTO
	fContratos(
		ID_Contrato,
		Data_de_Assinatura,
		ID_Cliente,
		ID_Gerente,
		Valor_do_Contrato)
VALUES
	(1, '20190112', 8, 1, 23000),
	(2, '20190210', 3, 2, 15500),
	(3, '20190307', 7, 2, 6500),
	(4, '20190315', 1, 3, 33000),
	(5, '20190321', 5, 4, 11100),
	(6, '20190323', 4, 2, 5500),
	(7, '20190328', 9, 3, 55000),
	(8, '20190404', 2, 1, 31000),
	(9, '20190405', 10, 4, 3400),
	(10, '20190405', 6, 2, 9200)
	
--4. Novos dados deverão ser adicionados nas tabelas dCliente, dGerente e fContratos. Fique livre para adicionar uma nova linha em cada tabela contendo, respectivamente,  
--(1) um novo cliente (id cliente, nome e data de nascimento) 
--(2) um novo gerente (id gerente, nome, data de contratação e salário) 
--(3) um novo contrato (id, data assinatura, id cliente, id gerente, valor do contrato)

INSERT INTO
	dCliente(
		ID_Cliente,
		Nome_Cliente,
		Data_de_Nascimento)
VALUES
	(9 , 'Rodrigo Castro', '20001025')

INSERT INTO
	dGerente(
		ID_Gerente,
		Nome_Gerente,
		Data_de_Contratacao,
		Salario)
VALUES
	(5, 'Pedro Carvalho', '20250219', 10200) 

INSERT INTO
	fContratos(
		ID_Contrato,
		Data_de_Assinatura,
		ID_Cliente,
		ID_Gerente,
		Valor_do_Contrato)
VALUES
	(11, '20250219', 9, 5, 39500)

--5. O contrato de ID igual a 4 foi registrado com alguns erros na tabela fContratos. Faça uma alteração na tabela atualizando os seguintes valores: 
--Data_de_Assinatura: 17/03/2019 
--ID_Gerente: 2 
--Valor_do_Contrato: 33500 

UPDATE
	fContratos
SET 
	Data_de_Assinatura = '20190317',
	ID_Gerente = 2,
	Valor_do_Contrato = 33500
WHERE
	ID_Contrato = 4

--6. Delete a linha da tabela fContratos que você criou na questão 4. 

DELETE
FROM
	fContratos
WHERE
	ID_Contrato = 11
	

