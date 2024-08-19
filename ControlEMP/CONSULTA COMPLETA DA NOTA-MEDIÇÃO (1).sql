
/*CONSULTA COMPLETA DA NOTA/MEDI��I*/

SELECT 
EMPREENDIMENTO.ID_EMPREENDIMENTO
,EMPREENDIMENTO.NOM_EMPREENDIMENTO
,CONVERT(VARCHAR,OBRA.ID_OBRA)+' - ' +OBRA.RM_NOME AS 'OBRA'
,OBRA.RM_CODCOLIGADA
--,OBRA.RM_CODFILIAL
--,OBRA.RM_CODCCUSTO
,EMPREITEIRO.NOM_EMPREITEIRO
,EMPREITEIRO.ID_EMPREITEIRO
,EMPREITEIRO.RM_CODCFO
,CONTRATO.ID_CONTRATO

,(SELECT TOP 1
	CONVERT(VARCHAR, CONTRATO_HISTORICO.ID_ETAPA)+' - '+( ETAPA_HIST.NOM_ETAPA) AS 'CONTRATO_ETAPA'
   FROM CONTRATO_HISTORICO 
	INNER JOIN ETAPA AS ETAPA_HIST (NOLOCK) ON (ETAPA_HIST.ID_ETAPA = CONTRATO_HISTORICO .ID_ETAPA)
	  WHERE CONTRATO_HISTORICO.ID_CONTRATO = CONTRATO.ID_CONTRATO
	  ORDER BY DAT_HISTORICO DESC) AS 'CONTRATO_HISTORICO_ETAPA'

,CONTRATO.COD_CONTRATO
,CONVERT(VARCHAR,CONTRATO.ID_ETAPA)+ ' - ' + ETAPA.NOM_ETAPA AS 'CONTRATO-ETAPA'
,FORMAT(CONTRATO.DAT_CADASTRO, 'dd-MM-yyyy - HH:mm:ss') AS 'CONTRATO-DAT_CADASTRO'
,FORMAT(CONTRATO.DAT_INICIO_CONTRATO, 'dd-MM-yyyy - HH:mm:ss') AS 'CONTRATO-DAT_INICIO_CONTRATO'
,FORMAT(CONTRATO.DAT_FIM_CONTRATO, 'dd-MM-yyyy - HH:mm:ss') AS 'CONTRATO-DAT_FIM_CONTRATO'
,FORMAT(CONTRATO.DAT_QUITACAO, 'dd-MM-yyyy - HH:mm:ss') AS 'CONTRATO-DAT_QUITACAO'
,CONTRATO.EXCLUIDO AS 'CONTRATO_EXCLUIDO'
,MEDICAO.ID_MEDICAO
,CONVERT(VARCHAR,MEDICAO.ID_ETAPA)+ ' - ' + ETAPA_MED.NOM_ETAPA AS 'MEDICAO.ID_ETAPA'
,FORMAT(MEDICAO.DAT_INICIO, 'dd-MM-yyyy - HH:mm:ss') AS 'MEDICAO-DAT_INICIO'
,FORMAT(MEDICAO.DAT_FIM, 'dd-MM-yyyy - HH:mm:ss') AS 'MEDICAO-DAT_FIM'
,MEDICAO.EXCLUIDO AS 'MEDICAO-EXCLUIDO'
,MEDICAO.NUMERO_NOTA AS 'MEDICAO-NUMERO_NOTA'
,NOTA_FISCAL.ID_NOTA_FISCAL
,NOTA_FISCAL.NUMERO_NOTA
,NOTA_FISCAL.CLASSIFICACAO_FINANCEIRA
,NOTA_FISCAL.ID_USUARIO_EXPORTADO
,NOTA_FISCAL.RM_IDMOV
,NOTA_FISCAL.DATA_EXPORTACAO
,NOTA_FISCAL.TIPO_MOVIMENTO
,NOTA_FISCAL.RM_CODFILIAL

FROM CONTRATO (NOLOCK)

LEFT JOIN OBRA					(NOLOCK) ON (CONTRATO.ID_OBRA = OBRA.ID_OBRA)
LEFT JOIN EMPREENDIMENTO		(NOLOCK) ON (OBRA.ID_EMPREENDIMENTO = EMPREENDIMENTO.ID_EMPREENDIMENTO)
LEFT JOIN MEDICAO				(NOLOCK) ON (MEDICAO.ID_OBRA = CONTRATO.ID_OBRA AND MEDICAO.ID_CONTRATO = CONTRATO.ID_CONTRATO)
LEFT JOIN NOTA_FISCAL			(NOLOCK) ON (NOTA_FISCAL.ID_MEDICAO = MEDICAO.ID_MEDICAO)
LEFT JOIN ETAPA					(NOLOCK) ON (ETAPA.ID_ETAPA = CONTRATO.ID_ETAPA)
LEFT JOIN ETAPA AS ETAPA_MED	(NOLOCK) ON (ETAPA_MED.ID_ETAPA = MEDICAO.ID_ETAPA)	
LEFT JOIN EMPREITEIRO			(NOLOCK) ON (EMPREITEIRO.ID_EMPREITEIRO = CONTRATO.ID_EMPREITEIRO)

WHERE 
--OBRA.ID_OBRA = 147
NOTA_FISCAL.NUMERO_NOTA = '000000265' AND NOTA_FISCAL.DATA_EMISSAO >= '20230523'
 --MEDICAO.ID_MEDICAO = '70711'

