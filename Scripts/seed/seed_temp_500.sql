-- Usar o banco de dados "empresa"
USE empresa;
-- Inserir 500 registros fictícios na tabela "Funcionarios" com detalhes completos
DECLARE @i INT = 1;
WHILE @i <= 500 BEGIN
DECLARE @Nome NVARCHAR(50);
DECLARE @Sobrenome NVARCHAR(50);
DECLARE @DataNascimento DATE;
DECLARE @CargoID INT;
DECLARE @NivelAcessoID INT;
-- Gerar nomes fictícios aleatórios
SET @Nome = (
        SELECT TOP 1 Nome
        FROM (
                SELECT 'Alice' AS Nome
                UNION ALL
                SELECT 'Bob'
                UNION ALL
                SELECT 'Charlie'
                UNION ALL
                SELECT 'David'
                UNION ALL
                SELECT 'Emma' -- Adicione mais nomes aqui
            ) AS Nomes
        ORDER BY NEWID()
    );
-- Gerar sobrenomes fictícios aleatórios
SET @Sobrenome = (
        SELECT TOP 1 Sobrenome
        FROM (
                SELECT 'Smith' AS Sobrenome
                UNION ALL
                SELECT 'Johnson'
                UNION ALL
                SELECT 'Brown'
                UNION ALL
                SELECT 'Wilson'
                UNION ALL
                SELECT 'Lee' -- Adicione mais sobrenomes aqui
            ) AS Sobrenomes
        ORDER BY NEWID()
    );
-- Gerar datas de nascimento fictícias aleatórias entre 1970 e 2000
SET @DataNascimento = DATEFROMPARTS(
        1970 + (ABS(CHECKSUM(NEWID())) % 31),
        1 + (ABS(CHECKSUM(NEWID())) % 12),
        1 + (ABS(CHECKSUM(NEWID())) % 30)
    );
-- Selecionar cargos e níveis de acesso aleatórios
SET @CargoID = (
        SELECT TOP 1 CargoID
        FROM Cargos
        ORDER BY NEWID()
    );
SET @NivelAcessoID = (
        SELECT TOP 1 NivelID
        FROM NiveisAcesso
        ORDER BY NEWID()
    );
-- Inserir o registro
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
        @Nome,
        @Sobrenome,
        @DataNascimento,
        @CargoID,
        @NivelAcessoID
    );
SET @i = @i + 1;
END;