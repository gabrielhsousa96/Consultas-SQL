  USE DBCONTROLEMP
  BEGIN TRAN 
  DELETE 
  FROM PERFIL_USUARIO_OBRA 
  
  LEFT JOIN OBRA							ON obra.ID_OBRA = PERFIL_USUARIO_OBRA.ID_OBRA
  LEFT JOIN EMPREENDIMENTO					ON EMPREENDIMENTO.ID_EMPREENDIMENTO = OBRA.ID_EMPREENDIMENTO
  LEFT JOIN aspnet_Users					ON aspnet_Users.UserId = PERFIL_USUARIO_OBRA.UserId
  LEFT JOIN PERFIL							ON perfil.ID_PERFIL = PERFIL_USUARIO_OBRA.ID_PERFIL
  
  WHERE 
  EMPREENDIMENTO.FLG_ATIVO = 0
  and aspnet_Users.UserName	 NOT IN ('emccamp\alex.reis', 'emccamp\marcelo.silva', 'emccamp\marcos.vinicius', 'emccamp\luiz.viana', 'emccamp\arthur.cordeiro', 'emccamp\gabriel.ferreira', 'emccamp\yan.alves','emccamp\tarso.diogo', 'emccamp\caio.souza')
 --aspnet_Users.UserName LIKE '%taiane.carvalho%' --or aspnet_Users.UserName LIKE '%kare


 select * 
 from obra
 where RM_CODCOLIGADA = 16