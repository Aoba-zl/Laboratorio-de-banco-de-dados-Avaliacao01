USE matricula

CREATE PROCEDURE sp_matricula_aluno (@ra CHAR(9), @codigo_curso INT)
AS 
	DECLARE @semestre INT,
			@semestre_ingresso INT,
			@ano_limite_graduacao INT,
			@ano_ingresso INT
	SET @semestre = 1
	SET @semestre_ingresso = CASE 
								WHEN MONTH(GETDATE()) <= 6 THEN 1
								ELSE 2
							 END
	SET @ano_limite_graduacao = YEAR(GETDATE()) + 5 
	SET @ano_ingresso = YEAR(GETDATE())
	INSERT INTO matricula (ra_aluno, codigo_curso, semestre, semestre_ingresso, ano_limite_graduacao, ano_ingresso)
	VALUES
	(@ra, @codigo_curso, @semestre, @semestre_ingresso, @ano_limite_graduacao, @ano_ingresso)
	
