package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.List;

import model.Aluno;
import model.Curso;

public class AlunoDao implements ICrudDao<Aluno>, ICrudIud<Aluno,Curso>
{
	private GenericDao gDao;
	
	public AlunoDao(GenericDao gDao)
	{	
		this.gDao = gDao;
	}
	
	@Override
	public Aluno consultar(Aluno a) throws SQLException, ClassNotFoundException 
	{
		return null;
	}

	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException 
	{
		return null;
	}

	@Override
	public String iud(String acao, Aluno aluno, Curso curso) throws SQLException, ClassNotFoundException 
	{
		Connection connection = gDao.getConnection();
		String querySql = "EXEC sp_iud_aluno ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
		CallableStatement cs = connection.prepareCall(querySql);
		cs.setString(1, acao);
		cs.setString(2, aluno.getRa());
		cs.setString(3,aluno.getCpf());
		cs.setString(4,aluno.getNome());
		cs.setString(5,aluno.getNomeSocial());
		cs.setDate(6,toSQLDate(aluno.getDtNascimento()));
		cs.setString(7,aluno.getEmailPessoal());	
		cs.setString(8,aluno.getEmailCorporativo());
		cs.setDate(9,toSQLDate(aluno.getDtConclusaoSegGrau()));
		cs.setString(10,aluno.getInstuicaoConclusaoSegGrau());
		cs.setFloat(11, aluno.getVestibular().getPontuacao());
		cs.setInt(12, aluno.getVestibular().getPosicao());
		cs.setInt(13, curso.getCodigo());
		cs.registerOutParameter(14, Types.VARCHAR);
		cs.registerOutParameter(15, Types.VARCHAR);
        cs.execute();
        String saida = cs.getString(14);
        String ra = cs.getString(15);
        cs.close();
        
        if(saida.contains("Aluno cadastrado") ) {
	        querySql = "EXEC sp_telefone_aluno ?,?,?,?,?";
	        cs = connection.prepareCall(querySql);
	        for (int J=1; J <=3;J++) {	
	        	cs = connection.prepareCall(querySql); 
		        cs.setString(1, acao);
		        cs.setString(2, ra);
		        cs.setString(3, aluno.getTelefone().get(J-1).getNumero());
		        cs.setInt(4, J);
		        cs.registerOutParameter(5, Types.VARCHAR);
		        cs.execute();
		        if (saida == null) {
		        	saida = cs.getString(5);
		        }
	        }
	        cs.close();
	        
	        connection.close();
        }
		return saida;
	}

	private java.sql.Date toSQLDate(LocalDate data){
		if (data != null) {
			java.sql.Date sqlDate = java.sql.Date.valueOf(data);
			return sqlDate;
		}
		return null;
	}
}
