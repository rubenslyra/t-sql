CREATE TRIGGER CriarContaUsuario ON Funcionarios
AFTER
INSERT AS BEGIN -- Código para criar um registro de usuário externo
INSERT INTO UsuariosExternos (NomeUsuario, Email, Senha)
SELECT 'user_' + CONVERT(NVARCHAR, i.FuncionarioID),
    i.Email,
    'senha_gerada'
FROM inserted i;
END;
/** 
 -- Exemplo em Python (requer uma biblioteca para fazer chamadas de API)
 
 import requests
 
 def criar_conta_usuario(nome, sobrenome, email):
 url = 'https://api.externa.com/criar-usuario'
 dados = {
 'nome': nome,
 'sobrenome': sobrenome,
 'email': email
 }
 resposta = requests.post(url, json=dados)
 
 CREATE TRIGGER CriarContaUsuario
 ON Funcionarios    
 AFTER INSERT
 AS
 BEGIN
 -- Chamar a função para criar um usuário no sistema externo
 EXEC criar_conta_usuario(i.Nome, i.Sobrenome, i.Email)
 FROM inserted i;
 END;
 
 */