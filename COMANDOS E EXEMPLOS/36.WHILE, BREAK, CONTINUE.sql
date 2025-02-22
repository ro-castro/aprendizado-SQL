--LOOPS
--WHILE: Executa repetidas vezes um ou v�rios comandos

/*Estrutura:

WHILE
	Condicao
BEGIN
	Comandos
END

Crie um contador que fa�a uma contagem de 1 at� 10 utilizando o WHILE: */

DECLARE
	@contador int = 1
WHILE
	@contador <= 10
		BEGIN
			PRINT
				CONCAT('O valor do contador �: ', @contador)
			SET
				@contador = @contador +1
END

--BREAK: Interrompe um loop antes do final

--Crie um contador que fa�a uma contagem de 1 at� 100 utilizando, por�m o loop deve ser encerrado se o valor do contador for 22

DECLARE
	@contador2 int = 1
WHILE
	@contador2 <= 100
		BEGIN
			PRINT
				CONCAT('O valor do contador �: ', @contador2)
			IF 
				@contador2 = 15
			BREAK
				SET
					@contador2 = @contador2 +1
END

--CONTINUE: Quebra o loop sem interromper

--Fa�a um contador de 1 a 10, os n�meros 3 e 6 n�o podem ser printados.

DECLARE
	@contador3 int = 0
WHILE
	@contador3 < 10
		BEGIN
			SET
				@contador3 += 1 -- '+=' equivalente � '@contador3 = @contador3 + 1'
			IF
				@contador3 IN (3, 6)
			CONTINUE --Ao inv�s de ir pro PRINT, ele retorna pro come�o do loop
			PRINT
				CONCAT('O valor do contador �: ', @contador3)
END
		
