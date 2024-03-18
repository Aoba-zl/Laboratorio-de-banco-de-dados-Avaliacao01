package model;

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
	private int idProfessor;
	private List<Conteudo> conteudo;
}
