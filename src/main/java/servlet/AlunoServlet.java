package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import model.Telefone;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import controller.AlunoController;

@WebServlet("/aluno")
public class AlunoServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		RequestDispatcher rd = request.getRequestDispatcher("aluno.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doGet(request, response);
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
		String dtConclusao = request.getParameter("dtConclusao");
		
		//Conteudo telefone
		Telefone tel = new Telefone();
		String telefone = request.getParameter("telefone");
		List<Telefone> telefoneL = new ArrayList<>();

		//Conteudo Vestibular
		String posicao = request.getParameter("posicao");
		String pontuacao = request.getParameter("pontuacao");

		
		Aluno aluno = new Aluno();
		if (cmd.contains("Buscar") || cmd.contains("Alterar") || cmd.contains("Excluir")) {
			aluno.setRa(ra);
		}
		if (cmd.contains("Cadastrar")) {
			aluno.setRa(ra);
			aluno.setCpf(cpf);
			aluno.setNome(nome);
			aluno.setNomeSocial(nomeSocial);
			aluno.setDtNascimento(toLocalDate(dtNascimento));
			aluno.setEmailPessoal(emailPessoal);
			aluno.setEmailCorporativo(emailCorporativo);
			aluno.setInstuicaoConclusaoSegGrau(instituicaoConclusaoSegGrau);
			aluno.setDtConclusaoSegGrau(toLocalDate(dtConclusao));
			
			tel.setNumero(telefone);
			telefoneL.add(tel);
			aluno.setTelefone(telefoneL);
			
			aluno.getVestibular().setPosicao(Integer.parseInt(posicao));
			aluno.getVestibular().setPontuacao(Float.parseFloat(pontuacao));
		}
		try {
			if (cmd.contains("Cadastrar")) {
				alunoController.cadastrar(aluno);
				saida = "Aluno Cadastrado";
			}
			if (cmd.contains("Alterar")) {
				alunoController.alterar(aluno);
				saida = "Aluno Alterado";
			}
			if (cmd.contains("Excluir")) {
				alunoController.excluir(aluno);
				saida = "Aluno Excluido";
			}
			if (cmd.contains("Buscar")) {
				alunoController.buscar(aluno);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}
	}
	private LocalDate toLocalDate (String data) {
		DateTimeFormatter f = new DateTimeFormatterBuilder().parseCaseInsensitive()
		        .append(DateTimeFormatter.ofPattern("yyyy-MMM-dd")).toFormatter();
		LocalDate datetime = null;
		try {
		    datetime = LocalDate.parse(data, f);
		    System.out.println(datetime); // 2019-11-12
		} catch (DateTimeParseException e) {
		     System.out.println(e);
		}
		return datetime;
		
	}
}
