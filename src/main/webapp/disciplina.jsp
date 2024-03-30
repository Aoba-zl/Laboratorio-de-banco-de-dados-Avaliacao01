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

<link rel="stylesheet" href="./css/style.css">

<title>Disciplina</title>
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
		<main>
			<form action="disciplina" method="post" name="formDisciplina">
				<div class="rounded-4 border border-primary form-container m-auto mb-3">
					<div class="form-floating d-flex mb-3">
						<input type=text class="form-control input-height" id="floatingInput" placeholder="RA" name="ra" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${ra}"></c:out>'>
						<label for="floatingInput" class="font-text">RA</label>
						<button class="btn btn-outline-secondary" name="botao" value="Buscar">Buscar</button>
					</div>
					<input type=hidden class="form-control input-height" placeholder="Matricula" name="matricula" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value='<c:out value="${matricula}"></c:out>'>
				</div>
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
				<div class="form-container m-auto border border-primary rounded-4" style="max-width: 900px; max-height: 690px;">
					<div class="form-container m-auto" style="max-width: 900px; max-height: 600px; overflow-y: scroll;">
						<table class="table table-striped" id="tabela-disciplinas">
							<thead>
								<tr>
									<th class="col">Selecionar Disciplina</th>
									<th class="col">Nome</th>
									<th class="col">Quantidade de Horas Semanais</th>
									<th class="col" style="min-width: 120px;">Dia de aula</th>
									<th class="col">Horario de Inicio</th>
									<th class="col">Horario de Término</th>
									<th class="col" style="min-width: 130px">Status</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty disciplinas}">
									<c:set var="emAndamento" value="false"/>
									<c:forEach var="d" items="${disciplinas}">
										<c:if test="${d.umMatriculaDisciplina.status eq 'Em andamento.'}">
											<c:set var="emAndamento" value="true"/>
										</c:if>
									</c:forEach>
									<c:forEach var="d" items="${disciplinas}">
										<tr ref="${d.diaAula}">
											<td>
												<div>
													<input type="checkbox" class="form-check-input checkbox-disciplina" name="checkboxDisciplina" value="${d.codigo}" <c:if test="${emAndamento}">disabled</c:if>>
												</div>
											</td>
											<th scope="row"><c:out value="${d.nome}"/></th>
											<td><c:out value="${d.qntdHoraSemanais}"/> Horas</td>
											<td><c:out value="${d.diaAula}"/></td>
											<td><c:out value="${d.horarioInicio}"/></td>
											<td><c:out value="${d.horarioFim}"/></td>
											<td><c:out value="${d.umMatriculaDisciplina.status}"/></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="form-container m-auto" style="max-width: 900px;">
						<button class="btn btn-success" name="botao" value="escolherDisciplina">Escolher Disciplina</button>
					</div>
				</div>
			</form>
		</main>
	</div>
</div>
</body>

<script>
	document.querySelectorAll('.checkbox-disciplina').forEach(t => 
		t.addEventListener('change', function() 
			{
				verificarHorarioConflito()
			}
		)
	);
	
	function verificarHorarioConflito()
	{
		let linhas = document.querySelectorAll('#tabela-disciplinas tbody tr');
		let diaHorariosSelecionados = [];
		let linhasConflito = [];
		
		linhas.forEach(function(linha)
			{
				let checkbox = linha.querySelector('.checkbox-disciplina');
				if (checkbox.checked)
				{
					let dia = linha.querySelector('td:nth-child(4)').textContent.trim();
					let horarioInicio = linha.querySelector('td:nth-child(5)').textContent.trim();
					let horarioFim = linha.querySelector('td:nth-child(6)').textContent.trim();
					let diaHorario = {dia, horarioInicio, horarioFim};
					
					diaHorariosSelecionados.push(diaHorario);
				}
			}
		);
		
		const day_with_hour = e => 
		{ 
			let n = {};
			n[e.dia] = { start: e.horarioInicio, end: e.horarioFim };
			return n;
 		} // {Segunda: {start: 12, end: 13}}
		
		const merge_day = (a, [[k, e]]) => 
		{ 
			if (k in a)
				a[k].push(e);
			else a[k] = [e]
			return a;
 		} // {Segunda: [{start: 12, end: 13}, {start: 12, end: 13}]}
		
		if (diaHorariosSelecionados.length > 0)
		{
	        const button = document.querySelector("button[value=escolherDisciplina]")
	        document.querySelectorAll("tr[ref]").forEach(e => e.classList.remove("table-danger"))
	        button.removeAttribute("disabled")
	        
        	Object.entries(
        		diaHorariosSelecionados
	        		.map(day_with_hour)
	        		.map(Object.entries)
	        		.reduce(merge_day, {})
	        ).sort(([k1, v1], [k2, v2]) => v1.start - v2.start)
	        	.map(([k, v]) => [k, v.reduce((d1, d2) => d1.end < d2.start)])
	        	.filter(([k, v]) => !v)
	        	.forEach(([d, _]) => {
	        		document.querySelectorAll("tr[ref='" + d + "']")
	        			.forEach(e => e.classList.add("table-danger"))
	        			
	        		button.setAttribute("disabled", "")
	        	});
		}
	}
</script>

</html>
