--ZERA IMPOSTO ANOTAÇÕES E DESENVOLVIMENTOS 

--FORMULA 682 
--CONSULTA FV.682


SELECT 
TMOV.CODCOLIGADA,
TMOV.IDMOV,
TMOV.CODTMV,
CODTB5FAT AS 'SIMPLES',
'ISS' as imposto,
TTRBMOV.CODTRB,
CONVERT(MONEY,TTRBMOV.VALOR) AS 'VALOR',
TMOV.RECCREATEDBY,
tmov.RECCREATEDON
FROM TMOV (NOLOCK)
INNER JOIN TTRBMOV (NOLOCK) ON TTRBMOV.CODCOLIGADA = TMOV.CODCOLIGADA AND TTRBMOV.IDMOV = TMOV.IDMOV
WHERE 
TMOV.CODCOLIGADA = 51--@CODCOLIGADA 
AND TMOV.IDMOV = 65083--@IDMOV
AND TTRBMOV.CODTRB = 'ISS'
--AND CODTRB IN ('IRRFPJ', 'COFRF', 'CSRF', 'PISRF', 'RTOTAL')

--rollback
begin tran
UPDATE TTRBMOV 
SET VALOR = 0 
WHERE TTRBMOV.CODCOLIGADA =  1  AND TTRBMOV.IDMOV =  26943 AND TTRBMOV.CODTRB = 'COFRF'


select * 
from TTRBMOV


--IF ELSE 

/*
CONDIÇÃO:
this.consulta.Fields["RECCREATEDBY"].AsString == "gabriel.ferreira" &&
this.consulta.Fields["SIMPLES"].AsString == "001" &&
this.consulta.Fields["VALOR"].AsDecimal > 0 &&
(
	this.consulta.Fields["CODTMV"].AsString == "1.2.07" ||
	this.consulta.Fields["CODTMV"].AsString == "1.2.08"
)
*/

--MOVIMENTOS DE TESTE

select * 
from tmov 
where idmov in (2268887, 2268885, 2268877) -- MOV1 ID: 2268877 FIL: 63 

select * 
from TTRBMOV 
where idmov = 2269384

SELECT * 
FROM TMOV
WHERE IDMOV = 26943 
AND CODTMV = '1.2.08'

/*
--UPDATE
UPDATE TTRBMOV
SET VALOR = 0
WHERE TTRBMOV.CODCOLIGADA = 1
AND TTRBMOV.IDMOV = 2269384
AND TTRBMOV.CODTRB = 'COFRF'
*/

/*

private void codeActivity1_ExecuteCode(object sender, System.EventArgs args)
{
  string comando_update = this.ComandoUpdate.ValueConverter.AsString;
  this.DBS.QueryExec(comando_update)
}

*/


/* FORMULA 504 - VALIDA IR E RTOTAL */ 
--ALTERAÇÃO - SE FOR SIMPLES, NÃO CONSIDERA NESSA FORMULA

ALTERAÇÃO FEITA: 
this.Tables["TMOVCOMPL"]["TRIBUTOS_IR_RTOTAL"].IsNull && this.Tables["TMOV"]["CODTB5FAT"].AsString != "001"


select * 
FROM TTRBMOV 
WHERE idmov = 2269535 



SELECT * 
FROM tmov 
where idmov = 31366
and numeromov like '%001706%'


SELECT reccreatedon,* 
FROM TMOV
WHERE CODCFO = 'F49542'
AND CODTMV = '1.1.62'
AND STATUS <> 'F'
