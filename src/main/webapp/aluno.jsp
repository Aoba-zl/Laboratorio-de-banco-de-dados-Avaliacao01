<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">


<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<!-- Script -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
</script>

<link rel="stylesheet" href="./css/style.css">

<title>Aluno</title>
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
				<nav class="navbar navbar-expand">
					<div class="container-fluid">
						<div class="m-auto">
							<div class="row">
								<div class="col-auto p-0 text-center" style="width: 130px;">
									<button class="btn btn-outline-primary" style="width: 120px" OnClick="window.location.href='./aluno'">Aluno</button>
								</div>
								<div class="col-auto p-0 text-center" style="width: 130px;">
									<button class="btn btn-outline-primary" style="width: 120px" OnClick="window.location.href='./disciplina'">Disciplina</button>
								</div>
							</div>
						</div>
					</div>
				</nav>
			<main class="rounded-4 border border-primary form-container-aluno m-auto mb-3">
				<form action="aluno" method="post">
					<div class="row align-item-center justify-content-between">
						<div class="form-container-input col">
							<div class="mb-3">
								<h5 class="mb-3 d-flex justify-content-center align-items-center" style="height: 40px;">Informações do Aluno</h5>
							</div>
							<div class="form-floating d-flex mb-3">
								<input type=text class="form-control input-height" id="floatingInput" placeholder="Ra" name="ra" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${aluno.ra}"></c:out>'>
								<label for="floatingInput" class="font-text">RA</label>
								<button class="btn btn-outline-secondary" name="botao" value="Buscar">Buscar</button>
							</div>
							<div class="form-floating mb-3">
								<input type=text class="form-control input-height" id="floatingInput" placeholder="Cpf" name="cpf" maxlength="11" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${aluno.cpf}"></c:out>'>
								<label for="floatingInput" class="font-text">CPF</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Nome" name="nome" value='<c:out value="${aluno.nome}"></c:out>'>
								<label for="floatingInput" class="font-text">Nome</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Nome Social" name="nomeSocial" value='<c:out value="${aluno.nomeSocial}"></c:out>'>
								<label for="floatingInput" class="font-text">Nome Social</label>
							</div>
							<div class="form-floating mb-3 input-height">
								<input type="date" min="1800-01-01" max="9999-01-01" class="form-control input-height" id="floatingInput" placeholder="Data de nascimento" name="dtNasc" value='<c:out value="${aluno.dtNascimento}"></c:out>'>
								<label for="floatingInput" class="font-text">Data de nascimento</label>
							</div>
							<div class="form-floating mb-3 input-height">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Email Pessoal" name="emailPessoal" value='<c:out value="${aluno.emailPessoal}"></c:out>'>
								<label for="floatingInput" class="font-text">Email Pessoal</label>
							</div>
							<div class="form-floating mb-3 input-height">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Email Corporativo" name="emailCorporativo" value='<c:out value="${aluno.emailCorporativo}"></c:out>'>
								<label for="floatingInput" class="font-text">Email Corporativo</label>
							</div>
							<div class="form-floating mb-3 input-height d-flex">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Telefone" name="telefone" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${telefones.get(0).getNumero()}"></c:out>'>
								<label for="floatingInput" class="font-text">Telefone</label>
							</div>
							<div class="form-floating mb-3 input-height d-flex">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Telefone" name="telefone" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${telefones.get(1).getNumero()}"></c:out>'>
								<label for="floatingInput" class="font-text">Telefone</label>
							</div>
							<div class="form-floating mb-3 input-height d-flex">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Telefone" name="telefone" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${telefones.get(2).getNumero()}"></c:out>'>
								<label for="floatingInput" class="font-text">Telefone</label>
							</div>
						</div>
						<div class="form-container-input col">
							<div class="mb-3 d-flex justify-content-center align-items-center" style="height: 40px;">
								<h5>Instituição de Ensino</h5>
							</div>
							<div class="form-floating mb-3 input-height">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Instituição de Conclusão do Segundo Grau" name="instituicaoConclusaoSegGrau" value='<c:out value="${aluno.instituicaoConclusaoSegGrau}"></c:out>'>
								<label for="floatingInput" class="font-text">Instituição de Conclusão do Segundo Grau</label>
							</div>
							<div class="form-floating mb-3 input-height">
								<input type="date" min="1800-01-01" max="9999-01-01" class="form-control input-height" id="floatingInput" placeholder="Data de Conclusão" name="dtConclusaoSegGrau" value='<c:out value="${aluno.dtConclusaoSegGrau}"></c:out>'>
								<label for="floatingInput" class="font-text">Data de Conclusão</label>
							</div>
							<div class="mb-3 d-flex justify-content-center align-items-center" style="height: 40px;">
								<h5>Vestibular</h5>
							</div>
							<div class="form-floating d-flex mb-3">
								<input type=text class="form-control input-height" id="floatingInput" placeholder="Posição" name="posicao" maxlength="5" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${aluno.vestibular.posicao}"></c:out>'>
								<label for="floatingInput" class="font-text">Posição</label>
							</div>
							<div class="form-floating mb-3 input-height">
								<input type="text" class="form-control input-height" id="floatingInput" placeholder="Pontuação" name="pontuacao" oninput="this.value = this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1')" onchange="(function(el){el.value=parseFloat(el.value).toFixed(2);})(this)" value='<c:out value="${aluno.vestibular.pontuacao}"></c:out>'>
								<label for="floatingInput" class="font-text">Pontução</label>
							</div>
							<div class="mb-3 d-flex justify-content-center align-items-center" style="height: 40px;">
								<h5>Curso</h5>
							</div>
							<div class="mb-3 input-height">
								<select name="tabCursos" class="form-select" size="9" style="max-height: 208px;">
									<option disabled selected>Selecione um curso</option>
									<c:if test="${not empty cursos}">
										<c:forEach var="c" items="${cursos}">
											<option value="${c.codigo}">${c.nome}</option>
										</c:forEach>
									</c:if>
								</select>
							</div>
						</div>
					</div>
					<div class="d-flex">
						<button class="btn btn-success me-3" name="botao" value="Cadastrar">Cadastrar</button>
						<button class="btn btn-primary me-3" name="botao" value="Alterar">Alterar</button>
						<button class="btn btn-danger ms-auto" name="botao" value="Excluir">Excluir</button>
					</div>
				</form>
			</main>
			<div>
				<c:if test="${not empty erro}">
					<h2 class="text-center"><b><c:out value="${erro}"/></b></h2>				
				</c:if>
			</div>
			<div>
				<c:if test="${not empty saida}">
					<h2 class="text-center"><b><c:out value="${saida}"/></b></h2>
				</c:if>
			</div>
			<div class="form-container m-auto border border-primary rounded-4" style="max-width: 1300px;">
				<table class="table table-striped">
					<thead>
						<tr class="text-center">
							<th class="col">RA</th>
							<th class="col">CPF</th>
							<th class="col">Nome</th>
							<th class="col">Data de nascimento</th>
							<th class="col">Email Pessoal</th>
							<th class="col" style="text-wrap: nowrap; max-width: 255px; overflow-x: hidden; text-overflow: ellipsis" title="Inst. de Concl. de Segundo grau">Inst. de Concl. de Segundo grau</th>
							<th class="col">Data de conclusão</th>
							<th class="col">Posição</th>
							<th class="col">Pontuação</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty alunos}">
							<c:forEach var="a" items="${alunos}">
								<tr>
									<th scope="row"><c:out value="${a.ra}"/></th>
									<th><c:out value="${a.cpf}"/></th>
									<td><c:out value="${a.nome}"/></td>
									<td><c:out value="${a.dtNascimentoFormat}"/></td>
									<td><c:out value="${a.emailPessoal}"/></td>
									<td><c:out value="${a.instituicaoConclusaoSegGrau}"/></td>
									<td><c:out value="${a.dtConclusaoSegGrauFormat}"/></td>
									<td><c:out value="${a.vestibular.posicao}"/></td>
									<td><c:out value="${a.vestibular.pontuacao}"/></td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>