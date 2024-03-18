package persistence;

import java.sql.SQLException;

public interface ICrudIud<T>
{
	String iud(String acao, T t) throws SQLException, ClassNotFoundException;
}
