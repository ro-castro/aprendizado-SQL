--DAY, MONTH, YEAR: Descobre o dia, m�s e ano de determinada data

	--Utilize as fun��es DAY, MONTH e YEAR para descobrir, dia m�s e ano da data: 12/02/2025

DECLARE
	@vardata datetime = '12/02/2025'
SELECT
	DAY(@vardata) AS 'Dia',
	MONTH(@vardata) AS 'M�s',
	YEAR(@vardata) AS 'Ano'

--DATEFROMPARTS: Cria uma data com base em informa��es separadas de dia, m�s e ano.

	--Utilize a fun��o DATEFROMPARTS para criar a data: 12/02/2025

DECLARE
	@dia int = 12,
	@mes int = 02,
	@ano int = 2025

SELECT
	FORMAT(DATEFROMPARTS(@ano, @mes, @dia), 'dd/MM/yyyy')