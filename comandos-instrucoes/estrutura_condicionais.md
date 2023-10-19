Você pode usar `IF...ELSE` para controlar a lógica das transações e do contador de commits.Aqui está um exemplo de como fazer isso: ```sql
-- Variável para controle de contador de commits
DECLARE @ContadorCommits INT;
SET @ContadorCommits = 0;

-- Iniciar uma transação externa
BEGIN TRANSACTION; 

-- Variável para controle de @@TRANCOUNT
DECLARE @TransCount INT;

-- Inicializar o controle de @@TRANCOUNT
SET @TransCount = @@TRANCOUNT;

-- Verificar se há uma transação em execução
IF @TransCount = 0
BEGIN
    PRINT 'Iniciando uma nova transação externa.';
    -- Iniciar a transação externa
    BEGIN TRANSACTION;
END
ELSE
BEGIN
    PRINT 'Transação externa já em andamento.';
END

-- Iniciar uma transação interna
BEGIN TRANSACTION;

-- Simulação de operações dentro da transação interna
PRINT 'Operações dentro da transação interna.';

-- Confirmar a transação interna
COMMIT;
SET @ContadorCommits = @ContadorCommits + 1;

-- Verificar se é a transação externa para confirmar
IF @TransCount = 0
BEGIN
    PRINT 'Confirmar a transação externa.';
    -- Confirmar a transação externa
    COMMIT;
    SET @ContadorCommits = @ContadorCommits + 1;
END
ELSE
BEGIN
    PRINT 'Transação externa não pode ser confirmada internamente.';
    -- Reverter a transação interna em caso de erro
    ROLLBACK;
    PRINT 'Transação interna revertida devido a um erro.';
END

-- Imprimir o número de commits realizados
PRINT 'Número total de commits realizados: ' + CAST(@ContadorCommits AS NVARCHAR);
``` Neste exemplo,
estamos usando `IF...ELSE` para controlar a confirmação ou reversão das transações internas e externas.Se houver um erro,
a transação interna é revertida e uma mensagem é impressa.No final,
exibimos o número total de commits realizados.

------

Você pode usar estruturas de controle como loops e condicionais para controlar a lógica das transações e do contador de commits. Aqui está um exemplo que utiliza um loop `WHILE` e estruturas condicionais `IF...ELSE` para fazer isso:

```sql
-- Variável para controle de contador de commits
DECLARE @ContadorCommits INT;
SET @ContadorCommits = 0;

-- Iniciar uma transação externa
BEGIN TRANSACTION; 

-- Variável para controle de @@TRANCOUNT
DECLARE @TransCount INT;

-- Inicializar o controle de @@TRANCOUNT
SET @TransCount = @@TRANCOUNT;

-- Verificar se há uma transação em execução
IF @TransCount = 0
BEGIN
    PRINT 'Iniciando uma nova transação externa.';
    -- Iniciar a transação externa
    BEGIN TRANSACTION;
END
ELSE
BEGIN
    PRINT 'Transação externa já em andamento.';
END

-- Iniciar uma transação interna
BEGIN TRANSACTION;

-- Simulação de operações dentro da transação interna
DECLARE @Operacao INT = 1;
WHILE @Operacao <= 5
BEGIN
    PRINT 'Executando operação ' + CAST(@Operacao AS NVARCHAR) + ' dentro da transação interna.';
    
    -- Simular um erro na operação 3
    IF @Operacao = 3
    BEGIN
        PRINT 'Erro na operação ' + CAST(@Operacao AS NVARCHAR) + '. Revertendo a transação interna.';
        -- Reverter a transação interna em caso de erro
        ROLLBACK;
        PRINT 'Transação interna revertida devido a um erro.';
        SET @ContadorCommits = @ContadorCommits - 1;
        BREAK;  -- Sair do loop
    END
    
    -- Confirmar a transação interna
    COMMIT;
    SET @ContadorCommits = @ContadorCommits + 1;
    
    SET @Operacao = @Operacao + 1;
END

-- Verificar se é a transação externa para confirmar
IF @TransCount = 0
BEGIN
    PRINT 'Confirmar a transação externa.';
    -- Confirmar a transação externa
    COMMIT;
    SET @ContadorCommits = @ContadorCommits + 1;
END
ELSE
BEGIN
    PRINT 'Transação externa não pode ser confirmada internamente.';
END

-- Imprimir o número de commits realizados
PRINT 'Número total de commits realizados: ' + CAST(@ContadorCommits AS NVARCHAR);
```

Neste exemplo, usamos um loop `WHILE` para simular várias operações dentro da transação interna. Utilizamos a estrutura condicional `IF...ELSE` para verificar se ocorre um erro durante a operação e, em caso de erro, revertemos a transação interna. O contador de commits é atualizado conforme necessário. No final, o número total de commits realizados é impresso.