--LOOPS
--WHILE: Executa repetidas vezes um ou vários comandos

/*Estrutura:

WHILE
	Condicao
BEGIN
	Comandos
END

Crie um contador que faça uma contagem de 1 até 10 utilizando o WHILE: */

DECLARE
	@contador int = 1
WHILE
	@contador <= 10
		BEGIN
			PRINT
				CONCAT('O valor do contador é: ', @contador)
			SET
				@contador = @contador +1
END

--BREAK: Interrompe um loop antes do final

--Crie um contador que faça uma contagem de 1 até 100 utilizando, porém o loop deve ser encerrado se o valor do contador for 22

DECLARE
	@contador2 int = 1
WHILE
	@contador2 <= 100
		BEGIN
			PRINT
				CONCAT('O valor do contador é: ', @contador2)
			IF 
				@contador2 = 15
			BREAK
				SET
					@contador2 = @contador2 +1
END

--CONTINUE: Quebra o loop sem interromper

--Faça um contador de 1 a 10, os números 3 e 6 não podem ser printados.

DECLARE
	@contador3 int = 0
WHILE
	@contador3 < 10
		BEGIN
			SET
				@contador3 += 1 -- '+=' equivalente à '@contador3 = @contador3 + 1'
			IF
				@contador3 IN (3, 6)
			CONTINUE --Ao invés de ir pro PRINT, ele retorna pro começo do loop
			PRINT
				CONCAT('O valor do contador é: ', @contador3)
END
		
