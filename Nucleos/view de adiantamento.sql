
SELECT
FCFO.CODCFO,
FCFO.NOMEFANTASIA,
FTB4.DESCRICAO,
FLAN.CODCCUSTO,
FLAN.CODCOLIGADA,
RIGHT (FLAN.NUMERODOCUMENTO,9) AS NUMEROMOV,
FLAN.VALORORIGINAL - ISNULL(SUM (FRELLAN.VALORVINCULO),0) AS VALORORIGINAL,
FLAN.DATAEMISSAO

FROM FLAN (NOLOCK)
LEFT JOIN FRELLAN (NOLOCK) ON (FLAN.IDLAN = FRELLAN.IDLANREL AND FLAN.CODCOLIGADA = FRELLAN.CODCOLIGADA AND FRELLAN.TIPOREL = 28)
LEFT JOIN FCFO (NOLOCK) ON (FCFO.CODCOLIGADA = FLAN.CODCOLCFO AND FCFO.CODCFO = FLAN.CODCFO)
LEFT JOIN FTB4 (NOLOCK) ON (FLAN.CODTB4FLX = FTB4.CODTB4FLX AND FLAN.CODCOLIGADA = FTB4.CODCOLIGADA)

where FLAN.CODTB2FLX IN ('124', '02.125')
AND	  FLAN.CODTDO = '0044'
AND FLAN.VALORORIGINAL - ISNULL(FRELLAN.VALORVINCULO,0) > 0
AND FLAN.STATUSLAN IN (0,3,4)
/*Condi��o retirada a pedido de carlos eduardo dia 18/10/19 atraves do chamado agilis 596980
AND FTB4.DESCRICAO NOT LIKE '%medi��o%' */
AND FCFO.CODCFO ='F42521'
AND FLAN.CODCCUSTO = '3.0073.09'
AND FLAN.CODCOLIGADA =  1

GROUP BY
FCFO.CODCFO,
FCFO.NOMEFANTASIA,
FTB4.DESCRICAO,
FLAN.CODCCUSTO,
FLAN.CODCOLIGADA,
FLAN.NUMERODOCUMENTO,
FLAN.VALORORIGINAL,
FLAN.DATAEMISSAO
HAVING FLAN.VALORORIGINAL - ISNULL(SUM (FRELLAN.VALORVINCULO),0) > 0




SELECT
FCFO.CODCFO,
FCFO.NOMEFANTASIA,
FTB4.DESCRICAO,
FLAN.CODCCUSTO,
FLAN.CODCOLIGADA,
RIGHT (FLAN.NUMERODOCUMENTO,9) AS NUMEROMOV,
FLAN.VALORORIGINAL - ISNULL(SUM (FRELLAN.VALORVINCULO),0) AS VALORORIGINAL,
FLAN.DATAEMISSAO

FROM FLAN (NOLOCK)
LEFT JOIN FRELLAN (NOLOCK) ON (FLAN.IDLAN = FRELLAN.IDLANREL AND FLAN.CODCOLIGADA = FRELLAN.CODCOLIGADA AND FRELLAN.TIPOREL = 28)
LEFT JOIN FCFO (NOLOCK) ON (FCFO.CODCOLIGADA = FLAN.CODCOLCFO AND FCFO.CODCFO = FLAN.CODCFO)
LEFT JOIN FTB4 (NOLOCK) ON (FLAN.CODTB4FLX = FTB4.CODTB4FLX AND FLAN.CODCOLIGADA = FTB4.CODCOLIGADA)

where 
/*FLAN.CODTB2FLX IN ('124', '02.125')
AND	  FLAN.CODTDO = '0044'
AND FLAN.VALORORIGINAL - ISNULL(FRELLAN.VALORVINCULO,0) > 0
--AND FLAN.STATUSLAN IN (0,3,4)
/*Condi��o retirada a pedido de carlos eduardo dia 18/10/19 atraves do chamado agilis 596980
AND FTB4.DESCRICAO NOT LIKE '%medi��o%' */*/
--AND 
FCFO.CODCFO ='F42521'
AND FLAN.CODCCUSTO = '3.0073.09'
AND FLAN.CODCOLIGADA =  1
and NUMERODOCUMENTO like '%4205'


GROUP BY
FCFO.CODCFO,
FCFO.NOMEFANTASIA,
FTB4.DESCRICAO,
FLAN.CODCCUSTO,
FLAN.CODCOLIGADA,
FLAN.NUMERODOCUMENTO,
FLAN.VALORORIGINAL,
FLAN.DATAEMISSAO
HAVING FLAN.VALORORIGINAL - ISNULL(SUM (FRELLAN.VALORVINCULO),0) > 0