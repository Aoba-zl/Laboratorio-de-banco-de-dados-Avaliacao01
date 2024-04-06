USE matricula

DROP PROCEDURE sp_matricula_disciplina

CREATE PROCEDURE sp_matricula_disciplina (@matricula CHAR(11), @codigo INT, @status VARCHAR(50), @saida VARCHAR(50) OUTPUT)
AS
	DECLARE @matricula_existe CHAR(11)
	SET @matricula_existe = (SELECT id FROM matricula WHERE id = @matricula)
	IF (@matricula_existe IS NOT NULL)
	BEGIN 
		UPDATE matricula_disciplina 
		SET status = @status
		WHERE id_matricula = @matricula AND codigo_disciplina = @codigo
		SET @saida = 'Matricula em andamento!'
	END
	ELSE
	BEGIN
		SET @saida = 'Matricula não existe!'
	END
	


