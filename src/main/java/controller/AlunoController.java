package controller;

import java.sql.SQLException;
import java.util.List;

import model.Aluno;
import model.Curso;
import model.Vestibular;
import persistence.AlunoDao;
import persistence.GenericDao;

public class AlunoController 
{
	public String cadastrar (Aluno aluno,Curso curso) throws SQLException, ClassNotFoundException {
		String saida = checkA(aluno,curso);
		if (saida.contains("correto")) {
			GenericDao gDao = new GenericDao();
			AlunoDao aDao = new AlunoDao(gDao);
			saida = aDao.iud("I", aluno,curso);
		}
		return saida;
	}
	public String alterar(Aluno aluno,Curso curso) throws SQLException, ClassNotFoundException {
		String saida = checkA(aluno);
		if (saida.contains("correto")) {
			GenericDao gDao = new GenericDao();
			AlunoDao aDao = new AlunoDao(gDao);
			saida = aDao.iud("U", aluno,curso);
		}
		return saida;
	}
	public String excluir(Aluno aluno) throws SQLException, ClassNotFoundException {
		String saida;
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		Curso curso = new Curso();
		Vestibular v = new Vestibular();
		v.setPontuacao(0);
		v.setPosicao(0);
		aluno.setVestibular(v);
		saida = aDao.iud("D", aluno,curso);
		return saida;
	}
	public Aluno buscar(Aluno aluno) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		aluno = aDao.consultar(aluno);
		return aluno;
	}
	public List<Aluno> listar(List<Aluno> alunos) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		return alunos = aDao.listar();
	}
	private String checkA(Aluno aluno) {
		if (aluno.getCpf().length() != 11) 	{return "CPF invalido!";}
		if (aluno.getNome().length() > 100 || aluno.getNome() == "") {return "Nome invalido!";}
		if (aluno.getNomeSocial().length() > 100) {return "Nome Social invalido!";}
		if (aluno.getEmailPessoal().length() > 100 || aluno.getEmailPessoal() == "") {return "Email Pessoal invalido!";}
		if (aluno.getEmailCorporativo().length() > 100) {return "Email Corporativo invalido!";}
		if (aluno.getInstituicaoConclusaoSegGrau().length() > 100 || aluno.getInstituicaoConclusaoSegGrau() == "") {return "Nome da Instituição invalido!";}
		if (aluno.getDtNascimento() == null) {return "Data de nascimento invalido!";}
		if (aluno.getDtConclusaoSegGrau() == null) {return "Data de conclusão invalido!";}
		if (aluno.getVestibular().getPontuacao() < 0) {return "Pontuação invalida!";}	
		if (aluno.getVestibular().getPosicao() < 1) {return "Posição invalida!";}
		return "correto";
	}
	private String checkA(Aluno aluno, Curso curso) {
		String saida;
		saida = checkA(aluno);
		if (saida.contains("correto") && curso.getCodigo() == -1) {
			saida = "Curso não selecionado";
		}
		return saida;
	}

}
