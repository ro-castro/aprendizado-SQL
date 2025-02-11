--TRANSLATE: Substitui cada caractere na ordem encontrada no texto
	
	--Troque o arroba (@) por hashtag (#) e o ponto (.) por asterisco (*) nos emails dos funcionários.

SELECT
	TRANSLATE(EmailAddress, '@.', '#*') AS 'Email'
FROM
	DimEmployee

--STUFF: Substitui qualquer texto com uma quantidade de caracteres limitados, por um outro texto.
	--4 argumentos (item a ser substituido,caracter do início da contagem, número de caracteres a serem removidos, texto a ser inserido)

	--Na coluna StyleName, da tabela DimProduct, troque os dois primeiros caracteres após o Product por 'ID'

SELECT
	STUFF(StyleName, 8, 2, 'ID')
FROM
	DimProduct