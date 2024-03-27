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
	@numero_telefone CHAR(9),
	@pontuacao_vestibular DECIMAL(7, 2),
	@posicao_vestibular INT,
	@codigo_curso INT,
	@saida VARCHAR(100) OUTPUT,
	@ra_novo CHAR(9) OUTPUT
)
AS
	DECLARE @idade_valido BIT
	EXEC sp_verifica_idade @dt_nascimento, @idade_valido OUTPUT
	IF (@idade_valido = 1)
	BEGIN 
		DECLARE @cpf_valido INT
		EXEC sp_verifica_cpf @cpf, @cpf_valido OUTPUT
		IF (@cpf_valido = 0)
		BEGIN
			DECLARE @ra_existe CHAR(9),
					@cpf_existe CHAR(11)
				SET @ra_existe = (SELECT ra FROM aluno WHERE ra = @ra)
				SET @cpf_existe = (SELECT cpf FROM aluno WHERE cpf = @cpf)
			IF (UPPER(@op) = 'I')
			BEGIN
				IF (@cpf_existe IS NULL)
				BEGIN 
					EXEC sp_ra_aluno @ra_novo OUTPUT
					INSERT INTO aluno (ra, cpf, nome, nome_social, dt_nascimento, email_pessoal, email_corporativo, dt_conclusao_seg_grau, instituicao_conclusao_seg_grau)
					VALUES 
					(@ra_novo, @cpf, @nome, @nome_social, @dt_nascimento, @email_pessoal, @email_corporativo, @dt_conclusao_seg_grau, @instituicao_conclusao_seg_grau)
					INSERT INTO vestibular (ra_aluno, pontuacao, posicao) 
					VALUES
					(@ra_novo, @pontuacao_vestibular, @posicao_vestibular)
					EXEC sp_matricula_aluno @ra_novo, @codigo_curso 
					SET @saida = 'Aluno cadastrado!'
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
					END
					ELSE
					BEGIN 
						SET @saida = 'CPF já existe no sistema!'
					END
					
				END
				ELSE 
				BEGIN 
					SET @saida = 'Esse RA não existe!'
				END
			END
			ELSE IF (UPPER(@op) = 'D')
			BEGIN
				IF (@ra_existe IS NOT NULL)
				BEGIN 
					EXEC sp_telefone_aluno 'D', @ra, @numero_telefone, ''
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
		END
		ELSE IF (@cpf_valido = 1)
		BEGIN 
			SET @saida = 'CPF inválido!'
		END
		ELSE IF (@cpf_valido = 2)
		BEGIN 
			SET @saida = 'CPF não pode ter todos os numeros iguais!'
		END
	END
	ELSE
	BEGIN 
		SET @saida = 'Tem que ser maior de 15 anos!'
	END
	
	
	
DECLARE @out VARCHAR(100),
		@ra_novo CHAR(9)
EXEC sp_iud_aluno 
'I', 
'202418616', 
'23854548079',
'AAAA', 'piraAAAnh', 
'2008-03-01', 
'matheussss13@gmail.com', 
NULL, 
'2019-10-01', 
'Capitão Sérgio Pimenta', 
'941318918', 
700.50, 
11,
1,
@out OUTPUT,
@ra_novo OUTPUT
PRINT @out
PRINT @ra_novo


SELECT * FROM aluno

SELECT * FROM matricula

SELECT * FROM curso

SELECT * FROM telefone
