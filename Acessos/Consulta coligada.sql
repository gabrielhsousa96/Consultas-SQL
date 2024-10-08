USE DBCONTROLEMP
SELECT
EMPREENDIMENTO.RM_CODCOLIGADA					AS CODIGO_DA_COLIGADA,
RM_CODFILIAL									AS FILIAL,
EMPREENDIMENTO.NOM_EMPREENDIMENTO				AS NOME_DO_EMPREENDIMENTO,
OBRA.RM_NOME									AS NODA_DA_OBRA,
OBRA.ESTADO,
OBRA.CIDADE


FROM EMPREENDIMENTO (NOLOCK)
JOIN OBRA			(NOLOCK)					ON EMPREENDIMENTO.RM_CODCOLIGADA = OBRA.RM_CODCOLIGADA AND EMPREENDIMENTO.ID_EMPREENDIMENTO = OBRA.ID_EMPREENDIMENTO
JOIN CONTRATO		(NOLOCK)					ON OBRA.ID_OBRA =  CONTRATO.ID_OBRA

WHERE EMPREENDIMENTO.NOM_EMPREENDIMENTO like '%liber%'

GROUP BY 
EMPREENDIMENTO.NOM_EMPREENDIMENTO,
OBRA.RM_NOME,
EMPREENDIMENTO.RM_CODCOLIGADA,
RM_CODFILIAL,
OBRA.ESTADO,
OBRA.CIDADE

ORDER BY 1,2
