package model;

import java.time.LocalDate;
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
public class Aluno 
{
	private String ra;
	private String cpf;
	private String Nome;
	private String nomeSocial;
	private LocalDate dtNascimento;
	private String emailPessoal;
	private String emailCorporativo;
	private LocalDate dtConclusaoSegGrau;
	private String instuicaoConclusaoSegGrau;
	private List<Telefone> telefone;
	private Vestibular vestibular;
}
