package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Disciplina;
import model.MatriculaDisciplina;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import controller.DisciplinaController;

/**
 * Essa Classe é responsável por fazer o request do .jsp do tipo disciplina.
 */
@WebServlet("/disciplina")
public class DisciplinaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		session.invalidate(); // Invalida/limpa a sessão do usuário.
		RequestDispatcher rd = request.getRequestDispatcher("disciplina.jsp");
		rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//entrada
		HttpSession session = request.getSession();
		String cmd = request.getParameter("botao"); // Obtém o valor do botão.
		String ra = request.getParameter("ra"); // Obtém o valor do ra.
		String[] cod = request.getParameterValues("checkboxDisciplina"); // Obtém a array de código das checkbox selecionadas.
		String matricula = ""; // String matricula iniciada para a obtenção do valor depois.
		List<Disciplina> disciplinas = new ArrayList<>();
		
		
		//saida
		String saida = "";
		String erro = "";
		DisciplinaController dControl = new DisciplinaController();
		
		try {
			if(dControl.validar(ra)) // Verifica se o campo ra não está em branco.
			{
				saida = "Ra em branco!";
				return;
			}
			
			if(cmd.contains("Buscar")) // Condição para verificar se terá busca do usuário.
			{
				disciplinas = dControl.buscarAlunoDisciplina(ra);
				MatriculaDisciplina md = new MatriculaDisciplina();
				md = disciplinas.get(0).getUmMatriculaDisciplina();
				matricula = md.getIdMatricula();
				
				session.setAttribute("disciplinas", disciplinas); // Guarda a lista de disciplina na sessão.
				session.setAttribute("matricula", matricula); // Guarda a String da matricula na sessão.
			}
			if(cmd.contains("escolherDisciplina")) // Condição para verificar se terá escolha de disciplina do usuário.
			{
				if(!(cod == null))
				{
					matricula = (String) session.getAttribute("matricula"); // Recebe a String de matricula da sessão.
					disciplinas = (List<Disciplina>) session.getAttribute("disciplinas"); // Recebe a lista de disciplina da sessão.
					
					if(dControl.verificaHorario(disciplinas, cod)) // Verifica se o horário tem conflito com outro horário.
					{
						saida = "Há algum conflito de horário!";
						return;
					}
					
					
					List<MatriculaDisciplina> mdList = new ArrayList<MatriculaDisciplina>();
					for(String c : cod) // ForEach do código para criar MatriculaDisciplina com seus devidos valores.
					{
						MatriculaDisciplina md = new MatriculaDisciplina();
						md.setCodigoDisciplina(c);
						md.setIdMatricula(matricula);
						md.setStatus("Em andamento.");
						
						mdList.add(md);
					}
					
					saida = dControl.escolheDisciplina(mdList); // Manda a lista de MatriculaDisciplina e retorna uma resposta para a saida.
					
					disciplinas = dControl.buscarAlunoDisciplina(ra); // Obtém a nova lista de disciplinas atualizada.
				}
				else
				{
					saida = "Selecione as caixa das disciplinas que queira fazer!";
				}
			}
			
		} catch (SQLException | ClassNotFoundException e)
		{
			erro = e.getMessage();
		} finally {
			
			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
			request.setAttribute("ra", ra);
			request.setAttribute("disciplinas", disciplinas);
			
			RequestDispatcher rd = request.getRequestDispatcher("disciplina.jsp");
			rd.forward(request, response);
		}
		
	}

}
