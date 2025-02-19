/* SUBQUERY: uma Subconculta, ou seja, uma consulta dentro da consulta, podemos utilizar o resultado de uma query (Consulta ou SELECT)
dentro de outra. Resumindo, é um SELECT, dentro de outro SELECT

Onde utilizar?

Pode ser utilizada em 3 situações possíveis:

1. Junto com o WHERE, funcionando como um filtro variável
2. Junto com o SELECT, como uma nova coluna na tabela
3. Junto com o FROM, como uma nova tabela 

1. Subquery com WHERE
	a.Subquery como um filtro dinâmico e escalar (valor único)

SELECT
	coluna1,
	coluna2
FROM
	tabela
WHERE
	coluna1 = (SELECT)
	
	b.Subquery como um filtro dinâmico e em lista (vários valores)

SELECT
	coluna1,
	coluna2
FROM
	tabela
WHERE
	coluna1 IN (SELECT)

2. Subquery com SELECT, como uma nova coluna

SELECT
	coluna1,
	coluna2,
	SELECT
FROM
	tabela

3. Subquery com FROM, como uma nova tabela

SELECT
	coluna1,
	coluna2
FROM
	(SELECT) AS T
