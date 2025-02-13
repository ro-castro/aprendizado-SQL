--FORMAT: Função para formatação de valores no SQL

-- a) Numéricos:
--SELECT FROMAT(Valor, Formato)

SELECT 
	FORMAT(1000, 'N') --Number (separador de milhar e decimal)
SELECT 
	FORMAT(1000, 'G') --General (apenas o número)
SELECT
	FORMAT(1000, 'C') --Moeda (adiciona prefixo e separadores)

-- b) Personalizados:

SELECT 
	FORMAT(123456789, '###-##-####')

-- c) Data:

SELECT 
	FORMAT(CAST('08/02/2025' AS DATETIME), 'dd/MMMM/yyyy', 'pt-BR') --M tem que ser maiúsculo, MMM abrevia o mês por extenso, MMMM retorna o mês completo (fev/fevereiro)

SELECT 
	FORMAT(CAST('08/02/2025' AS DATETIME), 'dddd', 'en-US') --ddd retorna o dia da semana abreviado e dddd o dia inteiro (sáb/sábado)

-- Exemplo 1: Crie uma consulta juntando o texto 'A data de validade do produto é: ' com a data 17/abr/2025
-- Obs.: Você deverá o CAST para garantir que a data é entendida com o tipo DATETIME

SELECT
	'A data de validade do produto é: ' +
	FORMAT(CAST('17/04/2025' AS datetime), 'dd/MMM/yyyy')