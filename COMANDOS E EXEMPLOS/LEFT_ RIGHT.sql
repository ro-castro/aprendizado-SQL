--LEFT: Extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
--RIGHT Extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda

	--Fa�a uma consulta � tabela DimProduct e divida a coluna StyleName em 2 partes

SELECT
	LEFT(StyleName,7) AS 'C�digo 1',
	RIGHT(StyleName,7) AS 'C�digo 2'
FROM 
	DimProduct

