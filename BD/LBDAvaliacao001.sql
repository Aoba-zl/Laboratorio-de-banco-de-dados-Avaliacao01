CREATE DATABASE matricula
GO
USE matricula
GO
CREATE TABLE aluno
(
	ra								CHAR(9) 				NOT NULL,
	cpf								CHAR(11) 				NOT NULL UNIQUE,
	nome							VARCHAR(100) 			NOT NULL,
	nome_social						VARCHAR(100)			NULL,
	dt_nascimento					DATE					NOT NULL,
	email_pessoal					VARCHAR(100) 			NOT NULL UNIQUE,
	email_corporativo				VARCHAR(100)			NULL,
	dt_conclusao_seg_grau			DATE					NOT NULL,
	instituicao_conclusao_seg_grau	VARCHAR(100)			NOT NULL
	PRIMARY KEY (ra)
)
GO
CREATE UNIQUE NONCLUSTERED INDEX idx_email_corporativo_notnull
ON aluno(email_corporativo)
WHERE email_corporativo IS NOT NULL
GO
CREATE TABLE telefone
(
	ra_aluno						CHAR(9) 				NOT NULL,
	numero							CHAR(9)					NOT NULL
	PRIMARY KEY (ra_aluno, numero)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra)
)
GO
CREATE TABLE vestibular
(
	ra_aluno						CHAR(9)					NOT NULL,
	pontuacao						DECIMAL(7, 2)			NOT NULL,
	posicao							INT						NOT NULL
	PRIMARY KEY (ra_aluno)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra)
)
GO
CREATE TABLE curso
(
	codigo							INT	IDENTITY(1, 1)		NOT NULL,
	nome							VARCHAR(50)				NOT NULL,
	carga_horaria					INT						NOT NULL,
	sigla							VARCHAR(30)				NOT NULL,
	ult_nota_participacao_enade		DECIMAL(7, 1)			NOT NULL
	PRIMARY KEY (codigo)
)
GO
CREATE TABLE matricula
(
	id								INT	IDENTITY(1, 1)		NOT NULL,
	ra_aluno						CHAR(9)					NOT NULL,
	codigo_curso					INT						NOT NULL,
	semestre						INT						NOT NULL,
	semestre_ingresso				INT						NOT NULL,
	ano_limite_graduacao			INT						NOT NULL,
	ano_ingresso					INT						NOT NULL
	PRIMARY KEY (id)
	FOREIGN KEY (ra_aluno) REFERENCES aluno (ra),
	FOREIGN KEY (codigo_curso) REFERENCES curso (codigo)
)
GO
CREATE TABLE disciplina
(
	codigo							INT	IDENTITY(1001, 1)	NOT NULL,
	codigo_curso					INT						NOT NULL,
	nome							VARCHAR(50)				NOT NULL,
	qntd_hora_semanais				INT						NOT NULL,
	dia_aula						INT						NOT NULL,
	horario_inicio					TIME					NOT NULL,
	horario_fim						TIME					NOT NULL
	PRIMARY KEY (codigo)
	FOREIGN KEY (codigo_curso) REFERENCES curso (codigo)
)
GO
CREATE TABLE conteudo
(
	id								INT	IDENTITY(1, 1)		NOT NULL,
	codigo_disciplina				INT						NOT NULL,
	nome							VARCHAR(50)				NOT NULL,
	descricao						VARCHAR(255)			NOT NULL
	PRIMARY KEY (id)
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo)
)
GO
CREATE TABLE matricula_disciplina 
(
	id_matricula					INT						NOT NULL,
	codigo_disciplina				INT						NOT NULL,
	status							VARCHAR(20)				NOT NULL
	PRIMARY KEY (id_matricula, codigo_disciplina)
	FOREIGN KEY (id_matricula) REFERENCES matricula (id),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo)
)

SELECT d.codigo, d.nome AS nome_disciplina, d.qntd_hora_semanais, d.dia_aula, d.horario_inicio, d.horario_fim, md.status
FROM disciplina d, matricula_disciplina md, matricula m, aluno a 
WHERE d.codigo = md.codigo_disciplina 
	AND m.id = md.id_matricula
  AND m.ra_aluno = a.ra 
  AND a.ra = '202416649'


INSERT INTO curso (nome, carga_horaria, sigla, ult_nota_participacao_enade)
VALUES 
('Engenharia Civil', 240, 'ENG-CIV', 7.8),
('Psicologia', 240, 'PSI', 8.7),
('Arquitetura e Urbanismo', 240, 'ARQ', 7.5),
('Letras', 240, 'LET', 7.2)



INSERT INTO disciplina (codigo_curso, nome, qntd_hora_semanais, dia_aula, horario_inicio, horario_fim) 
VALUES 
(1, 'Mecânica dos Sólidos', 4, 1, '13:00:00', '16:30:00'),
(1, 'Desenho Técnico', 2, 1, '13:00:00', '14:40:00'),
(1, 'Cálculo I', 4, 2, '14:50:00', '18:20:00'),
(1, 'Física I', 4, 3, '13:00:00', '16:30:00'),
(1, 'Química Geral', 2, 4, '13:00:00', '14:40:00'),
(1, 'Introdução à Engenharia Civil', 2, 4, '14:50:00', '18:20:00'),
(1, 'Álgebra Linear', 4, 5, '14:50:00', '18:20:00'),
(2, 'Introdução à Psicologia', 4, 1, '13:00:00', '16:30:00'),
(2, 'Neuropsicologia', 4, 1, '13:00:00', '14:40:00'),
(2, 'Psicologia do Desenvolvimento', 4, 2, '14:50:00', '18:20:00'),
(2, 'Psicopatologia', 4, 3, '13:00:00', '16:30:00'),
(2, 'Psicologia Organizacional', 4, 3, '13:00:00', '14:40:00'),
(2, 'Teorias da Personalidade', 4, 4, '14:50:00', '18:20:00'),
(2, 'Métodos de Pesquisa em Psicologia', 4, 5, '14:50:00', '18:20:00'),
(3, 'Introdução à Arquitetura', 3, 1, '13:00:00', '16:30:00'),
(3, 'Tecnologias da Construção Sustentável', 4, 1, '13:00:00', '14:40:00'),
(3, 'Desenho Arquitetônico', 4, 2, '14:50:00', '18:20:00'),
(3, 'História da Arquitetura', 3, 3, '13:00:00', '16:30:00'),
(3, 'Paisagismo', 3, 3, '13:00:00', '14:40:00'),
(3, 'Planejamento Urbano', 4, 4, '14:50:00', '18:20:00'),
(3, 'Construção Civil', 4, 5, '14:50:00', '18:20:00'),
(4, 'Língua Portuguesa', 4, 1, '13:00:00', '16:30:00'),
(4, 'Teoria Literária', 3, 1, '13:00:00', '14:40:00'),
(4, 'Literatura Brasileira', 3, 2, '14:50:00', '18:20:00'),
(4, 'Literatura Estrangeira', 3, 3, '13:00:00', '16:30:00'),
(4, 'Linguística', 3, 3, '13:00:00', '14:40:00'),
(4, 'Gramática', 4, 4, '14:50:00', '18:20:00'),
(4, 'Fonética e Fonologia', 4, 5, '14:50:00', '18:20:00')




--INSERT INTO conteudo (codigo_disciplina, nome, descricao) 
--VALUES 
--(1001, 'Introdução à Mecânica dos Sólidos', 'Conceitos básicos e princípios fundamentais da mecânica dos sólidos.'),
--(1001, 'Força e Deformação', 'Relação entre força aplicada e deformação em materiais sólidos.'),
--(1001, 'Elasticidade', 'Propriedades elásticas dos materiais e comportamento sob tensão.'),
--(1001, 'Flexão', 'Análise de vigas e estruturas sob flexão.'),
--(1001, 'Torção', 'Estudo do comportamento de materiais sob torção.'),
--(1001, 'Cisalhamento', 'Análise de materiais submetidos a esforços de cisalhamento.'),
--(1001, 'Teoria das Estruturas', 'Aplicação dos princípios da mecânica dos sólidos em estruturas complexas.'),
--(1001, 'Análise de Tensões e Deformações', 'Métodos para análise de tensões e deformações em sólidos.'),
--(1001, 'Falha dos Materiais', 'Estudo dos modos de falha e ruptura em materiais sólidos.'),
--(1001, 'Aplicações Práticas', 'Exemplos e aplicações práticas dos conceitos de mecânica dos sólidos.'),
--(1002, 'Introdução ao Desenho Técnico', 'Conceitos básicos e fundamentais do desenho técnico.'),
--(1002, 'Geometria Descritiva', 'Estudo das projeções ortogonais e representação de objetos em duas dimensões.'),
--(1002, 'Desenho Geométrico', 'Desenvolvimento de habilidades de representação de formas geométricas.'),
--(1002, 'Escalas', 'Uso de escalas para representação de objetos em diferentes proporções.'),
--(1002, 'Cortes e Seções', 'Técnicas de representação de cortes e seções em desenhos técnicos.'),
--(1002, 'Perspectiva Isométrica', 'Construção e interpretação de desenhos em perspectiva isométrica.'),
--(1002, 'Projeções Ortogonais', 'Aplicação de projeções ortogonais em desenhos técnicos.'),
--(1002, 'Normas Técnicas', 'Conhecimento e aplicação das normas técnicas em desenho técnico.'),
--(1002, 'Desenho Assistido por Computador (CAD)', 'Utilização de softwares de CAD na elaboração de desenhos técnicos.'),
--(1002, 'Aplicações Práticas', 'Exercícios e projetos práticos para aplicação dos conceitos de desenho técnico.'),
--(1003, 'Funções', 'Estudo de conceitos básicos de funções e suas propriedades.'),
--(1003, 'Limites e Continuidade', 'Análise de limites de funções e o conceito de continuidade.'),
--(1003, 'Derivadas', 'Cálculo de derivadas e suas aplicações.'),
--(1003, 'Regras de Derivação', 'Aplicação das regras de derivação para encontrar derivadas de funções.'),
--(1003, 'Aplicações de Derivadas', 'Utilização de derivadas em problemas de otimização e taxa de variação.'),
--(1003, 'Integrais Indefinidas', 'Cálculo de integrais indefinidas e propriedades básicas.'),
--(1003, 'Integrais Definidas', 'Interpretação geométrica e cálculo de integrais definidas.'),
--(1003, 'Teorema Fundamental do Cálculo', 'Relação entre derivadas e integrais e suas aplicações.'),
--(1003, 'Técnicas de Integração', 'Diferentes métodos para calcular integrais mais complexas.'),
--(1003, 'Aplicações Práticas', 'Exercícios e problemas práticos envolvendo cálculo diferencial e integral.'),
--(1004, 'Cinemática', 'Estudo do movimento dos corpos e suas características sem considerar as causas do movimento.'),
--(1004, 'Dinâmica', 'Leis do movimento e análise das forças que o causam.'),
--(1004, 'Leis de Newton', 'Princípios fundamentais da dinâmica e suas aplicações.'),
--(1004, 'Trabalho e Energia', 'Relação entre força, deslocamento e energia associada ao movimento.'),
--(1004, 'Momentum Linear e Colisões', 'Conservação do momentum linear e análise de colisões entre corpos.'),
--(1004, 'Rotação de Corpos Rígidos', 'Estudo do movimento rotacional e suas características.'),
--(1004, 'Gravitação', 'Leis de Kepler e a lei da gravitação universal.'),
--(1004, 'Oscilações e Ondas', 'Estudo dos movimentos oscilatórios e propagação de ondas.'),
--(1004, 'Termodinâmica', 'Princípios básicos da termodinâmica e suas leis.'),
--(1004, 'Aplicações Práticas', 'Exercícios e experimentos para aplicação dos conceitos de física em situações reais.'),
--(1005, 'Introdução à Química', 'Princípios básicos da química e sua importância nos sistemas naturais e industriais.'),
--(1005, 'Estrutura Atômica', 'Modelos atômicos, estrutura e propriedades dos átomos.'),
--(1005, 'Tabela Periódica', 'Organização e características dos elementos na tabela periódica.'),
--(1005, 'Ligações Químicas', 'Tipos de ligações entre átomos e moléculas.'),
--(1005, 'Estequiometria', 'Cálculos relacionados às quantidades de reagentes e produtos em uma reação química.'),
--(1005, 'Termoquímica', 'Estudo das variações de energia envolvidas em reações químicas.'),
--(1005, 'Cinética Química', 'Velocidade das reações químicas e os fatores que a influenciam.'),
--(1005, 'Equilíbrio Químico', 'Lei do equilíbrio químico e cálculos relacionados.'),
--(1005, 'Soluções', 'Propriedades das soluções e cálculos de concentração.'),
--(1005, 'Aplicações Práticas', 'Experiências e demonstrações de conceitos de química geral.'),
--(1006, 'História da Engenharia Civil', 'Evolução histórica da engenharia civil e suas principais realizações.'),
--(1006, 'Princípios da Engenharia', 'Conceitos fundamentais de engenharia e sua aplicação em projetos civis.'),
--(1006, 'Ética e Responsabilidade Profissional', 'Aspectos éticos e legais da prática da engenharia civil.'),
--(1006, 'Materiais de Construção', 'Propriedades e aplicações dos principais materiais utilizados na construção civil.'),
--(1006, 'Geotecnia', 'Estudo das propriedades mecânicas e comportamento do solo e rochas.'),
--(1006, 'Estruturas', 'Princípios básicos de análise e dimensionamento de estruturas civis.'),
--(1006, 'Hidráulica', 'Princípios básicos de escoamento de fluidos e sua aplicação em projetos hidráulicos.'),
--(1006, 'Saneamento Básico', 'Conceitos e técnicas para o tratamento de água e esgoto.'),
--(1006, 'Gestão de Projetos', 'Práticas de gestão de projetos na engenharia civil e o papel do engenheiro como gestor.'),
--(1006, 'Aplicações Práticas', 'Estudos de caso e projetos práticos para aplicação dos conceitos de engenharia civil.'),
--(1007, 'Espaços Vetoriais', 'Definição de espaços vetoriais e suas propriedades básicas.'),
--(1007, 'Transformações Lineares', 'Estudo de transformações lineares e suas propriedades.'),
--(1007, 'Matrizes', 'Operações com matrizes e suas propriedades.'),
--(1007, 'Determinantes', 'Cálculo de determinantes e suas aplicações em álgebra linear.'),
--(1007, 'Espaços Vetoriais com Produto Interno', 'Definição de produtos internos e espaços vetoriais com produto interno.'),
--(1007, 'Autovalores e Autovetores', 'Conceitos de autovalores e autovetores e sua aplicação em transformações lineares.'),
--(1007, 'Diagonalização de Matrizes', 'Processo de diagonalização de matrizes e suas implicações.'),
--(1007, 'Formas Canônicas', 'Formas canônicas de matrizes e transformações lineares.'),
--(1007, 'Aplicações de Álgebra Linear', 'Utilização de conceitos de álgebra linear em problemas práticos e áreas aplicadas.'),
--(1007, 'Aplicações Práticas', 'Exercícios e problemas práticos para aplicação dos conceitos de álgebra linear.')


