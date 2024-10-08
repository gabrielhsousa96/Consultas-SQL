select 
	T.IDPRD, 
	T.CODIGOPRD, 
	T.NOMEFANTASIA, 
	SUM(ISNULL(T.ENTRADA,0)) AS ENTRADA, 
	(SUM(ISNULL(T.SAIDA,0)) - SUM(ISNULL(T.ENTRADA2,0)))AS SAIDA, 
	T.CODUNDCONTROLE,
	(SUM(ISNULL(T.ENTRADA,0)) -SUM(ISNULL(T.SAIDA,0)) )AS DIFERENCA,

/* PRECO MEDIO */


(SELECT CAST(SUM(T.VAL)/CASE WHEN SUM(T.QUANTIDADE) = '0' THEN '0.01' ELSE SUM(T.QUANTIDADE)END AS DECIMAL (10,2)) AS CUSTOMEDIODEENTRADA
       FROM (
       
       
       
SELECT  TPRD.CODIGOPRD , TMOV.IDMOV,
        TPRD.NOMEFANTASIA ,
        TPRD.CODUNDCOMPRA ,
        (CASE WHEN TITMMOV.CODUND = TPRD.CODUNDCONTROLE 
     THEN (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) 
     ELSE ((CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) * (SELECT FATORCONVERSAO FROM TUND (NOLOCK) WHERE TUND.CODUND = TITMMOV.CODUND 
      GROUP BY FATORCONVERSAO)) 
     / (SELECT FATORCONVERSAO FROM TUND (NOLOCK)  WHERE TUND.CODUND = TPRD.CODUNDCONTROLE)
     END) AS QUANTIDADE ,TITMMOV.PRECOUNITARIO,
     

((TITMMOV.PRECOUNITARIO + 
(ISNULL(TITMMOV.VALORFRETECTRC,0)/ 
CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) - 
(ISNULL(TITMMOV.VALORDESC,0)/
CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) + 
(isnull((select sum(VALOR) from TTRBMOV (NOLOCK)  where CODCOLIGADA = TITMMOV.CODCOLIGADA 
and IDMOV = TITMMOV.IDMOV and NSEQITMMOV = TITMMOV.NSEQITMMOV and CODTRB = 'IPI'),0)/
CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)) +   
CASE WHEN ISNULL((CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END),0) < 1 THEN
 ((ISNULL(TMOV.VALORFRETE,0)-ISNULL(TMOV.VALORDESC,0)+ISNULL(TMOV.VALOREXTRA1,0)) * 
((TITMMOV.PRECOUNITARIO * (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) ) / 
CASE WHEN TMOV.VALORBRUTO = '0' THEN VALORBRUTOORIG ELSE VALORBRUTO END )) ELSE
 ((ISNULL(TMOV.VALORFRETE,0)-ISNULL(TMOV.VALORDESC,0)+ISNULL(TMOV.VALOREXTRA1,0)) * ((TITMMOV.PRECOUNITARIO * 
(CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) ) / 
CASE WHEN TMOV.VALORBRUTO = '0' THEN VALORBRUTOORIG ELSE VALORBRUTO END ))/ 
CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END END)
        * (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END) AS VAL
FROM    TMOV (nolock) ,
        TITMMOV (nolock),
        DBO.TPRD(nolock)
WHERE   
        TMOV.CODCOLIGADA =1        
		AND TMOV.IDMOV = TITMMOV.IDMOV
        AND TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA
        AND TPRD.IDPRD = TITMMOV.IDPRD
        AND TPRD.CODCOLIGADA = TITMMOV.CODCOLIGADA
        AND TMOV.CODTMV IN ('2.2.05','4.1.01','1.1.40','1.1.41','4.1.04','3.1.28')  
        AND TMOV.STATUS<>'C'
        AND TITMMOV.IDPRD =T.IDPRD

       AND (CASE WHEN TMOV.CODTMV = '3.1.28' THEN TMOV.CODLOCDESTINO  
   ELSE TMOV.CODLOC END) BETWEEN  '3.0055' AND '3.0055'

	AND (CASE WHEN TMOV.CODTMV = '3.1.28' THEN TMOV.CODFILIALDESTINO  
   ELSE TMOV.CODFILIAL END) =1


                AND (CASE WHEN TMOV.DATACRIACAO IS NULL 
                  THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) >= '20230701'
        AND (CASE WHEN TMOV.DATACRIACAO IS NULL 
                  THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) <= '20230731'
                  
AND (TITMMOV.QUANTIDADE<>0
			OR TITMMOV.QUANTIDADETOTAL<>0)

)
        AS T
GROUP BY 
        T.CODIGOPRD ,
        T.NOMEFANTASIA ,
        T.CODUNDCOMPRA
        

)

AS PRE�O_MEDIO

/* FINAL DA FORMULA DE PRECO MEDIO */

 from 
(select TPRD.IDPRD, TPRD.CODIGOPRD, TPRD.NOMEFANTASIA, 
(CASE WHEN TITMMOV.CODUND = TPRD.CODUNDCONTROLE 
     THEN  (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  
     ELSE ( (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  * (SELECT ISNULL(FATORCONVERSAO,0) FROM TUND (NOLOCK) WHERE TUND.CODUND = TITMMOV.CODUND)) 
     / (SELECT ISNULL(FATORCONVERSAO,0) FROM TUND (NOLOCK)  WHERE TUND.CODUND = TPRD.CODUNDCONTROLE)
     END) AS ENTRADA, 0 AS SAIDA,
TPRD.CODUNDCONTROLE,TMOV.CODLOC,0 AS ENTRADA2
from TITMMOV (NOLOCK) 
INNER JOIN TMOV (NOLOCK) ON TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA AND TMOV.IDMOV = TITMMOV.IDMOV
INNER JOIN TPRD (NOLOCK) ON TPRD.CODCOLIGADA = TMOV.CODCOLIGADA AND TPRD.IDPRD = TITMMOV.IDPRD
 
 where 
 TMOV.CODCOLIGADA =1
 AND TMOV.STATUS <> 'C'
 AND (TITMMOV.QUANTIDADE<>0
			OR TITMMOV.QUANTIDADETOTAL<>0)

 AND TMOV.CODTMV IN ('2.2.05','1.1.40','1.1.41','4.1.01','4.1.04' ,'3.1.28')AND

(CASE WHEN TMOV.CODTMV = '3.1.28' THEN TMOV.CODLOCDESTINO  
   ELSE TMOV.CODLOC END) BETWEEN  '3.0055' AND '3.0055' 


	AND (CASE WHEN TMOV.CODTMV = '3.1.28' THEN TMOV.CODFILIALDESTINO  
   ELSE TMOV.CODFILIAL END) =1


AND TPRD.CODIGOPRD >='a' AND TPRD.CODIGOPRD <='z' AND 
(CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) >= '20210101' AND
(CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) <= '20230802'
AND (TITMMOV.QUANTIDADE<>0
			OR TITMMOV.QUANTIDADETOTAL<>0)




UNION ALL
select TPRD.IDPRD, TPRD.CODIGOPRD, TPRD.NOMEFANTASIA,
0 AS ENTRADA, (CASE WHEN TITMMOV.CODUND = TPRD.CODUNDCONTROLE 
     THEN  (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  
     ELSE ( (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  * (SELECT ISNULL(FATORCONVERSAO,0) FROM TUND (NOLOCK) WHERE TUND.CODUND = TITMMOV.CODUND)) 
     / (SELECT ISNULL(FATORCONVERSAO,0) FROM TUND (NOLOCK) WHERE TUND.CODUND = TPRD.CODUNDCONTROLE)
     END) AS SAIDA,
TPRD.CODUNDCONTROLE,
TMOV.CODLOC,
0 AS ENTRADA2
from TITMMOV (NOLOCK) 
INNER JOIN TMOV (NOLOCK) ON TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA AND TMOV.IDMOV = TITMMOV.IDMOV
INNER JOIN TPRD (NOLOCK) ON TPRD.CODCOLIGADA = TMOV.CODCOLIGADA AND TPRD.IDPRD = TITMMOV.IDPRD
 where 
 TMOV.CODCOLIGADA =1
 AND TMOV.CODFILIAL =1 /* ADICIONADO POR LUIZ VIANA */
 AND TMOV.STATUS <> 'C' 
 AND (TITMMOV.QUANTIDADE<>0
			OR TITMMOV.QUANTIDADETOTAL<>0)

 AND TMOV.CODTMV IN  ('1.1.03','1.1.27','1.1.33','3.1.28','3.1.36','3.1.39','2.1.01','4.1.06','4.1.05') AND TMOV.CODLOC >='3.0055' AND TMOV.CODLOC <='3.0055' AND
TPRD.CODIGOPRD >='a' AND TPRD.CODIGOPRD <='z' AND 
(CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) >= '20210101' AND
(CASE WHEN CONVERT(DATE,TMOV.DATACRIACAO) IS NULL THEN CONVERT(DATE,TMOV.DATACRIACAO) ELSE  CONVERT(DATE,TMOV.DATACRIACAO) END) <= '20230802'

UNION ALL

select TPRD.IDPRD, TPRD.CODIGOPRD, TPRD.NOMEFANTASIA, 
0 AS ENTRADA, 0 AS SAIDA,
TPRD.CODUNDCONTROLE,
TMOV.CODLOC,
(CASE WHEN TITMMOV.CODUND = TPRD.CODUNDCONTROLE 
     THEN  (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  
     ELSE ( (CASE WHEN TITMMOV.QUANTIDADE = '0' THEN TITMMOV.QUANTIDADETOTAL ELSE TITMMOV.QUANTIDADE END)  * (SELECT FATORCONVERSAO FROM TUND (NOLOCK)  WHERE TUND.CODUND = TITMMOV.CODUND)) 
     / (SELECT FATORCONVERSAO FROM TUND (NOLOCK)  WHERE TUND.CODUND = TPRD.CODUNDCONTROLE)
     END) AS ENTRADA2
from TITMMOV (NOLOCK) 
INNER JOIN TMOV (NOLOCK) ON TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA AND TMOV.IDMOV = TITMMOV.IDMOV
INNER JOIN TPRD (NOLOCK) ON TPRD.CODCOLIGADA = TMOV.CODCOLIGADA AND TPRD.IDPRD = TITMMOV.IDPRD
 where 
 TMOV.CODCOLIGADA =1
 AND TMOV.CODFILIAL =1 /* ADICIONADO POR LUIZ VIANA */
 AND TMOV.STATUS <> 'C' 
 AND (TITMMOV.QUANTIDADE<>0
			OR TITMMOV.QUANTIDADETOTAL<>0)

 AND TMOV.CODTMV IN (select TTMV.CODTMV from TTMV (NOLOCK) 
inner join TITMTMV (NOLOCK) on TTMV.CODTMV = TITMTMV.CODTMV AND TTMV.CODCOLIGADA = TITMTMV.CODCOLIGADA
 and TITMTMV.codtmv ='4.1.03')  AND TMOV.CODLOC >='3.0055' AND TMOV.CODLOC <='3.0055' AND 
TPRD.CODIGOPRD >='a' AND TPRD.CODIGOPRD <='z' AND 
(CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) >= '20210101' AND
(CASE WHEN TMOV.DATACRIACAO IS NULL THEN TMOV.DATACRIACAO ELSE TMOV.DATACRIACAO END) <= '20230802'
) 
as T 
GROUP BY
T.IDPRD, T.CODIGOPRD, T.NOMEFANTASIA,
T.CODUNDCONTROLE
ORDER BY T.NOMEFANTASIA