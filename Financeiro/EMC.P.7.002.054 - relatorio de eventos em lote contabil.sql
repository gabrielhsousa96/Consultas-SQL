/*
EMC.P.7.002.054 - Relatorio de eventos em lote contabil
*/

SELECT 
T.NOME_FUNC,
T.NOME_ENCARGO,
(CASE WHEN T.VALOR_PROV < 0 THEN T.VALOR_PROV * -1 ELSE T.VALOR_PROV END) AS PROVENTO,
(CASE WHEN T.VALOR_DEB < 0 THEN T.VALOR_DEB * -1 ELSE T.VALOR_DEB END)  AS DESCONTO,
*
FROM(
SELECT 
PFENCARGO.ANOCOMP,
PFENCARGO.MESCOMP,
(CONVERT(VARCHAR, PFUNC.CODCOLIGADA) + ' - ' + CONVERT(VARCHAR, PFUNC.CHAPA)) AS 'COLIGADA_CHAPA',
PFUNC.CODSINDICATO,
PSINDIC.NOME AS 'NOME_SINDC',
PFUNCAO.NOME AS 'NOME_FUNC',
PFENCARGO.CODENCARGO,
PENCARGO.DESCRICAO AS NOME_ENCARGO,
PEVENTO.CCUSTO AS CENTRO_DE_CUSTO /* VERIFICAR COM A LANE, NULO NA PEVENTO E NA PFUNC */,
(CASE WHEN PEVENTO.PROVDESCBASE = 'D' THEN CONVERT(MONEY,PFENCARGO.VALOR) ELSE 0 END) AS 'VALOR_PROV',
(CASE WHEN PEVENTO.PROVDESCBASE = 'P' THEN CONVERT(MONEY,PFENCARGO.VALOR) ELSE 0 END) AS 'VALOR_DEB',
PENCARGO.CONTADEBITO,
PENCARGO.CONTACREDITO
 
FROM PFUNC (NOLOCK)

LEFT JOIN PFENCARGO		(NOLOCK) ON (PFENCARGO.CODCOLIGADA = PFUNC.CODCOLIGADA AND PFENCARGO.CHAPA = PFUNC.CHAPA)
LEFT JOIN PSINDIC		(NOLOCK) ON (PSINDIC.CODCOLIGADA = PFUNC.CODCOLIGADA AND PSINDIC.CODIGO = PFUNC.CODSINDICATO)
LEFT JOIN PENCARGO		(NOLOCK) ON (PFENCARGO.CODCOLIGADA = PENCARGO.CODCOLIGADA AND PFENCARGO.CODENCARGO = PENCARGO.CODIGO)
LEFT JOIN PFUNCAO		(NOLOCK) ON (PFUNC.CODCOLIGADA = PFUNCAO.CODCOLIGADA AND PFUNCAO.CODIGO = PFUNC.CODFUNCAO)
LEFT JOIN PITEMPARTIDA	(NOLOCK) ON (PITEMPARTIDA.CODCOLIGADA = PFUNC.CODCOLIGADA AND PITEMPARTIDA.CHAPA = PFUNC.CHAPA)
LEFT JOIN PEVENTO		(NOLOCK) ON (PEVENTO.CODCOLIGADA = PITEMPARTIDA.CODCOLIGADA AND PEVENTO.CODIGO = PITEMPARTIDA.CODEVENTO)


WHERE pfencargo.ANOCOMP = :ANOCOMP
AND pfencargo.MESCOMP = :MESCOMP
AND PFUNC.CODCOLIGADA = :$CODCOLIGADA
AND PFUNC.CODSITUACAO = 'D'

/*
WHERE pfencargo.ANOCOMP = '2024'
AND pfencargo.MESCOMP = '05'
and pfunc.codcoligada = 51
AND PFUNC.SITUA��O = 'D'
*/

GROUP BY  
PFENCARGO.ANOCOMP,
PFENCARGO.MESCOMP,
PFUNC.CODCOLIGADA,
PFUNC.CHAPA,
PFUNC.CODSINDICATO,
PFUNCAO.NOME,
PFENCARGO.CODENCARGO,
PENCARGO.DESCRICAO,
PEVENTO.CCUSTO,
PFENCARGO.APLICACAO,
PFENCARGO.VALOR,
PENCARGO.CONTADEBITO,
PENCARGO.CONTACREDITO,
PEVENTO.PROVDESCBASE,
PSINDIC.NOME
) AS T
  GROUP BY 
 T.VALOR_PROV,
 T.VALOR_DEB,
 T.ANOCOMP,
 T.MESCOMP,
 T.COLIGADA_CHAPA,
 T.CODSINDICATO,
 T.NOME_FUNC,
 T.CODENCARGO,
 T.NOME_ENCARGO,
 T.CENTRO_DE_CUSTO,
 T.CONTADEBITO,
 T.CONTACREDITO,
 T.NOME_SINDC

