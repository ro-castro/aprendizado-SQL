--CAST: Função para especificar o tipo de dado

--int: inteiro. float: decimal, varchar: string/texto, datetime: data e hora, date: data

SELECT SQL_VARIANT_PROPERTY(CAST(21.45 AS int), 'BaseType')

SELECT CAST(21.45 AS int)

SELECT SQL_VARIANT_PROPERTY(CAST(21.45 AS float), 'BaseType')

SELECT CAST(21.45 AS float)

SELECT SQL_VARIANT_PROPERTY(CAST('08/02/2025' AS datetime), 'BaseType')

SELECT CAST('08/02/2025' AS date)

SELECT SQL_VARIANT_PROPERTY(CAST('08/02/2025' AS date), 'BaseType')

SELECT CAST('08/02/2025' AS date)

--Exemplo 1: Crie uma consulta juntando o texto 'o preço do Pastel é: ' com o valor 30.99

SELECT
	'O preço do Pastel é: ' + CAST(30.99 AS varchar(50))

--Exemplo 2: Adicione 1 dia à data '08/02/2025'
	
SELECT
	CAST('08/02/2025' AS datetime) + 1