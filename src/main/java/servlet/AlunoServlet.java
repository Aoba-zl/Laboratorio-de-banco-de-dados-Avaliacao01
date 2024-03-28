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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		AlunoController alunoController = new AlunoController();
		CursoController cursoController = new CursoController();
		String erro = "";
		
		List<Aluno> alunos = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();
		try {
			alunos = alunoController.listar(alunos);
			cursos = cursoController.listarCompleto();
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
		String ra = request.getParameter("ra");
		String cpf = request.getParameter("cpf");
		String nome = request.getParameter("nome");
		String nomeSocial = request.getParameter("nomeSocial");
		String dtNascimento = request.getParameter("dtNasc");
		String emailPessoal = request.getParameter("emailPessoal");
		String emailCorporativo = request.getParameter("emailCorporativo");
		String instituicaoConclusaoSegGrau = request.getParameter("instituicaoConclusaoSegGrau");
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
		CursoController cursoController = new CursoController();
		List<Curso> cursos = new ArrayList<>();
		Curso curso = new Curso();
		
		if (cmd.contains("Buscar") || cmd.contains("Alterar") || cmd.contains("Excluir")) {
			aluno.setRa(ra);
		}
		if (cmd.contains("Cadastrar")|| cmd.contains("Alterar")) {
			aluno.setCpf(cpf);
			aluno.setNome(nome);
			aluno.setNomeSocial(nomeSocial);
			aluno.setDtNascimento(toLocalDate(dtNascimento)); 
			aluno.setEmailPessoal(emailPessoal);
			aluno.setEmailCorporativo(emailCorporativo);
			aluno.setInstituicaoConclusaoSegGrau(instituicaoConclusaoSegGrau);
			aluno.setDtConclusaoSegGrau(toLocalDate(dtConclusao));			
			Vestibular vestibular = new Vestibular();
			Float p = Float.parseFloat(pontuacao);
			int pa = Integer.parseInt(posicao);
			vestibular.setPontuacao(p);
			vestibular.setPosicao(pa);
			
			for(int J =0;J<3;J++) {
				Telefone telefone = new Telefone();
				telefone.setNumero(telefones[J]);
				telefoneL.add(telefone);
			}

			aluno.setTelefone(telefoneL);
			aluno.setVestibular(vestibular);
			curso.setCodigo(Integer.parseInt(cursoId));
		}
		try {
			if (cmd.contains("Cadastrar")) {
				saida = alunoController.cadastrar(aluno,curso);
				//saida = "Aluno Cadastrado";
				aluno = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alunoController.alterar(aluno,curso);
				//saida = "Aluno Alterado";
				aluno = null;
			}
			if (cmd.contains("Excluir")) {
				saida = alunoController.excluir(aluno);
				//saida = "Aluno Excluido";
				aluno = null;
			}
			if (cmd.contains("Buscar")) {
				aluno = alunoController.buscar(aluno);
			}
			cursos = cursoController.listarCompleto();
			alunos = alunoController.listar(alunos);
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
			request.setAttribute("aluno",aluno);
			request.setAttribute("alunos",alunos);
			request.setAttribute("cursos",cursos);
			RequestDispatcher rd = request.getRequestDispatcher("aluno.jsp");
			rd.forward(request, response);
		}
	}
	private LocalDate toLocalDate (String data) {
		LocalDate localdate = LocalDate.parse(data);
		return localdate;
		
	}
}
