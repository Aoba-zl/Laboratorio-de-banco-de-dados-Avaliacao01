package model;

import java.time.LocalTime;
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
public class Curso 
{
	private int codigo;
	private String nome;
	private LocalTime carga_horaria;
	private String sigla;
	private float ult_nota_participacao_enade;
	private List<Matricula> matricula;
	private List<Disciplina> disciplina;
}
