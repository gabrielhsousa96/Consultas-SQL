select T.IDPRD, 
T.CODIGOPRD, 
T.NOMEFANTASIA, 
SUM(ISNULL(T.ENTRADA,0)) AS ENTRADA, 
SUM(ISNULL(T.SAIDA,0)) - SUM(ISNULL(T.ENTRADA2,0))AS SAIDA, 
 T.CODUNDCONTROLE,
SUM(ISNULL(T.ENTRADA,0)) -SUM(ISNULL(T.SAIDA,0)) AS DIFERENCA,
TAB_PRECO_MEDIO.PRECO_MEDIO,
SUM (CASE WHEN CODTMV IN ('2.2.05') THEN T.ENTRADA *-1  ELSE 0 END) AS ESTORNO
/*PRECO MEDIO */


 from 
(select 
TPRD.IDPRD,
TPRD.CODIGOPRD, 
TPRD.NOMEFANTASIA, 
TMOV.CODTMV,
	(CASE WHEN TITMMOV.CODUND = TPRD.CODUNDCONTROLE 
     THEN  (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  
     ELSE ( (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  * 
	 (SELECT FATORCONVERSAO FROM TUND (NOLOCK) WHERE TUND.CODUND = TITMMOV.CODUND)) 
     / (SELECT FATORCONVERSAO FROM TUND (NOLOCK) WHERE TUND.CODUND = TPRD.CODUNDCONTROLE)
     END) AS ENTRADA,
0 AS SAIDA,
TPRD.CODUNDCONTROLE,
(CASE WHEN TMOV.CODTMV = '3.1.28' THEN TMOV.CODLOCDESTINO  ELSE TMOV.CODLOC END) AS CODLOC,
0 AS ENTRADA2

FROM TITMMOV (NOLOCK) 

INNER JOIN TMOV (NOLOCK) ON TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA AND TMOV.IDMOV = TITMMOV.IDMOV
INNER JOIN TPRD (NOLOCK) ON TPRD.CODCOLIGADA = TMOV.CODCOLIGADA AND TPRD.IDPRD = TITMMOV.IDPRD

WHERE 
TMOV.CODCOLIGADA = @P_CODCOLIGADA
AND TMOV.STATUS <> 'C'
AND (TITMMOV.QUANTIDADE<>0	OR TITMMOV.QUANTIDADETOTAL<>0)
AND TMOV.CODTMV IN ('2.2.05','1.1.40','1.1.41','4.1.01','4.1.04' ,'3.1.28')
AND (CASE WHEN TMOV.CODTMV = '3.1.28' THEN TMOV.CODLOCDESTINO ELSE TMOV.CODLOC END) BETWEEN @CODLOCINICIAL_S AND @CODLOCFINAL_S 
AND (CASE WHEN TMOV.CODTMV = '3.1.28' THEN TMOV.CODFILIALDESTINO ELSE TMOV.CODFILIAL END) = @CODFILIAL
AND TPRD.CODIGOPRD >= @PRODUTOINICIAL AND TPRD.CODIGOPRD <= @PRODUTOFINAL 
AND (CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) >= @DATAINICIAL_D 
AND (CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) <= @DATAFINAL_D


UNION ALL

SELECT 
TPRD.IDPRD,
TPRD.CODIGOPRD,
TPRD.NOMEFANTASIA,
TMOV.CODTMV,
0 AS ENTRADA,
	(CASE WHEN TITMMOV.CODUND = TPRD.CODUNDCONTROLE 
     THEN  (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  
     ELSE ( (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  
     * 
     (SELECT FATORCONVERSAO FROM TUND (NOLOCK) WHERE TUND.CODUND = TITMMOV.CODUND))
     / (SELECT FATORCONVERSAO FROM TUND (NOLOCK) WHERE TUND.CODUND = TPRD.CODUNDCONTROLE)
     END) AS SAIDA,
TPRD.CODUNDCONTROLE,
TMOV.CODLOC,
TMOV.CODLOC,
0 AS ENTRADA2

FROM TITMMOV (NOLOCK) 
INNER JOIN TMOV (NOLOCK) ON TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA AND TMOV.IDMOV = TITMMOV.IDMOV
INNER JOIN TPRD (NOLOCK) ON TPRD.CODCOLIGADA = TMOV.CODCOLIGADA AND TPRD.IDPRD = TITMMOV.IDPRD

WHERE 
TMOV.CODCOLIGADA = @P_CODCOLIGADA
AND TMOV.CODFILIAL = @CODFILIAL /* ADICIONADO POR LUIZ VIANA */
AND TMOV.STATUS <> 'C' 
AND (TITMMOV.QUANTIDADE<>0 OR TITMMOV.QUANTIDADETOTAL<>0)
AND TMOV.CODTMV IN  ('1.1.27','1.1.33','3.1.28','3.1.36','3.1.39','2.1.01','4.1.06','4.1.05') AND TMOV.CODLOC >= @CODLOCINICIAL_S AND TMOV.CODLOC <= @CODLOCFINAL_S 
AND TPRD.CODIGOPRD >= @PRODUTOINICIAL 
AND TPRD.CODIGOPRD <= @PRODUTOFINAL 
AND (CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) >= @DATAINICIAL_D 
AND (CASE WHEN CONVERT(DATE,TMOV.DATACRIACAO) IS NULL THEN CONVERT(DATE,TMOV.DATACRIACAO) ELSE  CONVERT(DATE,TMOV.DATACRIACAO) END) <= @DATAFINAL_D

UNION ALL

SELECT 
TPRD.IDPRD, 
TPRD.CODIGOPRD,
TPRD.NOMEFANTASIA, 
TMOV.CODTMV,
0 AS ENTRADA, 
0 AS SAIDA,
TPRD.CODUNDCONTROLE,
TMOV.CODLOC,
	(CASE WHEN TITMMOV.CODUND = TPRD.CODUNDCONTROLE 
     THEN  (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  
     ELSE ( (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) 
     *
     (SELECT FATORCONVERSAO FROM TUND (NOLOCK) WHERE TUND.CODUND = TITMMOV.CODUND))
     / (SELECT FATORCONVERSAO FROM TUND (NOLOCK) WHERE TUND.CODUND = TPRD.CODUNDCONTROLE)
     END) AS ENTRADA2

FROM TITMMOV (NOLOCK) 
INNER JOIN TMOV (NOLOCK) ON TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA AND TMOV.IDMOV = TITMMOV.IDMOV
INNER JOIN TPRD (NOLOCK) ON TPRD.CODCOLIGADA = TMOV.CODCOLIGADA AND TPRD.IDPRD = TITMMOV.IDPRD

WHERE 
TMOV.CODCOLIGADA = @P_CODCOLIGADA
AND TMOV.CODFILIAL = @CODFILIAL /* ADICIONADO POR LUIZ VIANA */
AND TMOV.STATUS <> 'C' 
AND (TITMMOV.QUANTIDADE<>0 OR TITMMOV.QUANTIDADETOTAL<>0)
AND TMOV.CODTMV IN (
	SELECT  TTMV.CODTMV 
	FROM TTMV (NOLOCK) 
	INNER JOIN TITMTMV (NOLOCK) on TTMV.CODTMV = TITMTMV.CODTMV AND TTMV.CODCOLIGADA = TITMTMV.CODCOLIGADA
	AND TITMTMV.codtmv ='4.1.03')

AND TMOV.CODLOC >= @CODLOCINICIAL_S 
AND TMOV.CODLOC <= @CODLOCFINAL_S 
AND TPRD.CODIGOPRD >= /*:PRODUTOINICIAL*/'MLIM.001.001.0092' 
AND TPRD.CODIGOPRD <= @PRODUTOFINAL 
AND (CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) >= @DATAINICIAL_D 
AND (CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) <= @DATAFINAL_D) 
AS T

LEFT JOIN(SELECT * FROM DBO.TABELA_PRECO_MEDIO(@P_CODCOLIGADA, @DATAINICIAL_D, @DATAFINAL_D, @CODLOCINICIAL_S, @CODLOCFINAL_S)) AS TAB_PRECO_MEDIO ON (TAB_PRECO_MEDIO.IDPRD = T.IDPRD AND TAB_PRECO_MEDIO.CODCOLIGADA = @P_CODCOLIGADA)

GROUP BY
T.IDPRD, 
T.CODIGOPRD, 
T.NOMEFANTASIA,
T.CODUNDCONTROLE,
TAB_PRECO_MEDIO.PRECO_MEDIO

ORDER BY T.NOMEFANTASIA
  