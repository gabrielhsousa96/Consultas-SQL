  USE DBCONTROLEMP
  SELECT  DISTINCT
  obra.RM_NOME								AS Obra, 
  aspnet_Users.UserName						AS Usuario,  
  perfil.NOM_PERFIL							AS Perfil_do_ControlEMP, 
  RM_CODCOLIGADA							AS Coligada_no_RM, 
  RM_CODFILIAL								AS Filial
  
  FROM PERFIL_USUARIO_OBRA 
  
  LEFT JOIN OBRA							ON obra.ID_OBRA = PERFIL_USUARIO_OBRA.ID_OBRA
  LEFT JOIN aspnet_Users					ON aspnet_Users.UserId = PERFIL_USUARIO_OBRA.UserId
  LEFT JOIN PERFIL							ON perfil.ID_PERFIL = PERFIL_USUARIO_OBRA.ID_PERFIL
  
  WHERE aspnet_Users.UserName LIKE '%taiane.carvalho%' --or aspnet_Users.UserName LIKE '%karem.nunes%'


