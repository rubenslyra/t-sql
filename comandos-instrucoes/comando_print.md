Os comandos `PRINT` são úteis para exibir mensagens ou valores durante a execução de scripts SQL, facilitando a depuração e o entendimento do que está acontecendo. Aqui estão alguns exemplos de como usar o `PRINT` em scripts SQL:

**Exemplo 1: Imprimir uma mensagem simples:**

```sql
PRINT 'Isso é um exemplo de mensagem simples.';
```

Neste exemplo, uma mensagem simples será exibida no console do SQL Server Management Studio ou na ferramenta que você estiver usando.

**Exemplo 2: Imprimir o valor de uma variável:**

```sql
DECLARE @Nome NVARCHAR(50) = 'Alice';
PRINT 'O valor da variável @Nome é: ' + @Nome;
```

Neste exemplo, estamos imprimindo o valor da variável `@Nome`. Isso é útil para depurar e verificar o valor das variáveis em seu script.

**Exemplo 3: Imprimir resultados de uma consulta:**

```sql
DECLARE @TotalFuncionarios INT;
SELECT @TotalFuncionarios = COUNT(*) FROM Funcionarios;
PRINT 'O total de funcionários na tabela Funcionarios é: ' + CAST(@TotalFuncionarios AS NVARCHAR);
```

Neste exemplo, estamos contando o número de funcionários na tabela "Funcionarios" e imprimindo o resultado. Usamos `CAST` para converter o valor em uma representação de string para que possa ser impresso.

**Exemplo 4: Imprimir valores em um cursor:**

```sql
DECLARE @NomeFuncionario NVARCHAR(50);

DECLARE funcionario_cursor CURSOR FOR
SELECT Nome
FROM Funcionarios;

OPEN funcionario_cursor;

FETCH NEXT FROM funcionario_cursor INTO @NomeFuncionario;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Nome do Funcionário: ' + @NomeFuncionario;
    FETCH NEXT FROM funcionario_cursor INTO @NomeFuncionario;
END;

CLOSE funcionario_cursor;
DEALLOCATE funcionario_cursor;
```

Neste exemplo, estamos usando um cursor para percorrer os nomes dos funcionários e imprimir cada nome.

Os comandos `PRINT` são úteis para depurar, registrar informações e fornecer feedback durante a execução de scripts SQL. Eles ajudam a entender o que está acontecendo e a identificar possíveis problemas em seus scripts.