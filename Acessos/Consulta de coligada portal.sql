SELECT 
CONVERT (VARCHAR,GCOLIGADA.CODCOLIGADA) + ' - ' +  GCOLIGADA.NOME AS 'NOME_COLIGADA', 
CODCOLIGADA FROM GCOLIGADA WHERE CODCOLIGADA IN (SELECT XEMPREENDIMENTO.CODCOLIGADA FROM XEMPREENDIMENTO)