package persistence;

import java.sql.SQLException;


public interface ICrudIud<T, D>
{
	String iud(String acao, T t, D c) throws SQLException, ClassNotFoundException;

}
