package controller;

import java.sql.SQLException;
import java.util.List;

import model.Curso;
import persistence.CursoDao;
import persistence.GenericDao;

public class CursoController 
{
	public List<Curso> listar() throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		List<Curso> cursos = cDao.listar();
		return cursos;
	}
	public List<Curso> listarCompleto() throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		List<Curso> cursos = cDao.listarCompleto();
		return cursos;
	}
}
