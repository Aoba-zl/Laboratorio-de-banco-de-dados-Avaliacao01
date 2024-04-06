USE master

DROP DATABASE matricula

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
('Administração', 240, 'ADM', 8.5),
('Ciência da Computação', 240, 'CICOMP', 9.2),
('Medicina', 240, 'MED', 9.9),
('Direito', 240, 'DIR', 8.3),
('Psicologia', 240, 'PSI', 8.7),
('Arquitetura e Urbanismo', 240, 'ARQ', 7.5),
('Economia', 240, 'ECO', 8.9),
('Engenharia Elétrica', 240, 'ENG-EL', 8.0),
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
(1, 'Geometria Analítica', 2, 5, '13:00:00', '14:40:00'),
(2, 'Gestão Financeira', 4, 1, '14:50:00', '18:20:00'),
(2, 'Marketing', 2, 1, '13:00:00', '14:40:00'),
(3, 'Estrutura de Dados', 4, 1, '13:00:00', '16:30:00'),
(3, 'Inteligência Artificial', 2, 1, '16:40:00', '18:20:00'),
(4, 'Anatomia', 4, 1, '13:00:00', '16:30:00'),
(4, 'Farmacologia', 2, 1, '16:40:00', '18:20:00'),
(5, 'Direito Civil', 4, 1, '14:50:00', '18:20:00'),
(5, 'Direito Penal', 2, 1, '13:00:00', '14:40:00')

INSERT INTO conteudo (codigo_disciplina, nome, descricao) 
VALUES 
(1001, 'Introdução à Mecânica dos Sólidos', 'Conceitos básicos e princípios fundamentais da mecânica dos sólidos.'),
(1001, 'Força e Deformação', 'Relação entre força aplicada e deformação em materiais sólidos.'),
(1001, 'Elasticidade', 'Propriedades elásticas dos materiais e comportamento sob tensão.'),
(1001, 'Flexão', 'Análise de vigas e estruturas sob flexão.'),
(1001, 'Torção', 'Estudo do comportamento de materiais sob torção.'),
(1001, 'Cisalhamento', 'Análise de materiais submetidos a esforços de cisalhamento.'),
(1001, 'Teoria das Estruturas', 'Aplicação dos princípios da mecânica dos sólidos em estruturas complexas.'),
(1001, 'Análise de Tensões e Deformações', 'Métodos para análise de tensões e deformações em sólidos.'),
(1001, 'Falha dos Materiais', 'Estudo dos modos de falha e ruptura em materiais sólidos.'),
(1001, 'Aplicações Práticas', 'Exemplos e aplicações práticas dos conceitos de mecânica dos sólidos.'),
(1002, 'Introdução ao Desenho Técnico', 'Conceitos básicos e fundamentais do desenho técnico.'),
(1002, 'Geometria Descritiva', 'Estudo das projeções ortogonais e representação de objetos em duas dimensões.'),
(1002, 'Desenho Geométrico', 'Desenvolvimento de habilidades de representação de formas geométricas.'),
(1002, 'Escalas', 'Uso de escalas para representação de objetos em diferentes proporções.'),
(1002, 'Cortes e Seções', 'Técnicas de representação de cortes e seções em desenhos técnicos.'),
(1002, 'Perspectiva Isométrica', 'Construção e interpretação de desenhos em perspectiva isométrica.'),
(1002, 'Projeções Ortogonais', 'Aplicação de projeções ortogonais em desenhos técnicos.'),
(1002, 'Normas Técnicas', 'Conhecimento e aplicação das normas técnicas em desenho técnico.'),
(1002, 'Desenho Assistido por Computador (CAD)', 'Utilização de softwares de CAD na elaboração de desenhos técnicos.'),
(1002, 'Aplicações Práticas', 'Exercícios e projetos práticos para aplicação dos conceitos de desenho técnico.'),
(1003, 'Funções', 'Estudo de conceitos básicos de funções e suas propriedades.'),
(1003, 'Limites e Continuidade', 'Análise de limites de funções e o conceito de continuidade.'),
(1003, 'Derivadas', 'Cálculo de derivadas e suas aplicações.'),
(1003, 'Regras de Derivação', 'Aplicação das regras de derivação para encontrar derivadas de funções.'),
(1003, 'Aplicações de Derivadas', 'Utilização de derivadas em problemas de otimização e taxa de variação.'),
(1003, 'Integrais Indefinidas', 'Cálculo de integrais indefinidas e propriedades básicas.'),
(1003, 'Integrais Definidas', 'Interpretação geométrica e cálculo de integrais definidas.'),
(1003, 'Teorema Fundamental do Cálculo', 'Relação entre derivadas e integrais e suas aplicações.'),
(1003, 'Técnicas de Integração', 'Diferentes métodos para calcular integrais mais complexas.'),
(1003, 'Aplicações Práticas', 'Exercícios e problemas práticos envolvendo cálculo diferencial e integral.'),
(1004, 'Cinemática', 'Estudo do movimento dos corpos e suas características sem considerar as causas do movimento.'),
(1004, 'Dinâmica', 'Leis do movimento e análise das forças que o causam.'),
(1004, 'Leis de Newton', 'Princípios fundamentais da dinâmica e suas aplicações.'),
(1004, 'Trabalho e Energia', 'Relação entre força, deslocamento e energia associada ao movimento.'),
(1004, 'Momentum Linear e Colisões', 'Conservação do momentum linear e análise de colisões entre corpos.'),
(1004, 'Rotação de Corpos Rígidos', 'Estudo do movimento rotacional e suas características.'),
(1004, 'Gravitação', 'Leis de Kepler e a lei da gravitação universal.'),
(1004, 'Oscilações e Ondas', 'Estudo dos movimentos oscilatórios e propagação de ondas.'),
(1004, 'Termodinâmica', 'Princípios básicos da termodinâmica e suas leis.'),
(1004, 'Aplicações Práticas', 'Exercícios e experimentos para aplicação dos conceitos de física em situações reais.'),
(1005, 'Introdução à Química', 'Princípios básicos da química e sua importância nos sistemas naturais e industriais.'),
(1005, 'Estrutura Atômica', 'Modelos atômicos, estrutura e propriedades dos átomos.'),
(1005, 'Tabela Periódica', 'Organização e características dos elementos na tabela periódica.'),
(1005, 'Ligações Químicas', 'Tipos de ligações entre átomos e moléculas.'),
(1005, 'Estequiometria', 'Cálculos relacionados às quantidades de reagentes e produtos em uma reação química.'),
(1005, 'Termoquímica', 'Estudo das variações de energia envolvidas em reações químicas.'),
(1005, 'Cinética Química', 'Velocidade das reações químicas e os fatores que a influenciam.'),
(1005, 'Equilíbrio Químico', 'Lei do equilíbrio químico e cálculos relacionados.'),
(1005, 'Soluções', 'Propriedades das soluções e cálculos de concentração.'),
(1005, 'Aplicações Práticas', 'Experiências e demonstrações de conceitos de química geral.'),
(1006, 'História da Engenharia Civil', 'Evolução histórica da engenharia civil e suas principais realizações.'),
(1006, 'Princípios da Engenharia', 'Conceitos fundamentais de engenharia e sua aplicação em projetos civis.'),
(1006, 'Ética e Responsabilidade Profissional', 'Aspectos éticos e legais da prática da engenharia civil.'),
(1006, 'Materiais de Construção', 'Propriedades e aplicações dos principais materiais utilizados na construção civil.'),
(1006, 'Geotecnia', 'Estudo das propriedades mecânicas e comportamento do solo e rochas.'),
(1006, 'Estruturas', 'Princípios básicos de análise e dimensionamento de estruturas civis.'),
(1006, 'Hidráulica', 'Princípios básicos de escoamento de fluidos e sua aplicação em projetos hidráulicos.'),
(1006, 'Saneamento Básico', 'Conceitos e técnicas para o tratamento de água e esgoto.'),
(1006, 'Gestão de Projetos', 'Práticas de gestão de projetos na engenharia civil e o papel do engenheiro como gestor.'),
(1006, 'Aplicações Práticas', 'Estudos de caso e projetos práticos para aplicação dos conceitos de engenharia civil.'),
(1007, 'Espaços Vetoriais', 'Definição de espaços vetoriais e suas propriedades básicas.'),
(1007, 'Transformações Lineares', 'Estudo de transformações lineares e suas propriedades.'),
(1007, 'Matrizes', 'Operações com matrizes e suas propriedades.'),
(1007, 'Determinantes', 'Cálculo de determinantes e suas aplicações em álgebra linear.'),
(1007, 'Espaços Vetoriais com Produto Interno', 'Definição de produtos internos e espaços vetoriais com produto interno.'),
(1007, 'Autovalores e Autovetores', 'Conceitos de autovalores e autovetores e sua aplicação em transformações lineares.'),
(1007, 'Diagonalização de Matrizes', 'Processo de diagonalização de matrizes e suas implicações.'),
(1007, 'Formas Canônicas', 'Formas canônicas de matrizes e transformações lineares.'),
(1007, 'Aplicações de Álgebra Linear', 'Utilização de conceitos de álgebra linear em problemas práticos e áreas aplicadas.'),
(1007, 'Aplicações Práticas', 'Exercícios e problemas práticos para aplicação dos conceitos de álgebra linear.'),
(1008, 'Sistemas de Coordenadas', 'Introdução aos sistemas de coordenadas cartesianas e polares.'),
(1008, 'Vetores no Plano e no Espaço', 'Definição de vetores e operações com vetores no plano e no espaço.'),
(1008, 'Equações da Reta', 'Equações da reta e suas representações geométricas.'),
(1008, 'Equações da Circunferência', 'Equações da circunferência e suas propriedades.'),
(1008, 'Conicas', 'Estudo das cônicas: parábolas, elipses e hipérboles.'),
(1008, 'Transformações Geométricas', 'Rotações, reflexões e translações de figuras geométricas.'),
(1008, 'Equações Paramétricas', 'Representação de curvas e superfícies por meio de equações paramétricas.'),
(1008, 'Coordenadas Polares', 'Representação de pontos no plano e no espaço utilizando coordenadas polares.'),
(1008, 'Geometria Analítica Tridimensional', 'Aplicações da geometria analítica no espaço tridimensional.'),
(1008, 'Aplicações Práticas', 'Exercícios e problemas práticos para aplicação dos conceitos de geometria analítica.'),
(1009, 'Introdução à Gestão Financeira', 'Conceitos básicos de gestão financeira e sua importância para as organizações.'),
(1009, 'Análise de Demonstrativos Financeiros', 'Interpretação e análise de demonstrativos financeiros para avaliação da saúde financeira de uma empresa.'),
(1009, 'Fluxo de Caixa', 'Elaboração e análise de fluxo de caixa para gerenciamento de entradas e saídas de recursos financeiros.'),
(1009, 'Gestão de Custos', 'Princípios e técnicas para gestão e controle de custos em uma organização.'),
(1009, 'Orçamento Empresarial', 'Processo de elaboração, acompanhamento e controle de orçamento empresarial.'),
(1009, 'Análise de Investimentos', 'Critérios e métodos para avaliação de viabilidade de investimentos.'),
(1009, 'Financiamento Empresarial', 'Fontes de financiamento e análise de opções para captação de recursos.'),
(1009, 'Risco e Retorno', 'Relação entre risco e retorno em investimentos e sua influência na tomada de decisão.'),
(1009, 'Gestão de Tesouraria', 'Gestão de liquidez e administração de ativos e passivos financeiros.'),
(1009, 'Aplicações Práticas', 'Exercícios e casos práticos para aplicação dos conceitos de gestão financeira.'),
(1010, 'Introdução ao Marketing', 'Conceitos básicos de marketing e sua importância para as organizações.'),
(1010, 'Comportamento do Consumidor', 'Estudo dos fatores que influenciam o comportamento de compra dos consumidores.'),
(1010, 'Segmentação de Mercado', 'Identificação e agrupamento de segmentos de mercado com características similares.'),
(1010, 'Mix de Marketing (4Ps)', 'Estratégias relacionadas aos quatro elementos do mix de marketing: produto, preço, praça e promoção.'),
(1010, 'Pesquisa de Mercado', 'Métodos e técnicas de pesquisa utilizados para coletar e analisar informações de mercado.'),
(1010, 'Estratégias de Produto e Marca', 'Desenvolvimento e posicionamento de produtos e marcas no mercado.'),
(1010, 'Estratégias de Preço', 'Determinação de preços e estratégias de precificação.'),
(1010, 'Estratégias de Distribuição', 'Seleção de canais de distribuição e estratégias de distribuição física e logística.'),
(1010, 'Estratégias de Promoção', 'Planejamento e execução de atividades promocionais e de comunicação de marketing.'),
(1010, 'Marketing Digital', 'Utilização de ferramentas e estratégias de marketing digital para alcançar os consumidores online.'),
(1011, 'Introdução às Estruturas de Dados', 'Conceitos básicos sobre estruturas de dados e sua importância na organização e manipulação de informações.'),
(1011, 'Listas Encadeadas', 'Implementação e operações em listas encadeadas simples e duplamente encadeadas.'),
(1011, 'Pilhas', 'Estrutura de dados do tipo pilha e suas operações (push, pop, etc.).'),
(1011, 'Filas', 'Estrutura de dados do tipo fila e suas operações (enqueue, dequeue, etc.).'),
(1011, 'Árvores', 'Conceito de árvores, tipos de árvores (binárias, AVL, B, etc.) e operações básicas.'),
(1011, 'Grafos', 'Representação de grafos e algoritmos para busca em grafos (DFS, BFS, etc.).'),
(1011, 'Tabelas Hash', 'Estrutura de dados de tabela hash e algoritmos de hash.'),
(1011, 'Ordenação', 'Algoritmos de ordenação (quicksort, mergesort, heapsort, etc.) e suas complexidades.'),
(1011, 'Busca', 'Algoritmos de busca (busca linear, busca binária, etc.) e suas aplicações.'),
(1011, 'Aplicações Práticas', 'Exercícios e problemas práticos para aplicação dos conceitos de estrutura de dados.'),
(1012, 'Introdução à Inteligência Artificial', 'Conceitos básicos e histórico da inteligência artificial.'),
(1012, 'Agentes Inteligentes', 'Modelagem e implementação de agentes inteligentes.'),
(1012, 'Busca em Espaço de Estados', 'Algoritmos de busca em espaço de estados (busca em largura, busca em profundidade, etc.).'),
(1012, 'Heurísticas de Busca', 'Uso de heurísticas para melhorar a eficiência da busca.'),
(1012, 'Lógica Proposicional', 'Fundamentos da lógica proposicional e sua aplicação em sistemas inteligentes.'),
(1012, 'Lógica de Predicados', 'Conceitos de lógica de predicados e sua utilização em sistemas de inteligência artificial.'),
(1012, 'Redes Neurais Artificiais', 'Modelagem e treinamento de redes neurais artificiais.'),
(1012, 'Algoritmos Genéticos', 'Princípios e aplicações de algoritmos genéticos.'),
(1012, 'Aprendizado de Máquina', 'Conceitos e técnicas de aprendizado de máquina.'),
(1012, 'Aplicações Práticas', 'Exercícios e projetos práticos para aplicação dos conceitos de inteligência artificial.'),
(1013, 'Introdução à Anatomia Humana', 'Conceitos básicos e divisões da anatomia humana.'),
(1013, 'Anatomia Sistêmica', 'Estudo dos sistemas do corpo humano: esquelético, muscular, circulatório, etc.'),
(1013, 'Anatomia Descritiva', 'Descrição e identificação de estruturas anatômicas em cadáveres ou imagens médicas.'),
(1013, 'Anatomia Funcional', 'Relação entre a estrutura e a função dos órgãos e sistemas do corpo humano.'),
(1013, 'Anatomia Microscópica', 'Estudo da anatomia em nível celular e tecidual utilizando microscópios.'),
(1013, 'Anatomia Patológica', 'Alterações anatômicas associadas a doenças e lesões.'),
(1013, 'Anatomia Comparada', 'Comparação da anatomia humana com a de outros animais para entender suas similaridades e diferenças.'),
(1013, 'Anatomia Clínica', 'Aplicação dos conhecimentos anatômicos no diagnóstico e tratamento de doenças.'),
(1013, 'Técnicas Anatômicas', 'Técnicas de dissecção e estudo anatômico em laboratório.'),
(1013, 'Aplicações Práticas', 'Exercícios e práticas laboratoriais para aplicação dos conceitos de anatomia.'),
(1014, 'Introdução à Farmacologia', 'Conceitos básicos de farmacologia e sua importância na saúde humana.'),
(1014, 'Farmacocinética', 'Absorção, distribuição, metabolismo e excreção de fármacos no organismo.'),
(1014, 'Farmacodinâmica', 'Mecanismos de ação dos fármacos nos sistemas biológicos.'),
(1014, 'Farmacologia Clínica', 'Aplicação dos conhecimentos de farmacologia no tratamento de doenças.'),
(1014, 'Fármacos por Categoria', 'Classificação e estudo dos principais grupos de fármacos.'),
(1014, 'Efeitos Adversos', 'Reações adversas a medicamentos e suas implicações clínicas.'),
(1014, 'Toxicologia', 'Estudo dos efeitos tóxicos de substâncias químicas no organismo humano.'),
(1014, 'Farmacovigilância', 'Monitoramento e análise dos efeitos dos medicamentos na população.'),
(1014, 'Desenvolvimento de Fármacos', 'Processo de pesquisa, desenvolvimento e testes de novos medicamentos.'),
(1014, 'Aplicações Práticas', 'Estudos de casos e exercícios práticos para aplicação dos conceitos de farmacologia.'),
(1015, 'Introdução ao Direito Civil', 'Conceitos básicos do direito civil e sua importância no ordenamento jurídico.'),
(1015, 'Pessoas', 'Estudo dos direitos e deveres das pessoas naturais e jurídicas.'),
(1015, 'Bens', 'Classificação dos bens, sua aquisição e sua circulação no direito civil.'),
(1015, 'Fatos Jurídicos', 'Conceito e classificação dos fatos jurídicos e suas consequências.'),
(1015, 'Negócios Jurídicos', 'Formação, validade e eficácia dos negócios jurídicos no direito civil.'),
(1015, 'Obrigações', 'Conceito de obrigação, suas fontes, modalidades e efeitos.'),
(1015, 'Contratos', 'Elementos essenciais dos contratos e suas espécies.'),
(1015, 'Responsabilidade Civil', 'Responsabilidade civil contratual e extracontratual.'),
(1015, 'Direitos Reais', 'Conceito e espécies de direitos reais.'),
(1015, 'Aplicações Práticas', 'Análise de casos práticos e exercícios para aplicação dos conceitos de direito civil.'),
(1016, 'Introdução ao Direito Penal', 'Conceitos básicos do direito penal e sua importância no ordenamento jurídico.'),
(1016, 'Princípios do Direito Penal', 'Princípios fundamentais que norteiam o direito penal.'),
(1016, 'Teoria do Crime', 'Conceito de crime, elementos do tipo penal e suas características.'),
(1016, 'Teoria da Pena', 'Conceito de pena, espécies de pena e princípios que regem sua aplicação.'),
(1016, 'Parte Geral do Código Penal', 'Disposições gerais do código penal, incluindo crimes contra a pessoa, patrimônio, etc.'),
(1016, 'Parte Especial do Código Penal', 'Análise dos crimes específicos previstos no código penal.'),
(1016, 'Crimes em Espécie', 'Estudo detalhado de alguns crimes específicos, como homicídio, roubo, estupro, etc.'),
(1016, 'Criminologia', 'Estudo das causas e consequências do comportamento criminoso.'),
(1016, 'Processo Penal', 'Princípios e procedimentos do processo penal.'),
(1016, 'Aplicações Práticas', 'Análise de casos práticos e exercícios para aplicação dos conceitos de direito penal.')


