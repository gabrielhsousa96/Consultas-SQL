UPDATE PARA DATA DE HORARIO DE VER�O 
UPDATE QUALIDADE.FICHA_PREENCHIDA 

SET DAT_FIM_SERVICO = DATEADD(HOUR,2,DAT_FIM_SERVICO) 

WHERE MONTH(DAT_FIM_SERVICO) = 10 

AND YEAR(DAT_FIM_SERVICO) = 2023 

--AND DBO.TRAZ_COD_FDV(ID_FICHA_PREENCHIDA) = '16.42.6' 

--AND QUALIDADE.FICHA_PREENCHIDA .ID_OBRA = 185
 
UPDATE QUALIDADE.FICHA_PREENCHIDA 

SET DAT_INICIO_SERVICO =  DATEADD(HOUR,2,DAT_INICIO_SERVICO) 

WHERE MONTH(DAT_INICIO_SERVICO) = 10 

AND YEAR(DAT_INICIO_SERVICO) = 2023 

--AND DBO.TRAZ_COD_FDV(ID_FICHA_PREENCHIDA) = '16.42.6' 

--AND QUALIDADE.FICHA_PREENCHIDA .ID_OBRA = 185 
