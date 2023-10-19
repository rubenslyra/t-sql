-- Usar o banco de dados "empresa"
USE empresa;
-- Inserir 250 registros fictícios na tabela "Funcionarios"
DECLARE @i INT = 1;
WHILE @i <= 250 BEGIN
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
        'Funcionario' + CAST(@i AS NVARCHAR(10)),
        'Sobrenome' + CAST(@i AS NVARCHAR(10)),
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