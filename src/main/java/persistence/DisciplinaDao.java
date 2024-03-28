package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Disciplina;
import model.MatriculaDisciplina;

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
		String sql = "SELECT d.codigo, d.nome AS nome_disciplina, d.qntd_hora_semanais, d.dia_aula, d.horario_inicio, d.horario_fim, md.status, md.id_matricula "
				   + "FROM disciplina d, matricula_disciplina md, matricula m, aluno a "
				   + "WHERE d.codigo = md.codigo_disciplina "
				   + "	AND m.id = md.id_matricula"
				   + "  AND m.ra_aluno = a.ra "
				   + "  AND a.ra = ? "
				   + "ORDER BY md.status ASC";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, ra);
		ResultSet rs = ps.executeQuery();
		
		
		while(rs.next())
		{
			Disciplina d = new Disciplina();
			MatriculaDisciplina md = new MatriculaDisciplina();
			d.setCodigo(rs.getInt("codigo"));
			d.setNome(rs.getString("nome_disciplina"));
			d.setQntdHoraSemanais(rs.getInt("qntd_hora_semanais"));
			String diaSemana = "";
			switch (rs.getInt("dia_aula"))
			{
				case 1:
					diaSemana = "Segunda-feira";
					break;
				case 2:
					diaSemana = "Terça-feira";
					break;
				case 3:
					diaSemana = "Quarta-feira";
					break;
				case 4:
					diaSemana = "Quinta-feira";
					break;
				case 5:
					diaSemana = "Sexta-feira";
					break;
			}
			d.setDiaAula(diaSemana);
			d.setHorarioInicio(rs.getTime("horario_inicio").toLocalTime());
			d.setHorarioFim(rs.getTime("horario_fim").toLocalTime());
			md.setStatus(rs.getString("status"));
			md.setIdMatricula(rs.getString("id_matricula"));
			d.setUmMatriculaDisciplina(md);
			
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
		String sql = "SELECT d.codigo, d.nome AS nome_disciplina, d.qntd_hora_semanais, d.dia_aula, d.horario_inicio, d.horario_fim "
				   + "FROM disciplina d, curso c "
				   + "WHERE d.codigo_curso = c.codigo";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigo"));
			d.setNome(rs.getString("nome_disciplina"));
			d.setQntdHoraSemanais(rs.getInt("qntd_hora_semanais"));
			String diaSemana = "";
			switch (rs.getInt("dia_aula"))
			{
				case 1:
					diaSemana = "Segunda-feira";
					break;
				case 2:
					diaSemana = "Terça-feira";
					break;
				case 3:
					diaSemana = "Quarta-feira";
					break;
				case 4:
					diaSemana = "Quinta-feira";
					break;
				case 5:
					diaSemana = "Sexta-feira";
					break;
			}
			d.setDiaAula(diaSemana);
			d.setHorarioInicio(rs.getTime("horario_inicio").toLocalTime());
			d.setHorarioFim(rs.getTime("horario_fim").toLocalTime());
			
			disciplinas.add(d);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return disciplinas;
	}

	public String escolheDisciplina(List<MatriculaDisciplina> mdList) throws SQLException, ClassNotFoundException 
	{
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_matricula_disciplina (?, ?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		for(MatriculaDisciplina md : mdList)
		{
			cs.setString(1, md.getIdMatricula());
			cs.setString(2, md.getCodigoDisciplina());
			cs.setString(3, md.getStatus());
			cs.registerOutParameter(4, Types.VARCHAR);
			cs.execute();
		}
		String saida = cs.getString(4);
		
		cs.close();
		c.close();
		
		return saida;
		
	}

}
