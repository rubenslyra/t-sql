-- Usar o banco de dados "empresa"
USE empresa;
-- Iniciar uma transação
BEGIN TRANSACTION;
-- Variáveis para os dados a serem inseridos
DECLARE @NomeFuncionario NVARCHAR(50) = 'John';
DECLARE @SobrenomeFuncionario NVARCHAR(50) = 'Doe';
DECLARE @CargoFuncionario NVARCHAR(50) = 'Analista';
DECLARE @NivelAcessoFuncionario INT = 2;
-- Inserir o funcionário na tabela "Funcionarios"
INSERT INTO Funcionarios (Nome, Sobrenome, CargoID, NivelAcessoID)
VALUES (
        @NomeFuncionario,
        @SobrenomeFuncionario,
        (
            SELECT CargoID
            FROM Cargos
            WHERE NomeCargo = @CargoFuncionario
        ),
        @NivelAcessoFuncionario
    );
-- Variáveis para os dados a serem inseridos na tabela "Salarios"
DECLARE @FuncionarioID INT = @@IDENTITY;
-- Obtém o ID do funcionário inserido
DECLARE @SalarioFuncionario DECIMAL(10, 2) = 50000.00;
-- Inserir o salário do funcionário na tabela "Salarios"
INSERT INTO Salarios (FuncionarioID, Valor)
VALUES (@FuncionarioID, @SalarioFuncionario);
-- Verificar se as inserções foram bem-sucedidas
IF @@ERROR = 0 BEGIN -- Confirmar a transação se tudo estiver bem
COMMIT;
END
ELSE BEGIN -- Reverter a transação em caso de erro
ROLLBACK;
END;