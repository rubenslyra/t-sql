CREATE TRIGGER AumentoSalario ON Funcionarios
AFTER
UPDATE AS BEGIN
UPDATE s
SET s.Valor = s.Valor * 1.10
FROM Salarios s
    INNER JOIN inserted i ON s.FuncionarioID = i.FuncionarioID;
END;