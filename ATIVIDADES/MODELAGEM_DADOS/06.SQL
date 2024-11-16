-- Criação da tabela Dim_Tempo
CREATE TABLE Dim_Tempo (
    ID_Tempo INT PRIMARY KEY,
    Data DATE,
    Mes INT,
    Ano INT
);

-- Criação da tabela Dim_Candidato
CREATE TABLE Dim_Candidato (
    ID_Candidato INT PRIMARY KEY,
    Nome_Candidato VARCHAR(255),
    Partido VARCHAR(255),
    Cor_Raca VARCHAR(50),
    Data_Nascimento DATE
);

-- Criação da tabela Dim_Eleicao
CREATE TABLE Dim_Eleicao (
    ID_Eleicao INT PRIMARY KEY,
    Tipo_Eleicao VARCHAR(255),
    Ano_Eleicao INT,
    Turno INT
);

-- Criação da tabela Dim_Zona
CREATE TABLE Dim_Zona (
    ID_Zona INT PRIMARY KEY,
    Municipio VARCHAR(255),
    Numero_Zona INT
);

-- Criação da tabela de Fato Eleição
CREATE TABLE Fato_Eleicao (
    ID_Eleicao INT PRIMARY KEY,
    ID_Tempo INT,
    ID_Candidato INT,
    ID_Zona INT,
    Numero_Votos INT,
    FOREIGN KEY (ID_Tempo) REFERENCES Dim_Tempo(ID_Tempo),
    FOREIGN KEY (ID_Candidato) REFERENCES Dim_Candidato(ID_Candidato),
    FOREIGN KEY (ID_Zona) REFERENCES Dim_Zona(ID_Zona)
);