package model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// temporário até a confirmação do professor

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Professor extends Funcionario
{
	private String titulacao;
	private String especialidade;
	private List<Disciplina> disciplina;
}
