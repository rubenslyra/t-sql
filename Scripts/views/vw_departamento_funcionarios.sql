CREATE VIEW FuncionariosPorDepartamento AS
SELECT d.NomeDepartamento AS Departamento,
    f.FuncionarioID,
    f.Nome,
    f.Sobrenome
FROM Funcionarios f
    INNER JOIN Departamentos d ON f.DepartamentoID = d.DepartamentoID;