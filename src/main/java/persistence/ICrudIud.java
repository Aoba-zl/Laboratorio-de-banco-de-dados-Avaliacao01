package persistence;

import java.sql.SQLException;

/**
 * Interface que contém as operações básicas de inserir, atualizar e excluir de uma CRUD para entidades de dados.
 * 
 * @param <T> O tipo de entidade para qual a interface trabalha
 * @param <D> O tipo de entidade para qual a interface trabalha
 */
public interface ICrudIud<T, D>
{
	/**
	 * Método responsável por fazer a inserção, atualização e exclusão do tipo de entidade especificado.
	 * 
	 * @param acao Contém a ação que será usado dentro do método ("I" para insert, "U" para updade, "D" para delete)
	 * @param t Objeto de entidade do tipo especificado
	 * @param c Objeto de entidade do tipo especificado
	 * @return Uma String contendo a saída gerada do banco de dados
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	String iud(String acao, T t, D c) throws SQLException, ClassNotFoundException;

}
