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
		String saida;
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		saida = aDao.iud("I", aluno,curso);
		return saida;
	}
	public String alterar(Aluno aluno,Curso curso) throws SQLException, ClassNotFoundException {
		String saida;
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		saida = aDao.iud("U", aluno,curso);
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
}
