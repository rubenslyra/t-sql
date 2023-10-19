CREATE VIEW SalariosFuncionarios AS
SELECT f.FuncionarioID,
    f.Nome,
    f.Sobrenome,
    s.Valor AS Salario
FROM Funcionarios f
    INNER JOIN Salarios s ON f.FuncionarioID = s.FuncionarioID;