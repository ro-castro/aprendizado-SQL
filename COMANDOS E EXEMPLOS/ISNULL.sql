--ISNULL: Tratando valores nulos, 2 argumentos (coluna a ser tratada, valor a ser mostrado)

SELECT
	GeographyKey AS 'ID Localidade',
	ContinentName 'Continente',
	CityName AS 'Cidade',
	ISNULL(CityName, 'Local desconhecido')
FROM
	DimGeography