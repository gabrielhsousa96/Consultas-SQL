USE [CORPORE_RESIDENCIAL]
GO

/****** Object:  UserDefinedFunction [dbo].[TRAZ_STATUSLAN]    Script Date: 26/04/2024 14:08:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[TRAZ_STATUSLAN](@STATUS INT)
RETURNS VARCHAR (MAX)
AS BEGIN
   
   -- Declarando as variaveis
declare @RESULTADO VARCHAR (MAX)
 
SET @RESULTADO = 
 
(CASE WHEN @STATUS = 0 THEN 'EM ABERTO'
WHEN @STATUS = 1 THEN 'BAIXADO'
WHEN @STATUS = 2 THEN 'CANCELADO'
WHEN @STATUS = 3 THEN 'BAIXADO POR ACORDO'
WHEN @STATUS = 4 THEN 'BAIXADO PARCIALMENTE'
WHEN @STATUS = 5 THEN 'BORDER�'
ELSE CONVERT (VARCHAR(MAX),@STATUS )
END)
	 							

  RETURN @RESULTADO

END


/* CRIADA POR MARCELO SILVA 18-06-2019 */

GO


