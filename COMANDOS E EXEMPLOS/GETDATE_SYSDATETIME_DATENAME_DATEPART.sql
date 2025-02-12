--GETDATE: Retorna a data/hora atual do sistema

SELECT
	GETDATE()

--SYSDATETIME: Retorna a data/hora atual do sistema (mais preciso do que GETDATE)

SELECT
	SYSDATETIME()

--DATENAME e DATEPART: Retorna informações (dia, mês, ano, semana, etc) de uma data

DECLARE
	@vardata datetime = GETDATE() 

SELECT --Retorna em texto
	DATENAME(DAY, @vardata) AS 'Dia de hoje',
	DATENAME(MONTH, @vardata) AS 'Mês',
	DATENAME(YEAR, @vardata) AS 'Ano'

SELECT --Retorna em número
	DATEPART(DAY, @vardata) AS 'Dia de hoje',
	DATEPART(MONTH, @vardata) AS 'Mês',
	DATEPART(YEAR, @vardata) AS 'Ano'