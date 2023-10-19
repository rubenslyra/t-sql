CREATE TRIGGER RestricaoExclusaoGerentes ON Funcionarios BEFORE DELETE AS BEGIN IF EXISTS (
    SELECT 1
    FROM deleted d
    WHERE EXISTS (
            SELECT 1
            FROM Funcionarios f
            WHERE f.PredecessorID = d.FuncionarioID
        )
) BEGIN RAISEERROR(
    'Você não pode excluir um funcionário que é gerente de outros funcionários.',
    16,
    1
);
ROLLBACK;
END;
END;