-- Verificar se a tabela REDE_SOCIAL existe
IF OBJECT_ID('dbo.REDE_SOCIAL', 'U') IS NULL
BEGIN
    -- Criar a tabela REDE_SOCIAL
    CREATE TABLE REDE_SOCIAL (
        DT_GERACAO DATE,
        HH_GERACAO TIME,
        AA_ELEICAO INT,
        SG_UF VARCHAR(2),
        CD_TIPO_ELEICAO INT,
        NM_TIPO_ELEICAO VARCHAR(255),
        CD_ELEICAO INT,
        SQ_CANDIDATO BIGINT,
        NR_ORDEM_REDE_SOCIAL INT,
        DS_URL VARCHAR(255),
        PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL),
        FOREIGN KEY (SG_UF, NM_UE) REFERENCES UF(SG_UF, NM_UE),
        FOREIGN KEY (CD_TIPO_ELEICAO) REFERENCES TIPO_ELEICAO(CD_TIPO_ELEICAO),
        FOREIGN KEY (CD_ELEICAO) REFERENCES ELEICAO(CD_ELEICAO),
        FOREIGN KEY (SQ_CANDIDATO) REFERENCES CANDIDATO(SQ_CANDIDATO)
    );
END;

-- Verificar se a tabela TIPO_REDE_SOCIAL existe
IF OBJECT_ID('dbo.TIPO_REDE_SOCIAL', 'U') IS NULL
BEGIN
    -- Criar a tabela TIPO_REDE_SOCIAL
    CREATE TABLE TIPO_REDE_SOCIAL (
        CD_TIPO_REDE_SOCIAL INT PRIMARY KEY,
        DS_TIPO_REDE_SOCIAL VARCHAR(255)
    );
END;

-- Verificar se a tabela AJUSTADO existe
IF OBJECT_ID('dbo.AJUSTADO', 'U') IS NULL
BEGIN
    -- Criar a tabela AJUSTADO
    CREATE TABLE AJUSTADO (
        DT_GERACAO DATE,
        HH_GERACAO TIME,
        ANO_ELEICAO INT,
        CD_TIPO_ELEICAO INT,
        NM_TIPO_ELEICAO VARCHAR(255),
        CD_ELEICAO INT,
        DS_ELEICAO VARCHAR(255),
        DT_ELEICAO DATE,
        SG_UF VARCHAR(2),
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
        ALTER TABLE dbo.AJUSTADO ADD SG_UF VARCHAR(2);
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
END;