package model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//temporário até a confirmação do professor

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Funcionario 
{
	private int id;
	private String nome;
	private String cpf;
	private String cargo;
}
