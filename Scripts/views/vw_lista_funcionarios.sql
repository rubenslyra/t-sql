CREATE VIEW ListaFuncionarios AS
SELECT f.FuncionarioID,
    f.Nome,
    f.Sobrenome,
    c.NomeCargo AS Cargo,
    na.Nivel AS NivelAcesso
FROM Funcionarios f
    INNER JOIN Cargos c ON f.CargoID = c.CargoID
    INNER JOIN NiveisAcesso na ON f.NivelAcessoID = na.NivelID;