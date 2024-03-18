USE master

DROP DATABASE matricula

CREATE DATABASE matricula
GO
USE matricula
GO
CREATE TABLE aluno
(
	ra								CHAR(9) 		NOT NULL,
	cpf								CHAR(11) 		NOT NULL,
	nome							VARCHAR(100) 	NOT NULL,
	nome_social						VARCHAR(100)	NOT NULL,
	dt_nascimento					DATE			NOT NULL,
	email_pessoal					VARCHAR(100)	NOT NULL,
	email_corporativo				VARCHAR(100)	NOT NULL,
	dt_conclusao_seg_grau			DATE			NOT NULL,
	instituicao_conclusao_seg_grau	VARCHAR(100)	NOT NULL
	PRIMARY KEY (ra)
)
GO
CREATE TABLE telefone
(
	ra_aluno						CHAR(9) 		NOT NULL,
	numero							CHAR(9)			NOT NULL
	PRIMARY KEY (ra_aluno)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra)
)
GO
CREATE TABLE vestibular
(
	ra_aluno						CHAR(9)			NOT NULL,
	pontuacao						DECIMAL(7, 2)	NOT NULL,
	posicao							INT				NOT NULL
	PRIMARY KEY (ra_aluno)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra)
)
GO

CREATE TABLE curso
(
	codigo							INT				NOT NULL,
	nome							VARCHAR(50)		NOT NULL,
	carga_horaria					TIME			NOT NULL,
	sigla							VARCHAR(30)		NOT NULL,
	ult_nota_participacao_enade		DECIMAL(7, 1)	NOT NULL
	PRIMARY KEY (codigo)
)
GO
CREATE TABLE matricula
(
	id								INT				NOT NULL,
	ra_aluno						CHAR(9)			NOT NULL,
	codigo_curso					INT				NOT NULL,
	semestre						BIT				NOT NULL,
	semestre_ingresso				BIT				NOT NULL,
	ano_limite_graduacao			DATE			NOT NULL,
	ano_ingresso					DATE			NOT NULL
	PRIMARY KEY (id)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra),
	FOREIGN KEY (codigo_curso) REFERENCES curso (codigo)
)
GO
CREATE TABLE disciplina
(
	codigo							INT				NOT NULL,
	codigo_curso					INT				NOT NULL,
	nome							VARCHAR(50)		NOT NULL,
	qntd_hora_semanais				INT				NOT NULL
	PRIMARY KEY (codigo)
	FOREIGN KEY (codigo_curso) REFERENCES curso (codigo)
)
GO
CREATE TABLE conteudo
(
	id								INT				NOT NULL,
	codigo_disciplina				INT				NOT NULL,
	nome							VARCHAR(50)		NOT NULL,
	descricao						VARCHAR(100)	NOT NULL
	PRIMARY KEY (id)
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo)
)










