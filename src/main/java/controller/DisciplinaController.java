package controller;

import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.tomcat.jakartaee.commons.lang3.tuple.Pair;

import model.Disciplina;
import model.MatriculaDisciplina;
import persistence.GenericDao;
import persistence.DisciplinaDao;

/**
 * Essa Classe é responsável por ser o controlador dos dados da entidade Disciplina.
 */
public class DisciplinaController 
{
	/**
	 * Método responsável por buscar as disciplina do aluno atráves do RA dele.
	 * 
	 * @param ra Uma String que contém o RA do aluno
	 * @return Uma lista de objeto do tipo disciplina
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	public List<Disciplina> buscarAlunoDisciplina(String ra) throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> d = dDao.consultarAlunoDisciplina(ra);
		return d;
	}

	/**
	 * Método responsável por criar uma lista de objeto do tipo disciplina.
	 * 
	 * @return Uma lista de objeto do tipo disciplina
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	public List<Disciplina> listar() throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> disciplinas = dDao.listar();
		
		return disciplinas;
	}
	
	/**
	 * Método responsável para escolher as disciplinas obtidas através da checkbox.
	 * 
	 * @param mdList Lista contendo objetos do tipo matricula disciplina
	 * @return Uma String de saida contendo o resultado da chamada da função
	 * @throws SQLException Exceção lançada se houver problema com SQL
	 * @throws ClassNotFoundException Exceção lançada se houver erro ao tentar encontrar a classe
	 */
	public String escolheDisciplina(List<MatriculaDisciplina> mdList) throws SQLException, ClassNotFoundException 
	{
		
		
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		String saida = dDao.escolheDisciplina(mdList);
		
		return saida;
	}
	
	/**
	 * Método responsável por verificar se o horário está de acordo com a disciplina do mesmo dia, sem haver nenhum tipo de divergência.
	 * 
	 * @param dList Lista de objeto do tipo Disciplina
	 * @param cod Uma String que contém o código da disciplina para a verificação de qual disciplina será escolhida
	 * @return True para caso houver uma divergência de horário do mesmo dia, para caso contrário retornara false
	 */
	public boolean verificaHorario(List<Disciplina> dList, String[] cod)
	{
		// Criação de HashMap para a disciplina, contendo uma chave como String e uma List de Pair que contém os horários inicial.
		Map<String, List<Pair<LocalTime, LocalTime>>> mapDisciplinaListCheck = new HashMap<>();
		
		// Uma cópia de disciplina para não alterar a disciplina do sistema, por estar uma sessão do usuário.
		List<Disciplina> disciplinas = new ArrayList<>(dList);
		
		// Sort utilizado para organizar o horárioInicio do menor pro maior.
		Collections.sort(disciplinas, (horario1, horario2) -> horario1.getHorarioInicio().compareTo(horario2.getHorarioInicio()));
		
		// ForEach contendo as disciplinas para colocar no HashMap.
		for(Disciplina d : disciplinas)
		{
			// ForEach contendo o codigo das disciplinas para separar quais disciplinas foram selecionadas.
			for(String c : cod)
			{
				if(d.getCodigo() == Integer.parseInt(c))
				{
					// Pair criado para organizar os dois horários, o horário inicial na esquerda e horario final na direita.
					Pair<LocalTime, LocalTime> lt = Pair.of(d.getHorarioInicio(), d.getHorarioFim());
					// Coloca o dia e os horários dentro do HashMap. (computeIfAbsent é utilizado para ser colocado em uma mesma chave)
					mapDisciplinaListCheck.computeIfAbsent(d.getDiaAula(), k -> new ArrayList<>()).add(lt);
					break;
				}
			}
		}
		
		// Convertendo o HashMap em uma lista, colocando o Entry, transformando as keys que são String em Index.
		List<Entry<String, List<Pair<LocalTime, LocalTime>>>> set = mapDisciplinaListCheck.entrySet().stream().toList();
		
		// ForEach da lista de set contendo as keys(dias) e os horários do dia.
		for (Entry<String, List<Pair<LocalTime, LocalTime>>> s : set) 
		{
			// Lista do horários.
			List<Pair<LocalTime, LocalTime>> values = s.getValue();
			int len = values.size(); // Tamanho da lista.
			// For para a checagem da lista.
			for (int i = 1; i < len; i++) 
			{
				// Checa para ver se o horário final da primeira aula é depois do horário inicial da segunda aula.
				if (values.get(i - 1).getRight().isAfter(values.get(i).getLeft()))
				{
					return true; // True para caso tenha divergência de horário.
				}
			}
		}
		
		return false; // False para caso não tenha divergência de horário.
	}
	
	/**
	 * Método responsável por verificar se a String é vazia.
	 * 
	 * @param v Uma String utilizado para validação
	 * @return True para caso seja vazia, caso contrário retornara false
	 */
	public boolean validar(String v)
	{
		if(v.strip().equals(""))
			return true;
		
		return false;
	}
}
