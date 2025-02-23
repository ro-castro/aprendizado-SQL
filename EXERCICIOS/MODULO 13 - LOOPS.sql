--1. Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e termine em um valor final @ValorFinal. Você deverá printar na tela a seguinte frase: “O valor do contador é: “ + ___

DECLARE
	@ValorInicial int = 0,
	@ValorFinal int = 100
WHILE
	@ValorInicial < @ValorFinal
		BEGIN
		SET
			@ValorInicial += 1
		PRINT
			CONCAT('O valor do contador é: ', @ValorInicial)
END

--2. Você deverá criar uma estrutura de repetição que printe na tela a quantidade de contratações para cada ano, desde 1996 até 2003. A informação de data de contratação encontra-se na coluna HireDate da tabela DimEmployee. Utilize o formato: 
--X contratações em 1996 
--Y contratações em 1997 
--Z contratações em 1998 
--... 
--... 
--N contratações em 2003 
--Obs: a coluna HireDate contém a data completa (dd/mm/aaaa). Lembrando que você deverá printar a quantidade de contratações por ano. 

DECLARE 
	@AnoInicial int = 1996,
	@AnoFinal int = 2003,
	@QtdContrat int

WHILE
	@AnoInicial < @AnoFinal
		BEGIN
			SELECT
				@QtdContrat = COUNT(*)
			FROM 
				DimEmployee
			WHERE
				YEAR(HireDate) = @AnoInicial
		    IF 
				@QtdContrat = 1
					PRINT CONCAT(@QtdContrat, ' contratação em ', @AnoInicial)
				ELSE
					PRINT CONCAT(@QtdContrat, ' contratações em ', @AnoInicial)
			SET
				@AnoInicial += 1
END


--3. Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que comece com a data 01/01/2021 e vá até 31/12/2021.

CREATE TABLE 
	TData(
		data date
		)
DECLARE
	@DataInicial date = '20210101',
	@DataFinal date = '20211231'

WHILE
	@DataInicial <= @DataFinal 
	BEGIN
			INSERT INTO 
				TData(data)
			SELECT
				(@DataInicial)
			SET
				@DataInicial = DATEADD(DAY, 1, @DataInicial)
END
SELECT
	*
FROM
	TData
