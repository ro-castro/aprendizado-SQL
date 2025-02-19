--ANY/SOME e ALL
--Tabela usada para explicação

CREATE TABLE funcionarios(
id_funcionario INT,
nome VARCHAR(50),
idade INT,
sexo VARCHAR(50))

SELECT * FROM funcionarios

--Selecione os funcionários do sexo masculino (utilizando a coluna de idade)
--ANY/SOME equivalente ao IN porém permite usar outros operadores (<>)

SELECT
	*
FROM
	funcionarios
WHERE
	idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

SELECT 
	*
FROM
	funcionarios
WHERE
	idade > ANY (SELECT idade FROM funcionarios WHERE sexo = 'M') 

--Subquery retorna as idades, e o "> any" considera todas linhas com idade maior do que o MENOR valor da subquery, independente se é 'M' ou não
--Para "< any", o oposto:

SELECT 
	*
FROM
	funcionarios
WHERE
	idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M') 

--ALL

SELECT 
	*
FROM
	funcionarios
WHERE
	idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M') 

--Subquery retorna as idades, e o "> all" considera todas linhas com idade maior do que o MAIOR valor da subquery, independente se é 'M' ou não
--Para "< all", o oposto

SELECT 
	*
FROM
	funcionarios
WHERE
	idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')