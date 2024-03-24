package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Disciplina;

public class DisciplinaDao implements ICrudDao<Disciplina>
{
private GenericDao gDao;
	
	public DisciplinaDao(GenericDao gDao)
	{
		this.gDao = gDao;
	}
	
	public List<Disciplina> consultarAlunoDisciplina(String ra) throws SQLException, ClassNotFoundException
	{
		List<Disciplina> disciplinas = new ArrayList<Disciplina>();
		Connection c = gDao.getConnection();
		String sql = "SELECT d.nome AS nome_disciplina, d.qntd_hora_semanais "
				   + "FROM disciplina d, curso c, matricula m, aluno a "
				   + "WHERE d.codigo_curso = c.codigo "
				   + "	AND m.codigo_curso = c.codigo "
				   + "  AND m.ra_aluno = a.ra "
				   + "  AND a.ra = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, ra);
		ResultSet rs = ps.executeQuery();
		
		
		while(rs.next())
		{
			Disciplina d = new Disciplina();
			d.setNome(rs.getString("nome_disciplina"));
			d.setQntdHoraSemanais(rs.getInt("qntd_hora_semanais"));
			
			disciplinas.add(d);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return disciplinas;
	}
	
	@Override
	public Disciplina consultar(Disciplina d) throws SQLException, ClassNotFoundException //não feito por ser apenas crud do aluno
	{
		Connection c = gDao.getConnection();
		String sql = "SELECT d.nome AS nome_disciplina, d.qntd_hora_semanais "
				   + "FROM disciplina d, curso c "
				   + "WHERE d.codigo_curso = c.codigo "
				   + "	AND codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, d.getCodigo());
		ResultSet rs = ps.executeQuery();
		
		if(rs.next())
		{
			d.setCodigo(rs.getInt("codigo"));
			d.setCodigoCurso(rs.getInt("codigo_curso"));
			d.setNome(rs.getString("nome_disciplina"));
			d.setQntdHoraSemanais(rs.getInt("qntd_hora_semanais"));
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return d;
	}

	@Override
	public List<Disciplina> listar() throws SQLException, ClassNotFoundException 
	{
		List<Disciplina> disciplinas = new ArrayList<Disciplina>();
		Connection c = gDao.getConnection();
		String sql = "SELECT d.nome AS nome_disciplina, d.qntd_hora_semanais "
				   + "FROM disciplina d, curso c "
				   + "WHERE d.codigo_curso = c.codigo";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			Disciplina d = new Disciplina();
			d.setNome(rs.getString("nome_disciplina"));
			d.setQntdHoraSemanais(rs.getInt("qntd_hora_semanais"));
			
			disciplinas.add(d);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return disciplinas;
	}

}
