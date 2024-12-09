-- Dropar a tabela TIPO_BEM se existir
IF OBJECT_ID('dbo.TIPO_BEM', 'U') IS NOT NULL
    DROP TABLE dbo.TIPO_BEM;

-- Criação da tabela TIPO_BEM
CREATE TABLE TIPO_BEM (
    CD_TIPO_BEM_CANDIDATO INT PRIMARY KEY,
    DS_TIPO_BEM_CANDIDATO VARCHAR(255)
);

-- Dropar a tabela BEM_CANDIDATO se existir
IF OBJECT_ID('dbo.BEM_CANDIDATO', 'U') IS NOT NULL
    DROP TABLE dbo.BEM_CANDIDATO;

-- Criação da tabela BEM_CANDIDATO
CREATE TABLE BEM_CANDIDATO (
    SQ_CANDIDATO BIGINT,
    NR_ORDEM_BEM_CANDIDATO INT,
    CD_TIPO_BEM_CANDIDATO INT,
    DS_BEM_CANDIDATO VARCHAR(255),
    VR_BEM_CANDIDATO DECIMAL(18, 2),
    DT_ULT_ATUAL_BEM_CANDIDATO DATE,
    HH_ULT_ATUAL_BEM_CANDIDATO TIME,
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_BEM_CANDIDATO),
    FOREIGN KEY (CD_TIPO_BEM_CANDIDATO) REFERENCES TIPO_BEM(CD_TIPO_BEM_CANDIDATO),
    FOREIGN KEY (SQ_CANDIDATO) REFERENCES CANDIDATO(SQ_CANDIDATO)
);

-- Verificar se a tabela AJUSTADO existe
IF OBJECT_ID('dbo.AJUSTADO', 'U') IS NULL
BEGIN
    -- Se a tabela não existir, criá-la com todas as colunas
    CREATE TABLE AJUSTADO (
        DT_GERACAO DATE,
        HH_GERACAO TIME,
        ANO_ELEICAO INT,
        CD_TIPO_ELEICAO INT,
        NM_TIPO_ELEICAO VARCHAR(255),
        CD_ELEICAO INT,
        DS_ELEICAO VARCHAR(255),
        DT_ELEICAO DATE,
        SG_UF VARCHAR(255),
        SG_UE VARCHAR(255),
        NM_UE VARCHAR(255),
        SQ_CANDIDATO BIGINT,
        NR_ORDEM_BEM_CANDIDATO INT,
        CD_TIPO_BEM_CANDIDATO INT,
        DS_TIPO_BEM_CANDIDATO VARCHAR(255),
        DS_BEM_CANDIDATO VARCHAR(255),
        VR_BEM_CANDIDATO DECIMAL(18, 2),
        DT_ULT_ATUAL_BEM_CANDIDATO DATE,
        HH_ULT_ATUAL_BEM_CANDIDATO TIME
    );
END
ELSE
BEGIN
    -- Se a tabela existir, verificar e adicionar as colunas necessárias
    IF COL_LENGTH('dbo.AJUSTADO', 'DT_GERACAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD DT_GERACAO DATE;
    IF COL_LENGTH('dbo.AJUSTADO', 'HH_GERACAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD HH_GERACAO TIME;
    IF COL_LENGTH('dbo.AJUSTADO', 'ANO_ELEICAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD ANO_ELEICAO INT;
    IF COL_LENGTH('dbo.AJUSTADO', 'CD_TIPO_ELEICAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD CD_TIPO_ELEICAO INT;
    IF COL_LENGTH('dbo.AJUSTADO', 'NM_TIPO_ELEICAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD NM_TIPO_ELEICAO VARCHAR(255);
    IF COL_LENGTH('dbo.AJUSTADO', 'CD_ELEICAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD CD_ELEICAO INT;
    IF COL_LENGTH('dbo.AJUSTADO', 'DS_ELEICAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD DS_ELEICAO VARCHAR(255);
    IF COL_LENGTH('dbo.AJUSTADO', 'DT_ELEICAO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD DT_ELEICAO DATE;
    IF COL_LENGTH('dbo.AJUSTADO', 'SG_UF') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD SG_UF VARCHAR(255);
    IF COL_LENGTH('dbo.AJUSTADO', 'SG_UE') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD SG_UE VARCHAR(255);
    IF COL_LENGTH('dbo.AJUSTADO', 'NM_UE') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD NM_UE VARCHAR(255);
    IF COL_LENGTH('dbo.AJUSTADO', 'SQ_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD SQ_CANDIDATO BIGINT;
    IF COL_LENGTH('dbo.AJUSTADO', 'NR_ORDEM_BEM_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD NR_ORDEM_BEM_CANDIDATO INT;
    IF COL_LENGTH('dbo.AJUSTADO', 'CD_TIPO_BEM_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD CD_TIPO_BEM_CANDIDATO INT;
    IF COL_LENGTH('dbo.AJUSTADO', 'DS_TIPO_BEM_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD DS_TIPO_BEM_CANDIDATO VARCHAR(255);
    IF COL_LENGTH('dbo.AJUSTADO', 'DS_BEM_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD DS_BEM_CANDIDATO VARCHAR(255);
    IF COL_LENGTH('dbo.AJUSTADO', 'VR_BEM_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD VR_BEM_CANDIDATO DECIMAL(18, 2);
    IF COL_LENGTH('dbo.AJUSTADO', 'DT_ULT_ATUAL_BEM_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD DT_ULT_ATUAL_BEM_CANDIDATO DATE;
    IF COL_LENGTH('dbo.AJUSTADO', 'HH_ULT_ATUAL_BEM_CANDIDATO') IS NULL
        ALTER TABLE dbo.AJUSTADO ADD HH_ULT_ATUAL_BEM_CANDIDATO TIME;
END