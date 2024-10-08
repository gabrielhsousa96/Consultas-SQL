SELECT		GCCUSTO.CODCCUSTO AS CUSTO$,
            GCCUSTO.NOME AS CENTROCUSTO,
            TPRD.CODIGOPRD,
            TPRD.NOMEFANTASIA,
			TMOV.NUMEROMOV,
			TMOV.CODFILIAL,
			TITMMOV.NSEQITMMOV,
			TITMMOV.QUANTIDADEORIGINAL,
			ISNULL((SELECT SUM(TITMMOVRELAC.QUANTIDADE) FROM TITMMOVRELAC (NOLOCK) INNER JOIN TMOV (NOLOCK) ON TITMMOVRELAC.IDMOVDESTINO = TMOV.IDMOV AND TMOV.STATUS <>'C'
			 WHERE  TITMMOVRELAC.IDMOVORIGEM=TITMMOV.IDMOV AND NSEQITMMOVORIGEM =TITMMOV.NSEQITMMOV),0) AS RECEBIDO,
			TITMMOV.QUANTIDADEARECEBER 
FROM TMOV (NOLOCK) 
			INNER JOIN TITMMOV (NOLOCK)ON TMOV.CODCOLIGADA = TITMMOV.CODCOLIGADA AND TMOV.IDMOV = TITMMOV.IDMOV
			LEFT JOIN GCCUSTO (NOLOCK) ON TMOV.CODCOLIGADA = GCCUSTO.CODCOLIGADA AND TMOV.CODCCUSTO = GCCUSTO.CODCCUSTO
			LEFT JOIN TPRD (NOLOCK) ON TITMMOV.CODCOLIGADA = TPRD.CODCOLIGADA AND TITMMOV.IDPRD = TPRD.IDPRD		  
WHERE TMOV.CODTMV ='1.1.21'
--AND TMOV.CODCOLIGADA IN (@COLIGADA)
--AND TPRD.CODIGOPRD IN (@CODIGO_PRODUTO_S)
AND TMOV.CODCCUSTO = '3.0001.04' --IN (@CENTRO_DE_CUSTO_S)


ORDER BY CUSTO$