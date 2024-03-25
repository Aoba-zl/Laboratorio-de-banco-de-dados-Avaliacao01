package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Disciplina;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import controller.DisciplinaController;

@WebServlet("/disciplina")
public class DisciplinaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		List<Disciplina> disciplinas = new ArrayList<>();
		DisciplinaController dControl = new DisciplinaController();
		String erro = "";
		
		try {			
			disciplinas = dControl.listar();
		} catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			
			request.setAttribute("erro", erro);
			request.setAttribute("disciplinas", disciplinas);
			
			RequestDispatcher rd = request.getRequestDispatcher("disciplina.jsp");
			rd.forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//entrada
		String cmd = request.getParameter("botao");
		String ra = request.getParameter("ra");
		String cod = request.getParameter("checkboxDisciplina");
		System.out.println(cod);
		List<Disciplina> disciplinas = new ArrayList<>();
		
		//saida
		String saida = "";
		String erro = "";
		DisciplinaController dControl = new DisciplinaController();
		
		try {
			if(dControl.validar(ra))
			{
				saida = "Ra em branco!";
				return;
			}
			
			
			if(cmd.contains("Buscar"))
			{
				disciplinas = dControl.buscarAlunoDisciplina(ra);
			}
		} catch (SQLException | ClassNotFoundException e)
		{
			erro = e.getMessage();
		} finally {
			try {
				if(!cmd.contains("Buscar"))
				{
					disciplinas = dControl.listar();					
				}
			} catch (SQLException | ClassNotFoundException e) {
				erro = e.getMessage();
			}
			
			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
//			request.setAttribute("disciplina", d);
			request.setAttribute("disciplinas", disciplinas);
			
			RequestDispatcher rd = request.getRequestDispatcher("disciplina.jsp");
			rd.forward(request, response);
		}
		
	}

}
