CREATE TRIGGER RestricaoNivelAcesso ON Funcionarios BEFORE
UPDATE AS BEGIN IF EXISTS (
        SELECT 1
        FROM inserted i
            JOIN deleted d ON i.FuncionarioID = d.FuncionarioID
        WHERE i.NivelAcessoID < d.NivelAcessoID
    ) BEGIN RAISEERROR(
        'Você não tem permissão para aumentar o nível de acesso.',
        16,
        1
    );
ROLLBACK;
END
END;