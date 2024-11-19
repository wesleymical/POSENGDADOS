-- Total de candidatos concorrendo ao cargo de VEREADOR, agrupados por estado e ordenados 
SELECT 
    SG_UF, 
    COUNT(*) AS TOTAL_CANDIDATOS
FROM 
    CANDIDATO
WHERE 
    DS_CARGO = 'Vereador'
GROUP BY 
    SG_UF
ORDER BY 
    TOTAL_CANDIDATOS DESC;