-- Verificar se a tabela STAGING existe
IF OBJECT_ID('dbo.STAGING_REDE_SOCIAL', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.STAGING_REDE_SOCIAL;
END

-- Criar a tabela STAGING com as colunas do cabeçalho fornecido
CREATE TABLE STAGING_REDE_SOCIAL (
    DT_GERACAO VARCHAR(255),
    HH_GERACAO VARCHAR(255),
    AA_ELEICAO VARCHAR(255),
    SG_UF VARCHAR(255),
    CD_TIPO_ELEICAO VARCHAR(255),
    NM_TIPO_ELEICAO VARCHAR(255),
    CD_ELEICAO VARCHAR(255),
    SQ_CANDIDATO VARCHAR(255),
    NR_ORDEM_REDE_SOCIAL VARCHAR(255),
    DS_URL VARCHAR(255)
);

-- Definir variável para o caminho do arquivo CSV
DECLARE @FilePath NVARCHAR(255);
SET @FilePath = N'D:\mical\Documents\POS ENGENHARIA DE DADOS\POSENGDADOS\REPOSITORIO\SQL_ENGINES\rede_social_candidato_2024\rede_social_candidato_2024_AC.csv';

-- Comando dinâmico para importar dados do CSV para a tabela de staging
DECLARE @SQL NVARCHAR(MAX);
SET @SQL = N'
BULK INSERT STAGING_REDE_SOCIAL
FROM ''' + @FilePath + '''
WITH (
    FIELDTERMINATOR = '';'',
    ROWTERMINATOR = ''\n'',
    FIRSTROW = 2,
    CODEPAGE = ''1252'' -- Utilizar a página de código 1252 para Latin-1
);
';

-- Executar o comando dinâmico
EXEC sp_executesql @SQL;

-- Remover aspas das colunas de texto na tabela de staging
UPDATE STAGING_REDE_SOCIAL
SET 
    DT_GERACAO = REPLACE(DT_GERACAO, '"', ''),
    HH_GERACAO = REPLACE(HH_GERACAO, '"', ''),
    AA_ELEICAO = REPLACE(AA_ELEICAO, '"', ''),
    SG_UF = REPLACE(SG_UF, '"', ''),
    CD_TIPO_ELEICAO = REPLACE(CD_TIPO_ELEICAO, '"', ''),
    NM_TIPO_ELEICAO = REPLACE(NM_TIPO_ELEICAO, '"', ''),
    CD_ELEICAO = REPLACE(CD_ELEICAO, '"', ''),
    SQ_CANDIDATO = REPLACE(SQ_CANDIDATO, '"', ''),
    NR_ORDEM_REDE_SOCIAL = REPLACE(NR_ORDEM_REDE_SOCIAL, '"', ''),
    DS_URL = REPLACE(DS_URL, '"', '');

-- Inserir dados tratados na tabela REDE_SOCIAL
INSERT INTO AJUSTADO (
    DT_GERACAO, HH_GERACAO, AA_ELEICAO, SG_UF, CD_TIPO_ELEICAO, NM_TIPO_ELEICAO, CD_ELEICAO, SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL, DS_URL
)
SELECT
    TRY_CONVERT(DATE, TRIM(DT_GERACAO), 103),
    TRY_CONVERT(TIME, TRIM(HH_GERACAO), 108),
    TRY_CONVERT(INT, TRIM(AA_ELEICAO)),
    TRIM(SG_UF),
    TRY_CONVERT(INT, TRIM(CD_TIPO_ELEICAO)),
    TRIM(NM_TIPO_ELEICAO),
    TRY_CONVERT(INT, TRIM(CD_ELEICAO)),
    TRY_CONVERT(BIGINT, TRIM(SQ_CANDIDATO)),
    TRY_CONVERT(INT, TRIM(NR_ORDEM_REDE_SOCIAL)),
    TRIM(DS_URL)
FROM STAGING_REDE_SOCIAL;

-- Inserir dados na tabela TIPO_REDE_SOCIAL a partir da tabela AJUSTADO
MERGE INTO TIPO_REDE_SOCIAL AS target
USING (
    SELECT DISTINCT
        CD_TIPO_REDE_SOCIAL,
        DS_TIPO_REDE_SOCIAL
    FROM AJUSTADO
) AS source
ON (
    target.CD_TIPO_REDE_SOCIAL = source.CD_TIPO_REDE_SOCIAL
)
WHEN MATCHED THEN
    UPDATE SET
        target.DS_TIPO_REDE_SOCIAL = source.DS_TIPO_REDE_SOCIAL
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        CD_TIPO_REDE_SOCIAL,
        DS_TIPO_REDE_SOCIAL
    )
    VALUES (
        source.CD_TIPO_REDE_SOCIAL,
        source.DS_TIPO_REDE_SOCIAL
    );

-- Inserir dados na tabela REDE_SOCIAL a partir da tabela AJUSTADO
MERGE INTO REDE_SOCIAL AS target
USING (
    SELECT
        DT_GERACAO,
        HH_GERACAO,
        ANO_ELEICAO AS AA_ELEICAO,
        SG_UF,
        CD_TIPO_ELEICAO,
        NM_TIPO_ELEICAO,
        CD_ELEICAO,
        SQ_CANDIDATO,
        NR_ORDEM_REDE_SOCIAL,
        DS_URL
    FROM AJUSTADO
) AS source
ON (
    target.SQ_CANDIDATO = source.SQ_CANDIDATO AND
    target.NR_ORDEM_REDE_SOCIAL = source.NR_ORDEM_REDE_SOCIAL
)
WHEN MATCHED THEN
    UPDATE SET
        target.DT_GERACAO = source.DT_GERACAO,
        target.HH_GERACAO = source.HH_GERACAO,
        target.AA_ELEICAO = source.AA_ELEICAO,
        target.SG_UF = source.SG_UF,
        target.CD_TIPO_ELEICAO = source.CD_TIPO_ELEICAO,
        target.NM_TIPO_ELEICAO = source.NM_TIPO_ELEICAO,
        target.CD_ELEICAO = source.CD_ELEICAO,
        target.DS_URL = source.DS_URL
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        DT_GERACAO,
        HH_GERACAO,
        AA_ELEICAO,
        SG_UF,
        CD_TIPO_ELEICAO,
        NM_TIPO_ELEICAO,
        CD_ELEICAO,
        SQ_CANDIDATO,
        NR_ORDEM_REDE_SOCIAL,
        DS_URL
    )
    VALUES (
        source.DT_GERACAO,
        source.HH_GERACAO,
        source.AA_ELEICAO,
        source.SG_UF,
        source.CD_TIPO_ELEICAO,
        source.NM_TIPO_ELEICAO,
        source.CD_ELEICAO,
        source.SQ_CANDIDATO,
        source.NR_ORDEM_REDE_SOCIAL,
        source.DS_URL
    );
