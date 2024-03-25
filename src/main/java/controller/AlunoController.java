package controller;

import java.sql.SQLException;

import model.Aluno;
import model.Curso;
import persistence.AlunoDao;
import persistence.GenericDao;

public class AlunoController 
{
	public void cadastrar (Aluno aluno,Curso curso) throws SQLException, ClassNotFoundException {
			GenericDao gDao = new GenericDao();
			AlunoDao aDao = new AlunoDao(gDao);
			aDao.iud("I", aluno,curso);
	}
	public void alterar(Aluno aluno) throws SQLException, ClassNotFoundException {
		
	}
	public void excluir(Aluno aluno) throws SQLException, ClassNotFoundException {
		
	}
	public void buscar(Aluno aluno) throws SQLException, ClassNotFoundException {
		
	}
	public void listar() throws SQLException, ClassNotFoundException {
		
	}
}
