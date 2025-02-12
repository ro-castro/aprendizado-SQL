--TRIM: Retira espaços adicionais à esquerda e à direita do texto
--LTRIM: Retira espaços adicionais à esquerda do texto
--RTRIM: Retira espaços adicionais à direita do texto

DECLARE
	@varCodigo varchar(50) = '    ABC    '

SELECT
	TRIM(@varCodigo) AS 'TRIM'

SELECT
	LTRIM(@varCodigo) AS 'LTRIM'

SELECT
	RTRIM(@varCodigo) AS 'RTRIM'