--CHARINDEX: Descobre a posição de um determinado caractere dentro de um texto
--SUBSTRING: Extrai alguns caracteres de dentro de um texto

SELECT
	'Raquel Moreno' AS 'Nome'

	--Descubra a posição em que começa o sobrenome da Raquel utilizando a função CHARINDEX

SELECT
	CHARINDEX('Moreno', 'Raquel Moreno')

	--Extraia o sobrenome da Raquel utilizando a função SUBSTRING

SELECT
	SUBSTRING('Raquel Moreno', 8, 6) --(Texto, caracter de início, número de caracteres extraídos)

	--Combine as funções CHARINDEX e SUBSTRING para extrair de forma automática qualquer sobrenome

DECLARE
	@nomesobrenome varchar(50) = 'Raquel Moreno'
SELECT
	SUBSTRING
		(@nomesobrenome, CHARINDEX(' ', @nomesobrenome) + 1, LEN(@nomesobrenome))
