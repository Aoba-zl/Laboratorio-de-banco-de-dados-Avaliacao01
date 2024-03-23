USE master

DROP DATABASE matricula

CREATE DATABASE matricula
GO
USE matricula
GO
CREATE TABLE aluno
(
	ra								CHAR(9) 			NOT NULL,
	cpf								CHAR(11) 			NOT NULL UNIQUE,
	nome							VARCHAR(100) 		NOT NULL,
	nome_social						VARCHAR(100)		NULL,
	dt_nascimento					DATE				NOT NULL,
	email_pessoal					VARCHAR(100) 		NOT NULL UNIQUE,
	email_corporativo				VARCHAR(100)		NULL,
	dt_conclusao_seg_grau			DATE				NOT NULL,
	instituicao_conclusao_seg_grau	VARCHAR(100)		NOT NULL
	PRIMARY KEY (ra)
)
GO
CREATE UNIQUE NONCLUSTERED INDEX idx_email_corporativo_notnull
ON aluno(email_corporativo)
WHERE email_corporativo IS NOT NULL
GO
CREATE TABLE telefone
(
	ra_aluno						CHAR(9) 			NOT NULL,
	numero							CHAR(9)				NOT NULL,
	id								INT					NOT NULL
	PRIMARY KEY (ra_aluno, numero)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra)
)
GO
CREATE TABLE vestibular
(
	ra_aluno						CHAR(9)				NOT NULL,
	pontuacao						DECIMAL(7, 2)		NOT NULL,
	posicao							INT					NOT NULL
	PRIMARY KEY (ra_aluno)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra)
)
GO
CREATE TABLE curso
(
	codigo							INT					NOT NULL,
	nome							VARCHAR(50)			NOT NULL,
	carga_horaria					INT					NOT NULL,
	sigla							VARCHAR(30)			NOT NULL,
	ult_nota_participacao_enade		DECIMAL(7, 1)		NOT NULL
	PRIMARY KEY (codigo)
)
GO
CREATE TABLE matricula
(
	id								INT	IDENTITY(1, 1)	NOT NULL,
	ra_aluno						CHAR(9)				NOT NULL,
	codigo_curso					INT					NOT NULL,
	semestre						INT					NOT NULL,
	semestre_ingresso				INT					NOT NULL,
	ano_limite_graduacao			INT					NOT NULL,
	ano_ingresso					INT					NOT NULL
	PRIMARY KEY (id)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra),
	FOREIGN KEY (codigo_curso) REFERENCES curso (codigo)
)
GO
CREATE TABLE disciplina
(
	codigo							INT					NOT NULL,
	codigo_curso					INT					NOT NULL,
	nome							VARCHAR(50)			NOT NULL,
	qntd_hora_semanais				INT					NOT NULL
	PRIMARY KEY (codigo)
	FOREIGN KEY (codigo_curso) REFERENCES curso (codigo)
)
GO
CREATE TABLE conteudo
(
	id								INT					NOT NULL,
	codigo_disciplina				INT					NOT NULL,
	nome							VARCHAR(50)			NOT NULL,
	descricao						VARCHAR(100)		NOT NULL
	PRIMARY KEY (id)
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo)
)


--INSERT INTO aluno (ra, cpf, nome, nome_social, dt_nascimento, email_pessoal, email_corporativo, dt_conclusao_seg_grau, instituicao_conclusao_seg_grau)
--VALUES 
--('123456798', '12345678911', 'matheus', 'piranha', '2000-03-01', 'matheussss6613@gmail.com', NULL, '2019-10-01', 'Capitão Sérgio Pimenta'),
--('123456789', '12345678901', 'João Silva', NULL, '2000-05-15', 'joao.silva@example.com', NULL, '2022-06-30', 'Escola XYZ'),
--('234567890', '23456789012', 'Maria Souza', NULL, '2001-03-20', 'maria.souza@example.com', NULL, '2023-07-15', 'Colégio ABC'),
--('345678901', '34567890123', 'Pedro Santos', NULL, '1999-11-10', 'pedro.santos@example.com', NULL, '2021-12-20', 'Instituto DEF'),
--('456789012', '45678901234', 'Ana Oliveira', NULL, '2002-08-25', 'ana.oliveira@example.com', NULL, '2024-05-05', 'Escola GHI'),
--('567890123', '56789012345', 'Lucas Pereira', NULL, '2000-12-12', 'lucas.pereira@example.com', NULL, '2023-08-10', 'Colégio JKL'),
--('678901234', '67890123456', 'Carla Ferreira', NULL, '2001-09-18', 'carla.ferreira@example.com', NULL, '2023-11-28', 'Colégio MNO'),
--('789012345', '78901234567', 'Gustavo Almeida', NULL, '2003-02-08', 'gustavo.almeida@example.com', NULL, '2025-03-10', 'Escola PQR'),
--('890123456', '89012345678', 'Juliana Costa', NULL, '2000-07-30', 'juliana.costa@example.com', NULL, '2022-09-15', 'Instituto STU'),
--('901234567', '90123456789', 'Rafaela Lima', NULL, '2002-04-12', 'rafaela.lima@example.com', NULL, '2024-12-05', 'Colégio VWX'),
--('012345678', '01234567890', 'Bruno Oliveira', NULL, '1999-11-05', 'bruno.oliveira@example.com', NULL, '2021-07-20', 'Escola YZA')
--
--INSERT INTO telefone (ra_aluno, numero) 
--VALUES
--('123456798', '941318918'),
--('123456789', '999888777'),
--('234567890', '888777666'),
--('345678901', '777666555'),
--('456789012', '666555444'),
--('567890123', '555444333'),
--('678901234', '444333222'),
--('789012345', '333222111'),
--('890123456', '222111000'),
--('901234567', '111000999'),
--('012345678', '000999888')
--
--INSERT INTO vestibular (ra_aluno, pontuacao, posicao) 
--VALUES
--('123456798', 700.50, 11),
--('123456789', 850.75, 6),
--('234567890', 920.50, 1),
--('345678901', 800.25, 10),
--('456789012', 890.00, 4),
--('567890123', 870.25, 5),
--('678901234', 920.25, 2),
--('789012345', 890.75, 3),
--('890123456', 850.50, 8),
--('901234567', 870.00, 7),
--('012345678', 830.25, 9)
--

-- Inserções na tabela curso
INSERT INTO curso (codigo, nome, carga_horaria, sigla, ult_nota_participacao_enade)
VALUES 
(1, 'Engenharia Civil', 240, 'ENG-CIV', 7.8),
(2, 'Administração', 240, 'ADM', 8.5),
(3, 'Ciência da Computação', 240, 'CICOMP', 9.2),
(4, 'Medicina', 240, 'MED', 9.9),
(5, 'Direito', 240, 'DIR', 8.3),
(6, 'Psicologia', 240, 'PSI', 8.7),
(7, 'Arquitetura e Urbanismo', 240, 'ARQ', 7.5),
(8, 'Economia', 240, 'ECO', 8.9),
(9, 'Engenharia Elétrica', 240, 'ENG-EL', 8.0),
(10, 'Letras', 240, 'LET', 7.2)

--SELECT * FROM curso

--SELECT 
--a.ra, 
--a.cpf, 
--a.nome, 
--a.nome_social, 
--a.dt_nascimento, 
--a.email_pessoal, 
--a.email_corporativo, 
--a.dt_conclusao_seg_grau, 
--a.instituicao_conclusao_seg_grau,
--t.numero,
--v.pontuacao,
--v.posicao 
--FROM aluno a, telefone t, vestibular v
--WHERE a.ra = t.ra_aluno AND a.ra = v.ra_aluno 
--
--SELECT * FROM aluno

