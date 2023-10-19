-- Usar o banco de dados "empresa"
USE empresa;
-- Iniciar a transação
BEGIN TRANSACTION;
DECLARE @i INT = 1;
DECLARE @ErrorOccurred BIT = 0;
BEGIN TRY WHILE @i <= 500 BEGIN
DECLARE @Nome NVARCHAR(50);
DECLARE @Sobrenome NVARCHAR(50);
DECLARE @DataNascimento DATE;
DECLARE @CargoID INT;
DECLARE @NivelAcessoID INT;
DECLARE @PredecessorID INT;
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
-- Selecionar um predecessor aleatório entre 1 e @i - 1
SET @PredecessorID = (
        SELECT TOP 1 FuncionarioID
        FROM Funcionarios
        WHERE FuncionarioID < @i
        ORDER BY NEWID()
    );
-- Inserir o registro
INSERT INTO Funcionarios (
        FuncionarioID,
        Nome,
        Sobrenome,
        DataNascimento,
        CargoID,
        NivelAcessoID,
        PredecessorID
    )
VALUES (
        @i,
        @Nome,
        @Sobrenome,
        @DataNascimento,
        @CargoID,
        @NivelAcessoID,
        @PredecessorID
    );
SET @i = @i + 1;
END;
END TRY BEGIN CATCH -- Em caso de erro, defina a variável @ErrorOccurred para 1
SET @ErrorOccurred = 1;
END CATCH;
-- Finalizar a transação
IF @ErrorOccurred = 0 COMMIT;
ELSE ROLLBACK;