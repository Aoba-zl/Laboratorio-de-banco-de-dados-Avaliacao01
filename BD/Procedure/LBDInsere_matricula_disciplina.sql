USE matricula

DROP PROCEDURE sp_id_matricula_disciplina

CREATE PROCEDURE sp_id_matricula_disciplina(@op CHAR(1), @ra CHAR(9))
AS
	IF (@op = 'I')
	BEGIN
		INSERT INTO matricula_disciplina 
			SELECT m.id, d.codigo, 'Não cursando.' AS status FROM aluno a, matricula m, curso c, disciplina d 
			WHERE a.ra = m.ra_aluno
				AND m.codigo_curso = c.codigo 
				AND c.codigo = d.codigo_curso 
				AND a.ra = @ra
	END
	ELSE IF (@op = 'D')
	BEGIN 
		DELETE md
		FROM matricula_disciplina md, matricula m, aluno a
		WHERE md.id_matricula = m.id
			AND m.ra_aluno = a.ra
			AND a.ra = @ra
	END
