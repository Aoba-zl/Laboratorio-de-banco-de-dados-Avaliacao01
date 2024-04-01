package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import model.Aluno;
import model.Curso;
import model.Telefone;
import model.Vestibular;

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
		Connection connection = gDao.getConnection();
		String querySql = """ 
		SELECT 
		a.ra, 
		a.cpf, 
		a.nome, 
		a.nome_social, 
		a.dt_nascimento, 
		a.email_pessoal, 
		a.email_corporativo, 
		a.dt_conclusao_seg_grau, 
		a.instituicao_conclusao_seg_grau,
		t.numero,
		v.pontuacao,
		v.posicao 
		FROM aluno a, telefone t, vestibular v
		WHERE a.ra = t.ra_aluno AND a.ra = v.ra_aluno AND a.ra = ?
				""";
		PreparedStatement preparedStatement = connection.prepareStatement(querySql);
		preparedStatement.setString(1, a.getRa());
		ResultSet result = preparedStatement.executeQuery();

		if (result.next()) {
			a.setCpf(result.getString("cpf"));
			a.setNome(result.getString("nome"));
			a.setNomeSocial(result.getString("nome_social"));
			a.setDtNascimento(toLocalDate(result.getDate("dt_nascimento")));
			a.setEmailPessoal(result.getString("email_pessoal"));
			a.setEmailCorporativo(result.getString("email_corporativo"));
			a.setDtConclusaoSegGrau(toLocalDate(result.getDate("dt_conclusao_seg_grau")));
			a.setInstituicaoConclusaoSegGrau(result.getString("instituicao_conclusao_seg_grau"));
			Vestibular v = new Vestibular();
			v.setPontuacao(result.getFloat("pontuacao"));
			v.setPosicao(result.getInt("posicao"));
			a.setVestibular(v);
			List<Telefone> telefones = new ArrayList<>();
			Telefone t = new Telefone(result.getString("numero"));
			telefones.add(t);
			for(int J=0;J<3;J++) {
				Telefone telefone = new Telefone();
				if (result.next()) {
					telefone.setNumero(result.getString("numero"));
				} else {
					telefone.setNumero("");
				}
				telefones.add(telefone);
			}
			a.setTelefone(telefones);
		} else {
			
		}
		preparedStatement.close();
		connection.close();
		return a;
	}

	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException 
	{
		Connection connection = gDao.getConnection();
		String querySql = """ 
				SELECT 
				a.ra, 
				a.cpf, 
				a.nome, 
				a.nome_social, 
				a.dt_nascimento, 
				a.email_pessoal, 
				a.dt_conclusao_seg_grau, 
				a.instituicao_conclusao_seg_grau,
				v.pontuacao,
				v.posicao 
				FROM aluno a,vestibular v
				WHERE a.ra = v.ra_aluno
				""";
		PreparedStatement preparedStatement = connection.prepareStatement(querySql);
		ResultSet result = preparedStatement.executeQuery();
		List<Aluno> alunos = new ArrayList<>();
		while (result.next()) {
			Aluno a = new Aluno();
			a.setRa(result.getString("ra"));
			a.setCpf(result.getString("cpf"));
			a.setNome(result.getString("nome"));
			a.setDtNascimento(toLocalDate(result.getDate("dt_nascimento")));
			a.setEmailPessoal(result.getString("email_pessoal"));
			a.setInstituicaoConclusaoSegGrau(result.getString("instituicao_conclusao_seg_grau"));
			a.setDtConclusaoSegGrau(toLocalDate(result.getDate("dt_conclusao_seg_grau")));
			Vestibular v = new Vestibular();
			v.setPontuacao(result.getFloat("pontuacao"));
			v.setPosicao(result.getInt("posicao"));
			a.setVestibular(v);
			alunos.add(a);
		}
		return alunos;
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
		cs.setString(10,aluno.getInstituicaoConclusaoSegGrau());
		cs.setFloat(11, aluno.getVestibular().getPontuacao());
		cs.setInt(12, aluno.getVestibular().getPosicao());
		cs.setInt(13, curso.getCodigo());
		cs.registerOutParameter(14, Types.VARCHAR);
		cs.registerOutParameter(15, Types.VARCHAR);
        cs.execute();
        String saida = cs.getString(14);
        String ra = cs.getString(15);
        cs.close();
        
        if(saida.contains("Aluno cadastrado")) {
	        querySql = "EXEC sp_telefone_aluno ?,?,?,NULL,?";
	        cs = connection.prepareCall(querySql);
	        for (Telefone t : aluno.getTelefone()) {
	        	cs = connection.prepareCall(querySql); 
		        cs.setString(1, acao);
		        cs.setString(2, ra);
		        String numero = t.getNumero();
		        cs.setString(3, numero);
		        cs.registerOutParameter(4, Types.VARCHAR);
		        cs.execute();
	        }
	        cs.close();
	        connection.close();
        }
        if (saida.contains("Aluno atualizado")) {
        	updateTel(aluno);
        }
		return saida;
	}
	private void updateTel(Aluno aluno) throws ClassNotFoundException, SQLException {
		Connection connection = gDao.getConnection();
		String querySql = "SELECT * FROM telefone WHERE ra_aluno = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(querySql);
		preparedStatement.setString(1, aluno.getRa());
		ResultSet result = preparedStatement.executeQuery();
		List<Telefone> chave = new ArrayList<>();
		while(result.next()) {
			Telefone tel = new Telefone(result.getString("numero"));
			chave.add(tel);
		}
		preparedStatement.close();

		String saida = "";
        int max = aluno.getTelefone().size();
        if (chave.size() > max) {
            max = chave.size();
        }
        int cont = 0;
        while(cont != max) {
        	cont = 0;
            for (int J=0;J<max;J++) {
            	String numeroAtual = aluno.getTelefone().get(J).getNumero();
	            querySql = "EXEC sp_telefone_aluno ?,?,?,?,?";
	            CallableStatement cs = connection.prepareCall(querySql);
	            cs.setString(1, "U");
	            cs.setString(2, aluno.getRa());
	            if (J+1 > aluno.getTelefone().size() || numeroAtual == "" ) {
	                cs.setString(3, null);
	                numeroAtual = null;
	            }else {
	                cs.setString(3, numeroAtual);
	            }
	            if (J+1 > chave.size()) {
	                cs.setString(4, null);
	            }else {
	                cs.setString(4, chave.get(J).getNumero());
	            }
	            cs.registerOutParameter(5, Types.VARCHAR);
		        cs.execute();
		        saida = cs.getString(5);
                switch (saida) {
                case "cadastrado" : chave.add(aluno.getTelefone().get(J)) ;
                break;
                case "excluido" : chave.remove(J);
                				  aluno.getTelefone().remove(J);
                                  max--;
                break;
                case "erro" : cont++;
                break;
                }
            }
        }
	}
	
	private java.sql.Date toSQLDate(LocalDate data){
		if (data != null) {
			java.sql.Date sqlDate = java.sql.Date.valueOf(data);
			return sqlDate;
		}
		return null;
	}
	private LocalDate toLocalDate (Date date) {
        return Optional.ofNullable(date).map(Date::toLocalDate).orElse(null);
		
	}
}
