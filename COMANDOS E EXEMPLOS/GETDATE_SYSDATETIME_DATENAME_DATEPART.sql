--GETDATE: Retorna a data/hora atual do sistema

SELECT
	GETDATE()

--SYSDATETIME: Retorna a data/hora atual do sistema (mais preciso do que GETDATE)

SELECT
	SYSDATETIME()

--DATENAME e DATEPART: Retorna informa��es (dia, m�s, ano, semana, etc) de uma data

DECLARE
	@vardata datetime = GETDATE() 

SELECT --Retorna em texto
	DATENAME(DAY, @vardata) AS 'Dia de hoje',
	DATENAME(MONTH, @vardata) AS 'M�s',
	DATENAME(YEAR, @vardata) AS 'Ano'

SELECT --Retorna em n�mero
	DATEPART(DAY, @vardata) AS 'Dia de hoje',
	DATEPART(MONTH, @vardata) AS 'M�s',
	DATEPART(YEAR, @vardata) AS 'Ano'