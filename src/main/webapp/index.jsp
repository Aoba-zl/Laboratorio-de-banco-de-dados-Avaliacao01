<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">


<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<link rel="stylesheet" href="./css/style.css">
<!-- Script -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<title>Protótipo do Sistema Acadêmico AGIS</title>
</head>
<body>
	<div class="bg-black custom">
		<div class="container bg-white scroll" id="nav-container">
			<nav class="navbar navbar-expand">
				<div class="container-fluid">
					<div class="m-auto">
						<div class="row">
							<div class="col-auto p-0 text-center" style="width: 130px;">
								<button class="btn btn-outline-primary" style="width: 120px" OnClick="window.location.href='./'">home</button>
							</div>
							<div class="col-auto p-0 text-center" style="width: 130px;">
								<button class="btn btn-outline-primary" style="width: 120px" OnClick="window.location.href='./aluno'">Pagina Aluno</button>
							</div>
							<div class="col-auto p-0 text-center" style="width: 130px;">
								<button class="btn btn-outline-primary" style="width: 120px" OnClick="window.location.href='./curso'">Ver Cursos</button>
							</div>
						</div>
					</div>
				</div>
			</nav>
			<div class="container border border-3 border-primary rounded-4 mb-4 mt-4" style="max-width: 1000px; padding: 0.6rem;">
				<h2 class="text-center">Descrição Geral</h2>
				<p>O AGIS é um sistema acadêmico desenvolvido para atender às necessidades da Faculdade X. Ele oferece diversas funcionalidades para alunos, professores e funcionários da secretaria acadêmica.</p>
				<h2 class="text-center">Funcionalidades Principais</h2>
				<ul class="list-unstyled">
					<li class="mb-3"><h3>Cadastro de Alunos</h3>
					<ul>
						<li>A secretaria acadêmica pode cadastrar novos alunos que ingressam na faculdade pelo vestibular.
						<li>Diversos dados devem ser incluídos no cadastro, como CPF (validado de acordo com a legislação brasileira), nome, nome social (opcional), data de nascimento, telefones de contato, e-mails pessoal e corporativo, data de conclusão do ensino médio, instituição de conclusão do ensino médio, pontuação no vestibular, posição no vestibular, ano e semestre de ingresso, semestre e ano limite de graduação.
						<li>Todos os alunos recebem um RA (Registro Acadêmico) único.
						<li>Cada aluno está vinculado a um curso e um turno específicos.
					</ul>
					<li class="mb-3"><h3>Cadastro de Cursos</h3>
					<ul>
						<li>Os cursos oferecidos pela faculdade são registrados, incluindo código único numérico, nome, carga horária, sigla para uso interno e última nota de participação no ENADE (Exame Nacional de Desempenho de Estudantes).
					</ul>
					<li class="mb-3"><h3>Cadastro de Disciplinas</h3>
					<ul>
						<li>Os cursos têm entre 40 e 50 disciplinas, cada uma com código numérico, nome e quantidade de horas semanais.
						<li>Cada disciplina tem entre 5 e 15 conteúdos que serão ministrados ao longo de um semestre.
					</ul>
					<li class="mb-3"><h3>Matrícula em Disciplinas</h3>
					<ul>
						<li>Os alunos podem se matricular em uma ou mais disciplinas do seu curso para serem cursadas ao longo de um semestre.
						<li>O processo de matrícula inclui a seleção das disciplinas desejadas, considerando possíveis conflitos de horários e restrições específicas.
						<li>As matrículas são feitas semestralmente e o sistema deve estar preparado para isso.
					</ul>
					<li class="mb-3"><h3>Visualização de Disciplinas Matriculadas</h3>
					<ul>
						<li>Os alunos podem visualizar as disciplinas nas quais estão matriculados, com base no seu RA.
					</ul>
				</ul>
				<h2 class="text-center">Validações e Controles</h2>
				<ul>
					<li>Deve ser criada uma procedure para validar o CPF antes da inserção.
					<li>Deve ser criada uma procedure para validar a idade do aluno (igual ou superior a 16 anos) antes da inserção.
					<li>A data limite de graduação deve ser calculada por uma procedure que considera 5 anos após o ingresso.
					<li>O RA dos alunos deve ser gerado por uma procedure para inserção.
					<li>A inserção e alteração das matrículas devem ser controladas por uma procedure, considerando restrições específicas.
				</ul>
				<h1 class="text-center">Avaliação</h1>
				<p>O projeto será avaliado com base na qualidade do desenvolvimento, usabilidade do sistema, qualidade da modelagem, boas práticas de programação e atendimento aos requisitos propostos. O código-fonte deve ser hospedado no GitHub e a modelagem deve ser documentada em uma pasta chamada "doc" dentro do projeto Java Web.
			</div>
		</div>
	</div>
</body>
</html>