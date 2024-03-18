package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Aluno;

public class AlunoDao implements ICrudDao<Aluno>, ICrudIud<Aluno>
{
	private GenericDao gDao;
	
	public AlunoDao(GenericDao gDao)
	{
		this.gDao = gDao;
	}
	
	@Override
	public Aluno consultar(Aluno a) throws SQLException, ClassNotFoundException 
	{
		return null;
	}

	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException 
	{
		return null;
	}

	@Override
	public String iud(String acao, Aluno a) throws SQLException, ClassNotFoundException 
	{
		return null;
	}
}
