

SELECT DISTINCT grupo,
                moeda,
                STR(SUM(valor),10,2) AS valor,
                 STR ((valor / (SELECT SUM (mreccmp.valortotal)
                                               FROM   mcmp
                                                      INNER JOIN mreccmp
                                                        ON ( mreccmp.codcoligada= mcmp.codcoligada
                                                        AND mreccmp.idcmp = mcmp.idcmp
                                                        AND mreccmp.idprj = mcmp.idprj )
                                               WHERE  mcmp.idprj =:IDPRJ
												      AND mcmp.codcoligada =:$CODCOLIGADA
                                                      AND mcmp.codcmp =:CODCMP
                                                      )* 100),10,2) as 'PESO (%)'
FROM   (
SELECT DISTINCT mprjcompl.codcq,
                        null nivel,
                       null                 pai,
                        CASE
                          WHEN gg.grupo = 'M' THEN 'MATERIAIS'
                          ELSE CASE
                                 WHEN gg.grupo = 'S' THEN 'SUBEMPREITEIRO'
                                 ELSE CASE
                                        WHEN gg.grupo = 'E' THEN 'EQUIPAMENTOS'
                                        ELSE CASE
                                               WHEN gg.grupo = 'D' THEN
                                               'DESPESA INDIRETA'
                                               ELSE CASE
                                                      WHEN gg.grupo = 'F' THEN
                                                      'MÃO DE OBRA'
                                                    END
                                             END
                                      END
                               END
                        END                          grupo,
                        mprjcompl.dtbase,
                        'R$'                         moeda,
              dbo.Pegatodosism_controlq(mcmp.idcmp,
                          mprj.codcoligada, mprj.idprj, gg.grupo, 1,
                                                         null, null)
                                      valor
        FROM   (SELECT 'M' grupo
                UNION
                SELECT 'S'
                UNION
                SELECT 'E'
                UNION
                SELECT 'D'
                UNION
                SELECT 'F') AS gg,
               
                mcmp
                 
               LEFT OUTER JOIN mreccmp
                 ON mcmp.codcoligada = mreccmp.codcoligada
                    AND mcmp.idprj = mreccmp.idprj
                    AND mcmp.idcmp = mreccmp.idcmp
                              INNER JOIN mprjcompl
                 ON mcmp.codcoligada = mprjcompl.codcoligada
                    AND mcmp.idprj = mprjcompl.idprj

               INNER JOIN mprj
                 ON mcmp.codcoligada = mprj.codcoligada
                    AND mcmp.idprj = mprj.idprj
               
        WHERE  mprj.codcoligada = :$CODCOLIGADA
        AND mprj.idprj = :IDPRJ
        AND mcmp.codcmp = :CODCMP

        
        
        ) AS a
WHERE  valor > 0
GROUP  BY codcq,
          nivel,
          pai,
          grupo,
          dtbase,
          moeda,
          valor  
          