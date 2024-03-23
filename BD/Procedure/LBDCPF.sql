USE matricula

DROP PROCEDURE sp_verifica_cpf

CREATE PROCEDURE sp_verifica_cpf 
(
	@cpf CHAR(11), 
	@cpf_valido INT OUTPUT
)
AS
	DECLARE @cpf_num_iguais CHAR(11),
			@cpf_count INT = 10,
			@cpf_soma INT = 0,
			@cpf_unidade INT = 1,
			@cpf_ult_digito VARCHAR(2) = ''
	SET @cpf_num_iguais = CONCAT(SUBSTRING(@cpf, 1, 1), REPLACE(@cpf, SUBSTRING(@cpf, 1, 1), ''))
	IF (LEN(@cpf_num_iguais) != 1)
	BEGIN
		WHILE (@cpf_count >= 2)
		BEGIN
			SET @cpf_soma = @cpf_soma + (@cpf_count * CAST(SUBSTRING(@cpf, @cpf_unidade, 1) AS INT))
			SET @cpf_count = @cpf_count - 1
			SET @cpf_unidade = @cpf_unidade + 1
		END
		IF (@cpf_soma % 11 = 1 OR @cpf_soma % 11 = 0)
		BEGIN 
			SET @cpf_ult_digito = CONCAT(@cpf_ult_digito, '0')
		END
		ELSE 
		BEGIN 
			SET @cpf_ult_digito = CONCAT(@cpf_ult_digito, CAST((11 - (@cpf_soma % 11)) AS VARCHAR))
		END
		SET @cpf_count = 11
		SET @cpf_soma = 0
		SET @cpf_unidade = 1
		WHILE (@cpf_count >= 2)
		BEGIN
			IF (@cpf_unidade <= 9)
			BEGIN 
				SET @cpf_soma = @cpf_soma + (@cpf_count * CAST(SUBSTRING(@cpf, @cpf_unidade, 1) AS INT))
			END
			ELSE 
			BEGIN 
				SET @cpf_soma = @cpf_soma + (@cpf_count * CAST(@cpf_ult_digito AS INT))
			END
			SET @cpf_count = @cpf_count - 1
			SET @cpf_unidade = @cpf_unidade + 1
		END
		IF (@cpf_soma % 11 = 1 OR @cpf_soma % 11 = 0)
		BEGIN 
			SET @cpf_ult_digito = CONCAT(@cpf_ult_digito, '0')
		END
		ELSE 
		BEGIN 
			SET @cpf_ult_digito = CONCAT(@cpf_ult_digito, CAST((11 - (@cpf_soma % 11)) AS VARCHAR))
		END
		IF (SUBSTRING(@cpf, 10, 2) = @cpf_ult_digito)
		BEGIN 
			SET @cpf_valido = 0 --cpf valido
		END
		ELSE 
		BEGIN 
			SET @cpf_valido = 1 --cpf invalido
		END
	END
	ELSE
	BEGIN
		SET @cpf_valido = 2 --cpf não pode com numeros iguais
	END