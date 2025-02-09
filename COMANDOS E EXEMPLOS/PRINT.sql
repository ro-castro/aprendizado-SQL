--PRINT 
	--mostra resultado de uma consulta, na aba de mensagens

--Exemplo: Printe na tela a quantidade de lojas On e lojas Off da tabela DimStore. Utilize variáveis para isso

DECLARE
	@varLojasOn int,
	@varLojasOff int
SET
	@varLojasOn = 
		(SELECT
			COUNT(StoreKey)
		FROM
			DimStore
		WHERE
			Status = 'On')
SET
	@varLojasOff = 
		(SELECT
			COUNT(StoreKey)
		FROM
			DimStore
		WHERE
			Status = 'Off')
PRINT
	CAST(@varLojasOn AS varchar(20)) + ' Lojas abertas'
PRINT
	CAST(@varLojasOff AS varchar(20)) + ' Lojas fechadas'


