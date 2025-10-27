ALTER FUNCTION dbo.DiferençaDatas 
(
    @DataInicial DATE,
    @DataFinal DATE
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Anos INT, @Meses INT, @Dias INT;
    DECLARE @Resultado VARCHAR(100);
    SET @Anos = DATEDIFF(YEAR, @DataInicial, @DataFinal);
    IF (MONTH(@DataFinal) < MONTH(@DataInicial)) OR (MONTH(@DataFinal) = MONTH(@DataInicial) AND DAY(@DataFinal) < DAY(@DataInicial))
    BEGIN
        SET @Anos = @Anos - 1;
    END

    SET @Meses = DATEDIFF(MONTH, DATEADD(YEAR, @Anos, @DataInicial), @DataFinal);
    SET @Dias = DATEDIFF(DAY, DATEADD(MONTH, @Meses, DATEADD(YEAR, @Anos, @DataInicial)), @DataFinal);
    SET @Resultado = 'Faltam ' + CAST(@Anos AS VARCHAR(5)) + CASE WHEN @Anos = 1 THEN ' ano, ' ELSE 'anos, ' END
                     + CAST(@Meses AS VARCHAR(5)) + CASE WHEN @Meses = 1 THEN 'MES E ' ELSE ' meses e ' END
                     + CAST(@Dias AS VARCHAR(5)) + CASE WHEN @Dias = 1 THEN 'DIA.' ELSE 'dias.' END;

    RETURN @Resultado;
END


/*
dbo.fn_DiferençaDatas('2023-01-01', '2027-08-01') AS TempoFaltando;
*/