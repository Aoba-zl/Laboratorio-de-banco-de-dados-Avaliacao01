USE matricula

DROP PROCEDURE sp_telefone_aluno 

CREATE PROCEDURE sp_telefone_aluno (@op CHAR(1), @ra AS CHAR(9), @numero AS CHAR(9),@num_velho AS CHAR(9), @saida AS VARCHAR(50) OUTPUT) -- mudado
AS
    IF (@op = 'I')
    BEGIN
        IF ((SELECT numero FROM telefone WHERE numero = @numero AND ra_aluno = @ra) IS NULL)
        BEGIN 
            INSERT INTO telefone
            VALUES (@ra, @numero)
            SET @saida = 'cadastrado'
        END
        ELSE
        BEGIN
            SET @saida = 'erro'
        END
    END
    ELSE IF (@op = 'U')
    BEGIN
        IF (EXISTS(SELECT * FROM telefone WHERE ra_aluno = @ra )) BEGIN
            IF(@numero IS NOT NULL OR @num_velho IS NOT NULL) BEGIN
                IF (@numero IS NOT NULL) BEGIN
                    IF(@num_velho IS NOT NULL) BEGIN
                        IF (NOT EXISTS(SELECT * FROM telefone WHERE numero = @numero AND ra_aluno = @ra  )) BEGIN
                            PRINT 'update'
                            UPDATE telefone 
                            SET numero = @numero
                            WHERE ra_aluno = @ra  AND numero = @num_velho
                            SET @saida = 'atualizado'
                        END ELSE BEGIN
                            SET @saida = 'erro'
                        END
                    END ELSE BEGIN
                        EXEC sp_telefone_aluno 'I', @ra, @numero, NULL,@saida OUTPUT
                    END
                END ELSE BEGIN
                    EXEC sp_telefone_aluno 'D', @ra, NULL, @num_velho,@saida OUTPUT
                END
            END ELSE BEGIN
                SET @saida = 'erro'
            END
        END
    END
    ELSE IF (@op = 'D')
    BEGIN
        IF (@num_velho IS NULL) BEGIN
            DELETE telefone WHERE ra_aluno = @ra
        END
        ELSE BEGIN
            DELETE telefone WHERE ra_aluno = @ra AND numero = @num_velho
            SET @saida = 'excluido'
        END
    END