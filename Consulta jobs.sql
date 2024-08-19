
--Saldos e custos em andamento

SELECT  
GJOBX.CODCOLIGADA,
GJOBX.NOME,
GJOBXEXECUCAO.* 
FROM GJOBXEXECUCAO 
INNER JOIN GJOBX (NOLOCK) on (GJOBX.IDJOB = GJOBXEXECUCAO.IDJOB)
WHERE 
GJOBXEXECUCAO.IDJOB in (select idjob from gjobx where nome like '%saldos%' and codusuario = 'job') 
AND PERCPROGRESSO < 100
and GJOBXEXECUCAO.status <> 7
AND DATAINIEXEC >= '20230807'
ORDER BY 
GJOBX.CODCOLIGADA

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

-- Saldos e custos
SELECT
CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
IDJOB,
PROCESSO,
NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
WHERE nome like '%saldos%custos%' 
AND codcoligada IS NOT NULL
order by 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

-- Tabela pra erro de saldos e custos
select DATAFECHAMENTOESTOQUE,* from tpar

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Importação de arquivos

SELECT  
CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
IDJOB,
PROCESSO,
NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,
MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
where nome like '%Importação de Arquivos%' 
AND codcoligada IS NOT NULL
order by 1,3 DESC

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

-- Consulta Status (Erro se não tiver atualização) 

SELECT 
CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
IDJOB,
PROCESSO,
NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,
MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
WHERE nome like '%Serviço%Consulta%XML%' 
AND codcoligada IS NOT NULL
order by 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Integração SOC RM

SELECT 
CONSULTA_JOB.CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
CONSULTA_JOB.IDJOB,
PROCESSO,
CONSULTA_JOB.NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,
MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
LEFT JOIN GJOBX ON GJOBX.IDJOB = CONSULTA_JOB.IDJOB
WHERE gjobx.classeprocesso = 'GlbWorkflowExecProc' 
AND CONSULTA_JOB.idjob = 3445624 
order by 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Correções do controlEMP
SELECT 
CONSULTA_JOB.CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
CONSULTA_JOB.IDJOB,
PROCESSO,
CONSULTA_JOB.NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
LEFT JOIN GJOBX ON GJOBX.IDJOB = CONSULTA_JOB.IDJOB
WHERE gjobx.idjob = 3455272 OR gjobx.idjob = 3624208
order by 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Atualiza transações PIX

SELECT  
CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
IDJOB,
PROCESSO,
NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
WHERE nome like '%ajust%transa%' 
AND codcoligada IS NOT NULL
ORDER BY 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Conciliação PIX

SELECT  
CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
IDJOB,
PROCESSO,
NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,
MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
where nome like 'Importação do Arquivo de Conciliação' 
AND [CONSULTA_JOB].codcoligada IS NOT NULL
order by 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Datas Pepynobox

SELECT 
CONSULTA_JOB.CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
CONSULTA_JOB.IDJOB,
PROCESSO,
CONSULTA_JOB.NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,
MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
LEFT JOIN GJOBX ON GJOBX.IDJOB = CONSULTA_JOB.IDJOB
WHERE gjobx.idjob = 3465342 
ORDER BY 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Envio de orçamento bloqueado

SELECT 
CONSULTA_JOB.CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
CONSULTA_JOB.IDJOB,
PROCESSO,
CONSULTA_JOB.NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,
MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
LEFT JOIN GJOBX ON GJOBX.IDJOB = CONSULTA_JOB.IDJOB
WHERE gjobx.idjob = 3682702
AND [CONSULTA_JOB].codcoligada IS NOT NULL
ORDER BY 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--Gerar QRCODE 

SELECT 
CONSULTA_JOB.CODCOLIGADA,
STATUS,
DATA_FINAL_EXEC,
DATAPROGRAMADA,
STSJOB,
CONSULTA_JOB.IDJOB,
PROCESSO,
CONSULTA_JOB.NOME,
DATAFECHAMENTOESTOQUE,
LIMNEGSALDO2,
MENSAGEMSTATUS
FROM [dbo].[CONSULTA_JOB]()
LEFT JOIN GJOBX ON GJOBX.IDJOB = CONSULTA_JOB.IDJOB
WHERE gjobx.idjob = 3826127 OR gjobx.idjob = 3829722
AND [CONSULTA_JOB].codcoligada IS NOT NULL
ORDER BY 1,3

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--CONSULTA COLIGADA COM MOVIMENTAÇÃO

SELECT 
CODCOLIGADA, 
MAX(DATACRIACAO) AS DATACRIACAO
FROM TMOV
WHERE (CODCOLIGADA =1 OR CODCOLIGADA >=10)
GROUP BY CODCOLIGADA

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

/*JOB PIX*/

1º 20 - Atualiza Transações PIX
FLuxus > Contas a Pagar > Mais > Ajuste Transação
-Todos os dias a cada 1h em todas as coligadas

2º  21 - Conciliação PIX
Fluxus > Manutenção Bancária > Conciliação > processos > 
Importar arquivo de conciliação/ MARCAR  Opção TOTVS pag. Instantâneo, TOTVS WebService e Opção de conciliação diária => NÃO COLOCAR DATA INICIAL E FINAL
-Todos os dias a cada 1h em todas as Coligadas

*JOB CORREÇÕES CONTROLEMP*
EXECUTAR FÓRMULA VISUAL - ID 63 - a cada 1h

*JOB ENVIO DE E-MAILS CONTROLEMP*
EXECUTAR FÓRMULA VISUAL - ID 166 - 3h EM 3h

*CONSULTA DE ARQUIVOS XML - nucleus/intgração/monitor de arquivos xml/ processos/
serviços de consulta de arquivo/ agendar 1min pra frente da hora atual e diariamente a cada 10min

*IMPORTAÇÃO DE ARQUIVOS XML - nucleus/intgração/monitor de arquivos xml/ processos/
Importação de Arquivos XML/ agendar 1min pra frente da hora atual e diariamente a cada 10min

*SALDOS E CUSTOS - nucleus/estoque/processos/Regerar Saldos e Custos /
1º tela deixa como está/ 2º marcar Garantir exclusividade e Forçar Regeração / 
agendar para o outro dia na madrugada e marcar todos os dias.

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--CONSULTA DATA DO ESTOQUE DIFERENTE
 
SELECT * FROM TPAR
WHERE DATAFECHAMENTOESTOQUE <> '20240301'
 
--BEGIN TRAN
--UPDATE TPAR
SET DATAFECHAMENTOESTOQUE = '20240301'
WHERE DATAFECHAMENTOESTOQUE <> '20240301'
 
--COMMIT

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

--CONSULTA ALTERA DATA DO ESTOQUE DIFERENTE

SELECT * FROM TPAR
 
WHERE DATAFECHAMENTOESTOQUE <> '20230801'

--BEGIN TRAN
 
--UPDATE TPAR
 
SET DATAFECHAMENTOESTOQUE = '20230801'
 
WHERE DATAFECHAMENTOESTOQUE <> '20230901'

--COMMIT

<------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

