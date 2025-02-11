--LEFT: Extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
--RIGHT Extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda

	--Faça uma consulta à tabela DimProduct e divida a coluna StyleName em 2 partes

SELECT
	LEFT(StyleName,7) AS 'Código 1',
	RIGHT(StyleName,7) AS 'Código 2'
FROM 
	DimProduct

