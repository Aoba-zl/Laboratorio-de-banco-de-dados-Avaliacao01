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

public class DisciplinaController 
{
	public List<Disciplina> buscarAlunoDisciplina(String ra) throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> d = dDao.consultarAlunoDisciplina(ra);
		return d;
	}

	public List<Disciplina> listar() throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> disciplinas = dDao.listar();
		
		return disciplinas;
	}
	
	public String escolheDisciplina(List<MatriculaDisciplina> mdList) throws SQLException, ClassNotFoundException 
	{
		
		
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		String saida = dDao.escolheDisciplina(mdList);
		
		return saida;
	}
	
	public boolean verificaHorario(List<Disciplina> dList, String[] cod)
	{
		Map<String, List<Pair<LocalTime, LocalTime>>> mapDisciplinaListCheck = new HashMap<>();
		
		List<Disciplina> disciplinas = new ArrayList<>(dList);
		
		Collections.sort(disciplinas, (horario1, horario2) -> horario1.getHorarioInicio().compareTo(horario2.getHorarioInicio()));
		
		for(Disciplina d : disciplinas)
		{
			for(String c : cod)
			{
				if(d.getCodigo() == Integer.parseInt(c))
				{
					Pair<LocalTime, LocalTime> lt = Pair.of(d.getHorarioInicio(), d.getHorarioFim());
					mapDisciplinaListCheck.computeIfAbsent(d.getDiaAula(), k -> new ArrayList<>()).add(lt);
					break;
				}
			}
		}
		
		List<Entry<String, List<Pair<LocalTime, LocalTime>>>> set = mapDisciplinaListCheck.entrySet().stream().toList();
		
		for (Entry<String, List<Pair<LocalTime, LocalTime>>> s : set) 
		{
			List<Pair<LocalTime, LocalTime>> values = s.getValue();
			int len = values.size();
			for (int i = 1; i < len; i++) 
			{
				if (values.get(i - 1).getRight().isAfter(values.get(i).getLeft()))
				{
					return true;
				}
			}
		}
		
		return false;
	}
	
	public boolean validar(String v)
	{
		if(v.strip().equals(""))
			return true;
		
		return false;
	}
}
