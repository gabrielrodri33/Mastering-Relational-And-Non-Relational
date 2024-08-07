SET SERVEROUTPUT ON;

CREATE TABLE Automoveis (
    Codigo NUMERIC(4) PRIMARY KEY,
    Fabricante VARCHAR(20),
    Modelo VARCHAR(10),
    Ano NUMERIC(4),
    Pais VARCHAR(15),
    Preco_tabela NUMERIC(8,2)
);

CREATE TABLE Revendedoras (
    CNPJ VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(20),
    Proprietario VARCHAR(20),
    Cidade VARCHAR(15),
    Estado CHAR(2)
);

CREATE TABLE Consumidores (
    Id_Con NUMERIC(4) PRIMARY KEY,
    Nome VARCHAR(20),
    Sobrenome VARCHAR(15)
);

CREATE TABLE Negocios (
    AnoAuto NUMERIC(4),
    Data DATE,
    Preco NUMERIC(8,2),
    Comprador NUMERIC(4),
    Revenda VARCHAR(16),
    CodAuto NUMERIC(4),
    CONSTRAINT FK_Consumidores_Negocios FOREIGN KEY(Comprador) REFERENCES Consumidores(Id_Con),
    CONSTRAINT FK_Revendedoras_Negocios FOREIGN KEY(Revenda) REFERENCES Revendedoras(CNPJ),
    CONSTRAINT FK_Automoveis_Negocios FOREIGN KEY(CodAuto) REFERENCES Automoveis(Codigo)
);

CREATE TABLE Garagens (
    AnoAuto NUMERIC(4),
    Quantidade NUMERIC(4),
    CNPJRevenda VARCHAR(16),
    CodAuto NUMERIC(4),
    CONSTRAINT FK_Revendedoras_Garagens FOREIGN KEY(CNPJRevenda) REFERENCES Revendedoras(CNPJ),
    CONSTRAINT FK_Automoveis_Garagens FOREIGN KEY(CodAuto) REFERENCES Automoveis(Codigo)
);

