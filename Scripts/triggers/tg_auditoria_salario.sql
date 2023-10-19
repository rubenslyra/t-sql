CREATE TRIGGER AuditoriaSalario ON Salarios
AFTER
UPDATE AS BEGIN
INSERT INTO AuditoriaSalario (
        FuncionarioID,
        DataAlteracao,
        SalarioAnterior,
        SalarioNovo
    )
SELECT d.FuncionarioID,
    GETDATE(),
    d.Valor,
    i.Valor
FROM deleted d
    JOIN inserted i ON d.FuncionarioID = i.FuncionarioID
WHERE d.Valor <> i.Valor;
END;