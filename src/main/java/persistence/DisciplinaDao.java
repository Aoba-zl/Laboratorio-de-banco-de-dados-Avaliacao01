package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Disciplina;

public class DisciplinaDao implements ICrudDao<Disciplina>
{
private GenericDao gDao;
	
	public DisciplinaDao(GenericDao gDao)
	{
		this.gDao = gDao;
	}
	
	@Override
	public Disciplina consultar(Disciplina d) throws SQLException, ClassNotFoundException
	{
		return null;
	}

	@Override
	public List<Disciplina> listar() throws SQLException, ClassNotFoundException 
	{
		return null;
	}

}
