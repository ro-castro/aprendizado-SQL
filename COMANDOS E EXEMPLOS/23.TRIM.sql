--TRIM: Retira espa�os adicionais � esquerda e � direita do texto
--LTRIM: Retira espa�os adicionais � esquerda do texto
--RTRIM: Retira espa�os adicionais � direita do texto

DECLARE
	@varCodigo varchar(50) = '    ABC    '

SELECT
	TRIM(@varCodigo) AS 'TRIM'

SELECT
	LTRIM(@varCodigo) AS 'LTRIM'

SELECT
	RTRIM(@varCodigo) AS 'RTRIM'