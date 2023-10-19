-- Cria o banco de dados "empresa" se ele não existir
IF NOT EXISTS (
    SELECT name
    FROM master.dbo.sysdatabases
    WHERE name = 'empresa'
) CREATE DATABASE empresa;
GO -- Usa o banco de dados "empresa"
    USE empresa;
GO -- Cria a tabela "Cargos" para armazenar informações sobre as funções dos funcionários
    CREATE TABLE Cargos (
        CargoID INT PRIMARY KEY,
        NomeCargo NVARCHAR(50)
    );
-- Cria a tabela "NiveisAcesso" para armazenar informações sobre os níveis de acesso
CREATE TABLE NiveisAcesso (
    NivelID INT PRIMARY KEY,
    NomeNivel NVARCHAR(50)
);
-- Cria a tabela "Funcionarios" para armazenar informações sobre os funcionários
CREATE TABLE Funcionarios (
    FuncionarioID INT PRIMARY KEY,
    Nome NVARCHAR(50),
    Sobrenome NVARCHAR(50),
    DataNascimento DATE,
    CargoID INT,
    NivelAcessoID INT,
    FOREIGN KEY (CargoID) REFERENCES Cargos (CargoID),
    FOREIGN KEY (NivelAcessoID) REFERENCES NiveisAcesso (NivelID)
);
-- Cria a tabela "Horarios" para armazenar informações sobre os horários dos funcionários
CREATE TABLE Horarios (
    HorarioID INT PRIMARY KEY,
    HorarioEntrada TIME,
    HorarioSaida TIME
);
-- Cria a tabela "Salarios" para armazenar informações sobre os salários dos funcionários
CREATE TABLE Salarios (
    SalarioID INT PRIMARY KEY,
    Valor MONEY,
    FuncionarioID INT,
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios (FuncionarioID)
);
-- Inserir dados fictícios
-- Inserir dados na tabela "Cargos"
INSERT INTO Cargos (CargoID, NomeCargo)
VALUES (1, 'Gerente'),
    (2, 'Desenvolvedor'),
    (3, 'Designer'),
    (4, 'Analista');
-- Inserir dados na tabela "NiveisAcesso"
INSERT INTO NiveisAcesso (NivelID, NomeNivel)
VALUES (1, 'Administrador'),
    (2, 'Usuário Avançado'),
    (3, 'Usuário Básico');
-- Inserir dados na tabela "Funcionarios" para 100 funcionários fictícios
-- Certifique-se de ajustar os dados de acordo com suas necessidades
-- Aqui, estou usando uma abordagem simples com nomes de funcionários gerados aleatoriamente
DECLARE @i INT = 1;
WHILE @i <= 100 BEGIN
INSERT INTO Funcionarios (
        FuncionarioID,
        Nome,
        Sobrenome,
        DataNascimento,
        CargoID,
        NivelAcessoID
    )
VALUES (
        @i,
        'Funcionario',
        'Sobrenome' + CAST(@i AS NVARCHAR(10)),
        DATEADD(YEAR, -25, GETDATE()),
        (
            SELECT TOP 1 CargoID
            FROM Cargos
            ORDER BY NEWID()
        ),
        (
            SELECT TOP 1 NivelID
            FROM NiveisAcesso
            ORDER BY NEWID()
        )
    );
SET @i = @i + 1;
END;
-- Inserir dados na tabela "Horarios"
INSERT INTO Horarios (HorarioID, HorarioEntrada, HorarioSaida)
VALUES (1, '08:00:00', '17:00:00'),
    (2, '09:00:00', '18:00:00'),
    (3, '10:00:00', '19:00:00');
-- Inserir dados na tabela "Salarios" com valores aleatórios
DECLARE @j INT = 1;
WHILE @j <= 100 BEGIN
INSERT INTO Salarios (SalarioID, Valor, FuncionarioID)
VALUES (@j, CAST((RAND() * 10000 + 30000) AS MONEY), @j);
SET @j = @j + 1;
END;