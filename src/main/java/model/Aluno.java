package model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
	private String instituicaoConclusaoSegGrau;
	private List<Telefone> telefone; // = new ArrayList<>(); TODO
	private Vestibular vestibular; // = new Vestibular(); TODO
	
	public String getDtNascimentoFormat()
    {
        DateTimeFormatter formatacao = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return this.dtNascimento.format(formatacao);
    }

    public String getDtConclusaoSegGrauFormat()
    {
        DateTimeFormatter formatacao = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return this.dtConclusaoSegGrau.format(formatacao);
    }
}
