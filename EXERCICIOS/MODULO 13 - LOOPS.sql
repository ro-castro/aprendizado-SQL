--1. Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e termine em um valor final @ValorFinal. Voc� dever� printar na tela a seguinte frase: �O valor do contador �: � + ___

DECLARE
	@ValorInicial int = 0,
	@ValorFinal int = 100
WHILE
	@ValorInicial < @ValorFinal
		BEGIN
		SET
			@ValorInicial += 1
		PRINT
			CONCAT('O valor do contador �: ', @ValorInicial)
END

--2. Voc� dever� criar uma estrutura de repeti��o que printe na tela a quantidade de contrata��es para cada ano, desde 1996 at� 2003. A informa��o de data de contrata��o encontra-se na coluna HireDate da tabela DimEmployee. Utilize o formato: 
--X contrata��es em 1996 
--Y contrata��es em 1997 
--Z contrata��es em 1998 
--... 
--... 
--N contrata��es em 2003 
--Obs: a coluna HireDate cont�m a data completa (dd/mm/aaaa). Lembrando que voc� dever� printar a quantidade de contrata��es por ano. 

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
					PRINT CONCAT(@QtdContrat, ' contrata��o em ', @AnoInicial)
				ELSE
					PRINT CONCAT(@QtdContrat, ' contrata��es em ', @AnoInicial)
			SET
				@AnoInicial += 1
END


--3. Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que comece com a data 01/01/2021 e v� at� 31/12/2021.

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
