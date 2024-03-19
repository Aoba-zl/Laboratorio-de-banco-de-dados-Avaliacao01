package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Curso;

public class CursoDao implements ICrudDao<Curso>
{

	@Override
	public Curso consultar(Curso t) throws SQLException, ClassNotFoundException {
		return null;
	}

	@Override
	public List<Curso> listar() throws SQLException, ClassNotFoundException {
		return null;
	}

}
