--DATEADD: Adiciona ou subtrai uma determinada quqantidade de dias, meses ou anos a uma data

DECLARE
	@vardata1 datetime = '10/07/2020',
	@vardata2 datetime = '05/03/2020',
	@vardata3 datetime = '14/11/2021'
SELECT
	@vardata1 AS 'Dia',
	DATEADD(DAY, 30, @vardata1) AS 'Mais 30 dias',
	DATEADD(QUARTER, 2, @vardata1) AS 'Mais 2 trimestres'

--DATEDIFF: Calcula a diferença entre duas datas

SELECT
	DATEDIFF(DAY, @vardata2, @vardata3) AS 'Dias',
	DATEDIFF(WEEK, @vardata2, @vardata3) AS 'Semanas'