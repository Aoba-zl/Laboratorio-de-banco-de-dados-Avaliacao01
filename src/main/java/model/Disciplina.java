package model;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Disciplina 
{
	private int codigo;
	private int codigoCurso;
	private String nome;
	private int qntdHoraSemanais;
	private String diaAula;
	private LocalTime horarioInicio;
	private LocalTime horarioFim;
	private List<Conteudo> conteudo;
	private List<MatriculaDisciplina> matriculaDisciplina;
	
//	public MatriculaDisciplina 
	
	public void setUmMatriculaDisciplina (MatriculaDisciplina md)
	{
		this.matriculaDisciplina = new ArrayList<>();
		this.matriculaDisciplina.add(md);
	}
	
	public MatriculaDisciplina getUmMatriculaDisciplina()
	{
		MatriculaDisciplina md = new MatriculaDisciplina();
		md = this.matriculaDisciplina.get(0);
		
		return md;
	}
	
}
