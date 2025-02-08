--FORMAT: Fun��o para formata��o de valores no SQL

-- a) Num�ricos:
--SELECT FROMAT(Valor, Formato)

SELECT 
	FORMAT(1000, 'N') --Number (separador de milhar e decimal)
SELECT 
	FORMAT(1000, 'G') --General (apenas o n�mero)

-- b) Personalizados:

SELECT 
	FORMAT(123456789, '###-##-####')

-- c) Data:

SELECT 
	FORMAT(CAST('08/02/2025' AS DATETIME), 'dd/MMMM/yyyy') --M tem que ser mai�sculo, MMM abrevia o m�s por extenso, MMMM retorna o m�s completo (fev/fevereiro)

SELECT 
	FORMAT(CAST('08/02/2025' AS DATETIME), 'dddd') --ddd retorna o dia da semana abreviado e dddd o dia inteiro (s�b/s�bado)

-- Exemplo 1: Crie uma consulta juntando o texto 'A data de validade do produto �: ' com a data 17/abr/2025
-- Obs.: Voc� dever� o CAST para garantir que a data � entendida com o tipo DATETIME

SELECT
	'A data de validade do produto �: ' +
	FORMAT(CAST('17/04/2025' AS datetime), 'dd/MMM/yyyy')