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
public class Curso 
{
	private int codigo;
	private String nome;
	private int cargaHoraria;
	private String sigla;
	private float notaEnade;
	private List<Matricula> matricula;
	private List<Disciplina> disciplina;
}
