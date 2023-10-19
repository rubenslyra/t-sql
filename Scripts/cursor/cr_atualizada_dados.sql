DECLARE @FuncionarioID INT;
DECLARE @NovoSalario DECIMAL(10, 2);
DECLARE atualizacao_cursor CURSOR FOR
SELECT FuncionarioID,
    NovoSalario
FROM AtualizacaoSalario;
OPEN atualizacao_cursor;
FETCH NEXT
FROM atualizacao_cursor INTO @FuncionarioID,
    @NovoSalario;
WHILE @@FETCH_STATUS = 0 BEGIN
UPDATE Funcionarios
SET Salario = @NovoSalario
WHERE FuncionarioID = @FuncionarioID;
FETCH NEXT
FROM atualizacao_cursor INTO @FuncionarioID,
    @NovoSalario;
END;
CLOSE atualizacao_cursor;
DEALLOCATE atualizacao_cursor;