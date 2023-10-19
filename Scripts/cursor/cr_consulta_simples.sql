-- Declarar variáveis do cursor
DECLARE @NomeFuncionario NVARCHAR(50);
-- Declarar e abrir o cursor
DECLARE funcionario_cursor CURSOR FOR
SELECT Nome
FROM Funcionarios;
-- Abrir o cursor
OPEN funcionario_cursor;
-- Inicializar a variável
FETCH NEXT
FROM funcionario_cursor INTO @NomeFuncionario;
-- Loop para percorrer os resultados
WHILE @@FETCH_STATUS = 0 BEGIN PRINT 'Nome do Funcionário: ' + @NomeFuncionario;
FETCH NEXT
FROM funcionario_cursor INTO @NomeFuncionario;
END;
-- Fechar o cursor
CLOSE funcionario_cursor;
-- Desalocar o cursor
DEALLOCATE funcionario_cursor;