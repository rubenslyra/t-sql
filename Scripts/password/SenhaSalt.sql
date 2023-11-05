-- Crie uma função para gerar um salt aleatório
CREATE FUNCTION dbo.GenerateSalt(@length INT)
RETURNS NVARCHAR(255)
AS
BEGIN
  DECLARE @salt NVARCHAR(255) = '';
  DECLARE @characters NVARCHAR(255) = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  DECLARE @index INT = 1;

  WHILE @index <= @length
  BEGIN
    SET @salt = @salt + SUBSTRING(@characters, CAST(CEILING(RAND() * LEN(@characters)) AS INT), 1);
    SET @index = @index + 1;
  END

  RETURN @salt;
END;
GO

-- Crie uma função para criar senhas com criptografia e salt
CREATE FUNCTION dbo.HashWithSalt(@password NVARCHAR(255), @salt NVARCHAR(255))
RETURNS VARBINARY(64) -- SHA-512 hash
AS
BEGIN
  DECLARE @saltedPassword NVARCHAR(255) = @password + @salt;
  DECLARE @hash VARBINARY(64);
  
  SET @hash = HASHBYTES('SHA2_512', @saltedPassword);

  RETURN @hash;
END;
GO
