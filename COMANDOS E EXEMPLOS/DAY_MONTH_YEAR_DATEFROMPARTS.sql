--DAY, MONTH, YEAR: Descobre o dia, mês e ano de determinada data

	--Utilize as funções DAY, MONTH e YEAR para descobrir, dia mês e ano da data: 12/02/2025

DECLARE
	@vardata datetime = '12/02/2025'
SELECT
	DAY(@vardata) AS 'Dia',
	MONTH(@vardata) AS 'Mês',
	YEAR(@vardata) AS 'Ano'

--DATEFROMPARTS: Cria uma data com base em informações separadas de dia, mês e ano.

	--Utilize a função DATEFROMPARTS para criar a data: 12/02/2025

DECLARE
	@dia int = 12,
	@mes int = 02,
	@ano int = 2025

SELECT
	FORMAT(DATEFROMPARTS(@ano, @mes, @dia), 'dd/MM/yyyy')