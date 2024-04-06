USE matricula

DROP PROCEDURE sp_iud_aluno

CREATE PROCEDURE sp_iud_aluno
(
	@op CHAR(1), 
	@ra CHAR(9), 
	@cpf CHAR(11), 
	@nome VARCHAR(100), 
	@nome_social VARCHAR(100), 
	@dt_nascimento DATE, 
	@email_pessoal VARCHAR(100), 
	@email_corporativo VARCHAR(100), 
	@dt_conclusao_seg_grau DATE, 
	@instituicao_conclusao_seg_grau VARCHAR(100),
	@pontuacao_vestibular DECIMAL(7, 2),
	@posicao_vestibular INT,
	@codigo_curso INT,
	@saida VARCHAR(100) OUTPUT,
	@ra_novo CHAR(9) OUTPUT
)
AS
	DECLARE @cpf_valido INT,
			@idade_valido BIT,
			@ra_existe	CHAR(9)
	SET @ra_existe = (SELECT ra FROM aluno WHERE ra = @ra)
	EXEC sp_verifica_cpf @cpf, @cpf_valido OUTPUT
	IF (@cpf_valido = 0)
	BEGIN
		DECLARE	@cpf_existe CHAR(11)
			SET @cpf_existe = (SELECT cpf FROM aluno WHERE cpf = @cpf)
		IF (UPPER(@op) = 'I')
		BEGIN
			IF (@cpf_existe IS NULL)
			BEGIN 
				EXEC sp_verifica_idade @dt_nascimento, @idade_valido OUTPUT
				IF (@idade_valido = 1)
				BEGIN
					EXEC sp_ra_aluno @ra_novo OUTPUT
					INSERT INTO aluno (ra, cpf, nome, nome_social, dt_nascimento, email_pessoal, email_corporativo, dt_conclusao_seg_grau, instituicao_conclusao_seg_grau)
					VALUES 
					(@ra_novo, @cpf, @nome, @nome_social, @dt_nascimento, @email_pessoal, @email_corporativo, @dt_conclusao_seg_grau, @instituicao_conclusao_seg_grau)
					INSERT INTO vestibular (ra_aluno, pontuacao, posicao) 
					VALUES
					(@ra_novo, @pontuacao_vestibular, @posicao_vestibular)
					EXEC sp_matricula_aluno @ra_novo, @codigo_curso 
					EXEC sp_id_matricula_disciplina @op, @ra_novo 
					SET @saida = 'Aluno cadastrado!'
				END
				ELSE
				BEGIN 
					SET @saida = 'Tem que ser maior de 15 anos!'
				END
			END
			ELSE IF (@cpf_existe IS NOT NULL)
			BEGIN 
				SET @saida = 'CPF já está cadastrado!'
			END
		END
		ELSE IF (UPPER(@op) = 'U')
		BEGIN
			IF (@ra_existe IS NOT NULL)
			BEGIN
				EXEC sp_verifica_idade @dt_nascimento, @idade_valido OUTPUT
				IF (@idade_valido = 1)
				BEGIN
					IF ((SELECT cpf FROM aluno WHERE ra = @ra AND cpf = @cpf) IS NOT NULL OR (SELECT cpf FROM aluno WHERE cpf = @cpf) IS NULL)
					BEGIN
						UPDATE aluno 
						SET 
						cpf = @cpf, 
						nome = @nome, 
						nome_social = @nome_social, 
						dt_nascimento = @dt_nascimento, 
						email_pessoal = @email_pessoal, 
						email_corporativo = @email_corporativo, 
						dt_conclusao_seg_grau = @dt_conclusao_seg_grau, 
						instituicao_conclusao_seg_grau = @instituicao_conclusao_seg_grau
						WHERE ra = @ra
						UPDATE vestibular 
						SET 
						pontuacao = @pontuacao_vestibular,
						posicao = @posicao_vestibular
						WHERE ra_aluno = @ra
						SET @saida = 'Aluno atualizado!'
						SET @ra_novo = @ra
					END
					ELSE
					BEGIN 
						SET @saida = 'CPF já existe no sistema!'
					END
				END
				ELSE
				BEGIN 
					SET @saida = 'Tem que ser maior de 15 anos!'
				END
			END
			ELSE 
			BEGIN 
				SET @saida = 'Esse RA não existe!'
			END
		END
	END
	ELSE IF (@cpf_valido = 1)
	BEGIN 
		SET @saida = 'CPF inválido!'
	END
	ELSE IF (@cpf_valido = 2)
	BEGIN 
		SET @saida = 'CPF não pode ter todos os numeros iguais!'
	END
	IF (UPPER(@op) = 'D')
	BEGIN
		IF (@ra_existe IS NOT NULL)
		BEGIN 
			EXEC sp_id_matricula_disciplina @op, @ra 
			DELETE FROM telefone
            WHERE ra_aluno = @ra
            DELETE FROM matricula
            WHERE ra_aluno = @ra
            DELETE FROM vestibular
            WHERE ra_aluno = @ra
            DELETE FROM aluno
            WHERE ra = @ra
            SET @saida = 'Aluno excluído!'
		END
		ELSE 
		BEGIN 
			SET @saida = 'Esse RA não existe!'
		END
	END

