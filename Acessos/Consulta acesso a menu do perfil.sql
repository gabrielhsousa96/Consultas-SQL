SELECT
* FROM GAUTZMENU 
WHERE TAGMENU = '803000005'	
AND SUBSTRING(PERMISSOES,1,1) = '*'
and CODPERFIL NOT LIKE ('%TESTE%')

