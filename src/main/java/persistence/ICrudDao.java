package persistence;

import java.sql.SQLException;
import java.util.List;

/**
 * Interface que contém as operações básicas de consulta e lista de uma CRUD para entidades de dados.
 * 
 * @param <T> O tipo de entidade para qual a interface trabalha
 */
public interface ICrudDao<T>
{
	/**
	 * Método responsável por consultar uma entidade do tipo especificado.
	 * 
	 * @param t Um objeto contendo os dados da consulta
	 * @return Um objeto do tipo especificado
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	T consultar(T t) throws SQLException, ClassNotFoundException;
	
	/**
	 * Método responsável por retornar uma lista de entidade do tipo especificado.
	 * 
	 * @return Uma lista de todas as entidades do tipo especificado
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	List<T> listar() throws SQLException, ClassNotFoundException;
}
