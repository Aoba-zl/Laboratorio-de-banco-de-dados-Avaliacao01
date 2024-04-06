USE matricula

DROP PROCEDURE sp_verifica_idade

CREATE PROCEDURE sp_verifica_idade (@dt_nascimento AS DATE, @valida BIT OUTPUT)
AS
	DECLARE @idade INT
	SET @idade = CASE 
					WHEN (MONTH(@dt_nascimento) - MONTH(GETDATE())) = 0
					THEN CASE 
							WHEN (DAY(@dt_nascimento) - DAY(GETDATE())) <= 0
							THEN DATEDIFF(YEAR, @dt_nascimento, GETDATE())
							ELSE DATEDIFF(YEAR, @dt_nascimento, GETDATE()) - 1
						 END
					ELSE DATEDIFF(YEAR, @dt_nascimento, GETDATE()) - 1
				 END
	IF (@idade >= 16)
	BEGIN 
		SET @valida = 1
	END
	ELSE
	BEGIN
		SET @valida = 0
	END

