use DBCONTROLEMP
select * 
from qualidade.FICHA_VERIFICACAO_USUARIO
where dbo.TRAZ_USERNAME(UserId) like '%eduardo.duarte%'
