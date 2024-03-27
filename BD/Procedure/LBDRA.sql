USE matricula

DROP PROCEDURE sp_ra_aluno

DROP PROCEDURE sp_gera_ra


CREATE PROCEDURE sp_gera_ra (@ra CHAR(9) OUTPUT)
AS
    DECLARE @r VARCHAR (20),
            @semestre INT,
            @data    CHAR (4)
    SET @r = CAST(CAST(RAND()*10 AS INT)AS varchar)+''+CAST(CAST(RAND()*10 AS INT)AS varchar)+''+CAST(CAST(RAND()*10 AS INT)AS varchar)+''+CAST(CAST(RAND()*10 AS INT)AS varchar)
    SET @data = SUBSTRING(CAST(GETDATE() as varchar),8,4)
    IF (MONTH(GETDATE()) <= 6)
        BEGIN
            SET @semestre = 1
        END
    ELSE
        BEGIN
            SET @semestre = 2
        END
    SET @ra = @data+''+CAST(@semestre as varchar)+''+@r

-- Verifica de RA
CREATE PROCEDURE sp_ra_aluno @ra CHAR(9) OUTPUT
AS
	    EXEC sp_gera_ra @ra OUTPUT
	WHILE EXISTS (SELECT * FROM aluno WHERE aluno.ra = @ra) 
	BEGIN
	    EXEC sp_gera_ra @ra OUTPUT
	END
    
DECLARE @out CHAR(9)
EXEC sp_ra_aluno @out OUTPUT 
PRINT @out
    