--CHARINDEX: Descobre a posi��o de um determinado caractere dentro de um texto
--SUBSTRING: Extrai alguns caracteres de dentro de um texto

SELECT
	'Raquel Moreno' AS 'Nome'

	--Descubra a posi��o em que come�a o sobrenome da Raquel utilizando a fun��o CHARINDEX

SELECT
	CHARINDEX('Moreno', 'Raquel Moreno')

	--Extraia o sobrenome da Raquel utilizando a fun��o SUBSTRING

SELECT
	SUBSTRING('Raquel Moreno', 8, 6) --(Texto, caracter de in�cio, n�mero de caracteres extra�dos)

	--Combine as fun��es CHARINDEX e SUBSTRING para extrair de forma autom�tica qualquer sobrenome

DECLARE
	@nomesobrenome varchar(50) = 'Raquel Moreno'
SELECT
	SUBSTRING
		(@nomesobrenome, CHARINDEX(' ', @nomesobrenome) + 1, LEN(@nomesobrenome))
