package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Essa classe é responsável por fazer uma conexão com o banco de dados.
 */
public class GenericDao 
{
	private Connection c;

	
	/**
	 * Método responsável por criar uma conexão com o banco de dados e retornar essa conexão.
	 * 
	 * @return A conexão com o banco de dados
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
    public Connection getConnection() throws SQLException, ClassNotFoundException
    {
        String hostName = "localhost";
        String dbName = "matricula";
        String user = "usuarioDB";
        String password = "123456";

        Class.forName("net.sourceforge.jtds.jdbc.Driver");
        
        c = DriverManager.getConnection(String.format("jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s",
                    hostName, dbName, user, password));


        return c;
    }
}
