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
	public void cadastrar (Aluno aluno,Curso curso) throws SQLException, ClassNotFoundException {
			GenericDao gDao = new GenericDao();
			AlunoDao aDao = new AlunoDao(gDao);
			aDao.iud("I", aluno,curso);
	}
	public void alterar(Aluno aluno,Curso curso) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		aDao.iud("U", aluno,curso);
	}
	public void excluir(Aluno aluno) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		Curso curso = new Curso();
		Vestibular v = new Vestibular();
		v.setPontuacao(0);
		v.setPosicao(0);
		aluno.setVestibular(v);
		aDao.iud("D", aluno,curso);
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
