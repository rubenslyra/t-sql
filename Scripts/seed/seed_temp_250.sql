-- Usar o banco de dados "empresa"
USE empresa;
-- Tabelas temporárias para nomes e sobrenomes fictícios
CREATE TABLE #Nomes (
NomeID INT PRIMARY KEY,
Nome NVARCHAR(50)
);
CREATE TABLE #Sobrenomes (
SobrenomeID INT PRIMARY KEY,
Sobrenome NVARCHAR(50)
);
-- Preencher tabelas temporárias com nomes e sobrenomes fictícios
INSERT INTO #Nomes (Nome)
VALUES ('Alice'),
    ('Bob'),
    ('Charlie'),
    ('David'),
    ('Emma'),
    ('Fiona'),
    ('George'),
    ('Hannah'),
    ('Ivy'),
    ('Jack'),
    ('Katherine'),
    ('Liam'),
    ('Mia'),
    ('Noah'),
    ('Olivia'),
    ('Peter'),
    ('Quinn'),
    ('Rachel'),
    ('Samuel'),
    ('Tina'),
    ('Ursula'),
    ('Vincent'),
    ('Wendy'),
    ('Xander'),
    ('Yasmine'),
    ('Zachary');
INSERT INTO #Sobrenomes (Sobrenome)
VALUES ('Smith'),
    ('Johnson'),
    ('Brown'),
    ('Wilson'),
    ('Lee'),
    ('Davis'),
    ('Moore'),
    ('White'),
    ('Adams'),
    ('Hall'),
    ('Parker'),
    ('Taylor'),
    ('Evans'),
    ('Clark'),
    ('Martin'),
    ('Harris'),
    ('Lewis'),
    ('Young'),
    ('Scott'),
    ('Walker'),
    ('King'),
    ('Hill'),
    ('Roberts'),
    ('Turner'),
    ('Wright'),
    ('Mitchell');
-- Inserir 250 registros fictícios na tabela "Funcionarios" com nomes aleatórios
DECLARE @i INT = 1;
WHILE @i <= 250 BEGIN
DECLARE @NomeAleatorio NVARCHAR(50);
DECLARE @SobrenomeAleatorio NVARCHAR(50);
SELECT TOP 1 @NomeAleatorio = Nome
FROM #Nomes ORDER BY NEWID();
SELECT TOP 1 @SobrenomeAleatorio = Sobrenome
FROM #Sobrenomes ORDER BY NEWID();
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
        @NomeAleatorio,
        @SobrenomeAleatorio,
        DATEADD(DAY, - @i, GETDATE()),
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
-- Limpar tabelas temporárias
DROP TABLE #Nomes;
DROP TABLE #Sobrenomes;