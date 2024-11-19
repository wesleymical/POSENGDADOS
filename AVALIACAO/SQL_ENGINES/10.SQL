-- Verificar se a procedure já existe
IF OBJECT_ID('dbo.sp_ExibirCandidatosPorUF', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ExibirCandidatosPorUF;
GO

-- Criar a procedure
CREATE PROCEDURE dbo.sp_ExibirCandidatosPorUF
    @UF VARCHAR(2)
AS
BEGIN
    -- Limpar a tabela temporária
    IF OBJECT_ID('tempdb..#CandidatosUF') IS NOT NULL
        DROP TABLE #CandidatosUF;

    -- Criar tabela temporária
    CREATE TABLE #CandidatosUF (
        SQ_CANDIDATO BIGINT,
        NM_CANDIDATO VARCHAR(255),
        DS_OCUPACAO VARCHAR(255),
        SG_PARTIDO VARCHAR(255),
        NM_PARTIDO VARCHAR(255),
        VOTOS_RECEBIDOS INT,
        VALOR_BENS DECIMAL(18, 2),
        LK_REDE_SOCIAL VARCHAR(MAX)
    );

    -- Inserir os dados na tabela temporária
    INSERT INTO #CandidatosUF
    SELECT 
        C.SQ_CANDIDATO,
        C.NM_CANDIDATO,
        C.DS_OCUPACAO,
        P.SG_PARTIDO,
        P.NM_PARTIDO,
        ISNULL(SUM(V.QT_VOTOS_NOMINAIS_VALIDOS), 0) AS VOTOS_RECEBIDOS,
        ISNULL(SUM(B.VR_BEM_CANDIDATO), 0) AS VALOR_BENS,
        R.LK_REDE_SOCIAL
    FROM 
        CANDIDATO C
    LEFT JOIN 
        PARTIDO P ON C.NR_PARTIDO = P.NR_PARTIDO
    LEFT JOIN 
        VOTACAO V ON C.SQ_CANDIDATO = V.SQ_CANDIDATO AND V.SG_UF = @UF
    LEFT JOIN 
        BEM_CANDIDATO B ON C.SQ_CANDIDATO = B.SQ_CANDIDATO
    LEFT JOIN 
        REDE_SOCIAL R ON C.SQ_CANDIDATO = R.SQ_CANDIDATO
    WHERE 
        C.SG_UF = @UF
    GROUP BY 
        C.SQ_CANDIDATO, 
        C.NM_CANDIDATO, 
        C.DS_OCUPACAO, 
        P.SG_PARTIDO, 
        P.NM_PARTIDO, 
        R.LK_REDE_SOCIAL;

    -- Selecionar os dados da tabela temporária
    SELECT * FROM #CandidatosUF;

    -- Limpar a tabela temporária
    DROP TABLE #CandidatosUF;
END;
GO