CREATE TRIGGER AtualizarContagemFuncionarios ON Funcionarios
AFTER DELETE AS BEGIN
UPDATE Departamentos
SET ContagemFuncionarios = (
        SELECT COUNT(*)
        FROM Funcionarios
        WHERE DepartamentoID = deleted.DepartamentoID
    )
WHERE DepartamentoID = deleted.DepartamentoID;
END;