package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Curso;

/**
 * Essa Classe é responsável por mexer diretamente no banco de dados da entidade Curso.
 */
public class CursoDao implements ICrudDao<Curso>
{
	private GenericDao gDao = new GenericDao();
	
	/**
	 * Método responsável por obter a conexão do banco de dados.
	 * 
	 * @param gDao Um objeto do tipo GenericDao com o tipo de conexão
	 */
	public CursoDao(GenericDao gDao)
	{
		this.gDao = gDao;
	}
	
	/**
	 * Método responsável por consultar apenas um curso do banco de dados.
	 * 
	 * @param c O objeto curso contendo os dados do curso.
	 * @return Um objeto do tipo Curso
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	@Override
	public Curso consultar(Curso c) throws SQLException, ClassNotFoundException // Método não criado por não estar dentro do escopo do trabalho.
	{
		return null;
	}
	
	/**
	 * Método responsável por receber os dados do banco de dados e retornar uma lista de Curso.
	 * 
	 * @return Retorna uma lista de objetos do tipo Curso
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	@Override
	public List<Curso> listar() throws SQLException, ClassNotFoundException 
	{
		List<Curso> cursos = new ArrayList<Curso>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, nome, carga_horaria, sigla, ult_nota_participacao_enade FROM curso ";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			Curso cr = new Curso();
			cr.setCodigo(rs.getInt("codigo"));
			cr.setNome(rs.getString("nome"));
			cr.setCargaHoraria(rs.getInt("carga_horaria"));
			cr.setSigla(rs.getString("sigla"));
			cr.setUltNotaParticipacaoEnade(rs.getFloat("ult_nota_participacao_enade"));
			
			cursos.add(cr);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return cursos;
	}
	
	public List<Curso> listarCompleto() throws SQLException, ClassNotFoundException // não é necessário TODO
	{
		List<Curso> cursos = new ArrayList<Curso>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, nome, carga_horaria, sigla, ult_nota_participacao_enade FROM curso ";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			Curso cr = new Curso();
			cr.setCodigo(rs.getInt("codigo"));
			cr.setNome(rs.getString("nome"));
			cr.setCargaHoraria(rs.getInt("carga_horaria"));
			cr.setSigla(rs.getString("sigla"));
			cr.setUltNotaParticipacaoEnade(rs.getFloat("ult_nota_participacao_enade"));
			
			cursos.add(cr);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return cursos;
	}
}
