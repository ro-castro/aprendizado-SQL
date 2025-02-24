--Soma Móvel e Média Móvel
	--Tabela para explicação

CREATE TABLE
	Resultado(
		Data_Fechamento DATETIME,
		MES_ANO VARCHAR(100),
		Faturamento_MM FLOAT)

INSERT INTO 
	Resultado(
		Data_Fechamento, 
		MES_ANO, 
		Faturamento_MM)
VALUES
	('01/01/2020','JAN-20', 8),
	('01/02/2020','FEV-20', 10),
	('01/03/2020','MAR-20', 6),
	('01/04/2020','ABR-20', 9),
	('01/05/2020','MAI-20', 5),
	('01/06/2020','JUN-20', 4),
	('01/07/2020','JUL-20', 7),
	('01/08/2020','AGO-20', 11),
	('01/09/2020','SET-20', 9),
	('01/10/2020','OUT-20', 12),
	('01/11/2020','NOV-20', 11),
	('01/12/2020','DEZ-20', 10)

SELECT
	*
FROM
	Resultado

	--Soma Móvel: Soma a linha atual com determinado número de linhas anteriores

SELECT
	Data_Fechamento, 
	MES_ANO, 
	Faturamento_MM,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Soma Móvel 2 linhas'
FROM
	Resultado

/*'ORDER BY' indica a ordem das linhas, 
'BETWEEN 1 PRECEDING AND CURRENT ROW' indica que a soma é da coluna anterior '1 PRECIDING' e a atual 'CURRENT ROW'*/

	--Média Móvel: Mesma lógica da soma móvel

SELECT
	Data_Fechamento, 
	MES_ANO, 
	Faturamento_MM,
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Média Móvel 2 linhas'
FROM
	Resultado

	--Max/Min também pode ser utilizado para saber o menor/maior valor dentro do intervalo determinado

SELECT
	Data_Fechamento, 
	MES_ANO, 
	Faturamento_MM,
	MAX(Faturamento_MM) OVER(ORDER BY Data_Fechamento ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Média Móvel 2 linhas'
FROM
	Resultado