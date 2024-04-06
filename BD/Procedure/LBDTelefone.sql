USE matricula

DROP PROCEDURE sp_telefone_aluno 

CREATE PROCEDURE sp_telefone_aluno (@op CHAR(1), @ra AS CHAR(9), @numero AS CHAR(9), @id AS INT, @saida AS VARCHAR(50) OUTPUT)
AS
	IF (@op = 'I')
	BEGIN
		IF ((SELECT numero FROM telefone WHERE numero = @numero) IS NULL)
		BEGIN 
			INSERT INTO telefone
			VALUES
			(@ra, @numero, @id)
		END
		ELSE
		BEGIN
			SET @saida = 'Número de telefone já cadastrado!'
		END
	END
	ELSE IF (@op = 'U')
	BEGIN
		UPDATE telefone 
		SET numero = @numero
		WHERE ra_aluno = @ra AND id = @id
	END
	ELSE IF (@op = 'D')
	BEGIN
		DELETE telefone WHERE ra_aluno = @ra
	END
