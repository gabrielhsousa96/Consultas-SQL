﻿
SELECT 
  TMOV.DATACRIACAO,
  TMOV.IDMOV, 
  TMOV.NUMEROMOV, 
  TMOV.CODCOLIGADA,
  TMOV.IDPRJ,
  TITMMOV.IDTRF,
  LEFT (FCFO.NOME,60) AS NOME,
  MAX (CAST(coalesce(TMOV.VALORLIQUIDOORIG, 0) as decimal(15,2))) AS VALORBRUTO
FROM TMOV
INNER JOIN TITMMOV (NOLOCK) ON (TMOV.IDMOV = TITMMOV.IDMOV AND TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA)
INNER JOIN FCFO (NOLOCK) ON (TMOV.CODCFO = FCFO.CODCFO AND TMOV.CODCOLCFO = FCFO.CODCOLIGADA)
WHERE TMOV.CODCOLIGADA = 37
AND     TMOV.IDPRJ = 1
AND     TMOV.DATAEMISSAO >= '2012-08-01'
AND     TITMMOV.IDTRF =56
AND    TMOV.STATUS <> 'C'
AND     TMOV.CODTMV LIKE '1.1.%'
/*RETIRADO OS MOVIMENTOS 1.1.40 E 1.1.41 NO DIA 02/04/2024, POIS O DESCONTO NÃO ESTAVA APARECENDO NA MEDIÇÃO*/
AND     TMOV.CODTMV NOT IN ('1.1.21', '1.1.20', '1.1.25', '1.1.26', '1.1.34', '1.1.35','1.1.06','1.1.07')/*,'1.1.40','1.1.41')*/
GROUP BY TMOV.DATACRIACAO, TMOV.IDMOV, TMOV.NUMEROMOV, FCFO.NOME,TMOV.CODCOLIGADA ,TMOV.IDPRJ,TITMMOV.IDTRF

ORDER BY 1

