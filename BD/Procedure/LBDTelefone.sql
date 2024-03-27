USE matricula

DROP PROCEDURE sp_telefone_aluno 

CREATE PROCEDURE sp_telefone_aluno (@op CHAR(1), @ra AS CHAR(9), @numero AS CHAR(9), @id AS INT)
AS
	IF (@op = 'I')
	BEGIN
		INSERT INTO telefone
		VALUES
		(@ra, @numero, @id)
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


EXEC sp_telefone_aluno 'I', '202416717', '941318911', 2



SELECT * FROM aluno

SELECT * FROM telefone