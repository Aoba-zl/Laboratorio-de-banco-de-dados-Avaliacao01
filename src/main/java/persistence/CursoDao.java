package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Curso;

public class CursoDao implements ICrudDao<Curso>
{
	private GenericDao gDao = new GenericDao();
	
	public CursoDao(GenericDao gDao)
	{
		this.gDao = gDao;
	}
	
	@Override
	public Curso consultar(Curso t) throws SQLException, ClassNotFoundException {
		return null;
	}

	@Override
	public List<Curso> listar() throws SQLException, ClassNotFoundException {
		List<Curso> cursos = new ArrayList<Curso>();
		Connection c = gDao.getConnection();
		String sql = "SELECT nome, carga_horaria, sigla, ult_nota_participacao_enade FROM curso ";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			Curso cr = new Curso();
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
	public List<Curso> listarCompleto() throws SQLException, ClassNotFoundException {
		List<Curso> cursos = new ArrayList<Curso>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo,nome, carga_horaria, sigla, ult_nota_participacao_enade FROM curso ";
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
