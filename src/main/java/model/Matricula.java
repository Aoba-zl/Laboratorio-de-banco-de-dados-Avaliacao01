package model;

import java.time.LocalDate;
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
public class Matricula 
{
	private int id;
	private String raAluno;
	private int codigoCurso;
	private String semestre;
	private String semestreIngresso;
	private LocalDate anoLimiteGraduacao;
	private LocalDate anoIngresso;
	private List<MatriculaDisciplina> md = new ArrayList<>();
}
