package persistence;

import java.sql.SQLException;
import java.util.List;

public interface ICrudDao<T>
{
	T consultar(T t) throws SQLException, ClassNotFoundException;
	List<T> listar() throws SQLException, ClassNotFoundException;
}
