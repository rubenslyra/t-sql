-- Usar o banco de dados "empresa"
USE empresa;
-- Inserir 250 registros fictícios na tabela "Funcionarios" com nomes fictícios
DECLARE @i INT = 1;
WHILE @i <= 250 BEGIN
DECLARE @Nome NVARCHAR(50);
DECLARE @Sobrenome NVARCHAR(50);
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