Exemplo simples:

Eu criaria 2 Stored Procedure para a Tabela User, e carregaria dentro do Entity Framework.

```sqlserver
Create Table User

CREATE TABLE [dbo].[User](
    [UserId] [int] IDENTITY(1,1) NOT NULL,
    [UserName] [varchar](50) NULL,
    [Password] [varbinary](128) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
    [UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
Stored Procedure

CREATE PROCEDURE SP_Insert_User 
(
    @UserName varchar(50),
    @Password varchar(30)
)
AS
BEGIN
    INSERT INTO [User]([UserName], [Password]) VALUES(@UserName, PWDENCRYPT(@Password));
    SELECT [UserId], [UserName], [Password] FROM [User] WHERE [UserId] = @@IDENTITY;
END

CREATE PROCEDURE SP_User_Verify
(   
    @UserName varchar(50),
    @Password varchar(30)
)
AS
BEGIN
    SELECT * FROM [User] WHERE [User].[UserName] = @UserName AND 
                               PWDCOMPARE(@Password,[User].[Password]) = 1
END
A SP_Insert_User para inserir novos usuários e a SP_User_Verify para verificar a existência do usuário com o retorno dos seus dados.

No seu Model importo as duas Stored Procedure dessa maneira
![O1JIg](https://github.com/rubenslyra/t-sql/assets/37023108/2f8201d4-b76f-40e8-bab1-166417460718)
```
Escolha as duas com os respectivos nomes que dentro do Contexto será criado duas functions de retorno dessa maneira:

```csharp
public partial class ObjEntities : DbContext
{
    public ObjEntities()
        : base("name=ObjEntities") { }

    public DbSet<User> User { get; set; }   
    public virtual ObjectResult<SP_Insert_User_Result> SP_Insert_User(string userName, string password)
    {
        var userNameParameter = userName != null ?
            new ObjectParameter("UserName", userName) :
            new ObjectParameter("UserName", typeof(string));

        var passwordParameter = password != null ?
            new ObjectParameter("Password", password) :
            new ObjectParameter("Password", typeof(string));

        return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP_Insert_User_Result>("SP_Insert_User", userNameParameter, passwordParameter);
    }
    public virtual ObjectResult<SP_User_Verify_Result> SP_User_Verify(string userName, string password)
    {
        var userNameParameter = userName != null ?
            new ObjectParameter("UserName", userName) :
            new ObjectParameter("UserName", typeof(string));

        var passwordParameter = password != null ?
            new ObjectParameter("Password", password) :
            new ObjectParameter("Password", typeof(string));

        return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP_User_Verify_Result>("SP_User_Verify", userNameParameter, passwordParameter);
    }
}
```

Como usar:

```csharp
class Program
{
    static void Main(string[] args)
    {
        using (ObjEntities cx = new ObjEntities())
        {
            SP_User_Verify_Result user = ValidateUser("USUARIO2", "SENHA2", cx);
        }
    }
    public static SP_User_Verify_Result ValidateUser(string UserName, string Password, ObjEntities cx)
    {
        return cx.SP_User_Verify(UserName, Password).FirstOrDefault<SP_User_Verify_Result>();
    }
}
```

Debug:

![DSSgV](https://github.com/rubenslyra/t-sql/assets/37023108/c3abf148-90d0-44c8-b1f8-a9dc858469a2)

Se nessa linha SP_User_Verify_Result user = ValidateUser("USUARIO2", "SENHA2", cx); a variável user for null, então, não foi encontrado o usuário, consequentemente, usuário não autorizado.


