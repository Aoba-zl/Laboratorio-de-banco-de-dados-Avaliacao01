package controller;

import java.sql.SQLException;
import java.util.List;

import model.Disciplina;
import persistence.GenericDao;
import persistence.DisciplinaDao;

public class DisciplinaController 
{
	public List<Disciplina> buscarAlunoDisciplina(String ra) throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> d = dDao.consultarAlunoDisciplina(ra);
		return d;
	}

	public List<Disciplina> listar() throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> disciplinas = dDao.listar();
		
		return disciplinas;
	}
	
	public boolean validar(String v)
	{
		if(v.strip().equals(""))
			return true;
		
		return false;
	}
}
