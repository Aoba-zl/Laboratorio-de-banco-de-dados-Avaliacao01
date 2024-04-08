package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import model.Curso;
import model.Telefone;
import model.Vestibular;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import controller.AlunoController;
import controller.CursoController;

@WebServlet("/aluno")
public class AlunoServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String erro = "";
		
		List<Aluno> alunos = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();
		try {
			alunos = getAlunos(alunos);
			cursos = getCursos(cursos);
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			request.setAttribute("erro", erro);
			request.setAttribute("alunos",alunos);
			request.setAttribute("cursos",cursos);
			RequestDispatcher rd = request.getRequestDispatcher("aluno.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String saida ="";
		String erro = "";
		AlunoController alunoController = new AlunoController();
		String cmd = request.getParameter("botao");
		//Conteudo aluno
		String ra = request.getParameter("ra").trim();
		String cpf = request.getParameter("cpf").trim();
		String nome = request.getParameter("nome").trim();
		String nomeSocial = request.getParameter("nomeSocial").trim();
		String dtNascimento = request.getParameter("dtNasc");
		String emailPessoal = request.getParameter("emailPessoal").trim();
		String emailCorporativo = request.getParameter("emailCorporativo").trim();
		String instituicaoConclusaoSegGrau = request.getParameter("instituicaoConclusaoSegGrau").trim();
		String dtConclusao = request.getParameter("dtConclusaoSegGrau");
		String cursoId = request.getParameter("tabCursos");	
		
		//Conteudo telefone

		String[] telefones = request.getParameterValues("telefone");
		List<Telefone> telefoneL = new ArrayList<>();

		//Conteudo Vestibular
		String posicao = request.getParameter("posicao");
		String pontuacao = request.getParameter("pontuacao");

		List<Aluno> alunos = new ArrayList<>();
		Aluno aluno = new Aluno();
		List<Curso> cursos = new ArrayList<>();
		Curso curso = new Curso();
		
		if (cmd.contains("Buscar") || cmd.contains("Alterar") || cmd.contains("Excluir")) {
			aluno.setRa(ra);
		}
		if (cmd.contains("Cadastrar")|| cmd.contains("Alterar")) {
			aluno.setCpf(cpf);
			aluno.setNome(nome);
			aluno.setNomeSocial(nomeSocial);
			if (dtNascimento != "") {
				aluno.setDtNascimento(toLocalDate(dtNascimento));
			}
			aluno.setEmailPessoal(emailPessoal);
			if (!emailCorporativo.trim().contains("")) {
				aluno.setEmailCorporativo(emailCorporativo);
			} else {
				aluno.setEmailCorporativo(null);
			}
			aluno.setInstituicaoConclusaoSegGrau(instituicaoConclusaoSegGrau);
			if (dtConclusao != "") {
				aluno.setDtConclusaoSegGrau(toLocalDate(dtConclusao));	
			}
			Vestibular vestibular = new Vestibular();
			if (pontuacao != "") {
				Float pont = Float.parseFloat(pontuacao);
				vestibular.setPontuacao(pont);
			}

			if (posicao != "") {
				int posi = Integer.parseInt(posicao);
				vestibular.setPosicao(posi);
			}
			aluno.setVestibular(vestibular);

			if (cursoId != null) {
				curso.setCodigo(Integer.parseInt(cursoId));
			} else {
				curso.setCodigo(-1);
			}
			for(int J = 0;J<3;J++) {
				Telefone telefone = new Telefone();
				telefone.setNumero(telefones[J]);
				telefoneL.add(telefone);
			}
			aluno.setTelefone(telefoneL);
		}
		try {
			if (cmd.contains("Cadastrar")) {
				saida = alunoController.cadastrar(aluno,curso);
				//saida = "Aluno Cadastrado";
				if (saida.contains("Aluno cadastrado!")) {
					aluno = null;
				}
			}
			if (cmd.contains("Alterar")) {
				saida = alunoController.alterar(aluno,curso);
				//saida = "Aluno Alterado";
				if (saida.contains("Aluno atualizado!")) {
					aluno = null;
				}
			}
			if (cmd.contains("Excluir")) {
				saida = alunoController.excluir(aluno);
				//saida = "Aluno Excluido";
				if (saida.contains("Aluno excluído!")) {
					aluno = null;
				}
			}
			if (cmd.contains("Buscar")) {
				aluno = alunoController.buscar(aluno);
				
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			try {
				cursos = getCursos(cursos);
				alunos = getAlunos(alunos);
			} catch (SQLException | ClassNotFoundException e) {
				erro = e.getMessage();
			}
			
			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
			request.setAttribute("aluno",aluno);
			request.setAttribute("alunos",alunos);
			request.setAttribute("cursos",cursos);
			if (cmd.contains("Buscar") && aluno.getTelefone() != null) {
				request.setAttribute("telefones",aluno.getTelefone());
			}
			RequestDispatcher rd = request.getRequestDispatcher("aluno.jsp");
			rd.forward(request, response);
		}
	}

	private LocalDate toLocalDate (String data) {
		LocalDate localdate = LocalDate.parse(data);
		return localdate;
		
	}
	private List<Curso> getCursos (List<Curso> cursos) throws ClassNotFoundException, SQLException {
		CursoController cursoController = new CursoController();
		cursos = cursoController.listarCompleto();
		return cursos;
		
	}
	private List<Aluno> getAlunos (List<Aluno> alunos) throws ClassNotFoundException, SQLException {
		AlunoController alunoController = new AlunoController();
		return alunoController.listar(alunos);
	}
}
