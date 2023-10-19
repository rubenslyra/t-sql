CREATE TRIGGER VerificarDuplicatas ON Funcionarios BEFORE
INSERT AS BEGIN IF EXISTS (
        SELECT 1
        FROM Funcionarios f
            INNER JOIN inserted i ON f.Nome = i.Nome
            AND f.Sobrenome = i.Sobrenome
    ) BEGIN RAISEERROR(
        'Já existe um funcionário com o mesmo nome e sobrenome.',
        16,
        1
    );
ROLLBACK;
END
END;