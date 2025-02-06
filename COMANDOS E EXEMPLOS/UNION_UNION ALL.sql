-- UNION / Unir tabelas com colunas iguais (mesma estrutura), apaga duplicatas

SELECT
	*
FROM
	DimCustomer
WHERE Gender = 'F'

UNION

SELECT
	*
FROM
	DimCustomer
WHERE Gender = 'M'

-- UNION ALL / Não apaga duplicatas

SELECT
	FirstName,
	BirthDate
FROM
	DimCustomer
WHERE
	Gender = 'F'

	SELECT
	FirstName,
	BirthDate
FROM
	DimCustomer
WHERE
	Gender = 'M'