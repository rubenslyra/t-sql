## Modelo Entidade-Relacionamento (MER):

1. **Entidade "Funcionarios"**
   - Atributos: FuncionarioID (Chave Primária), Nome, Sobrenome, DataNascimento, CargoID (Chave Estrangeira), NivelAcessoID (Chave Estrangeira), PredecessorID (Chave Estrangeira)

2. **Entidade "Cargos"**
   - Atributos: CargoID (Chave Primária), NomeCargo

3. **Entidade "NiveisAcesso"**
   - Atributos: NivelID (Chave Primária), NomeNivel

4. **Entidade "Salarios"**
   - Atributos: SalarioID (Chave Primária), FuncionarioID (Chave Estrangeira), Valor

5. **Entidade "Departamentos"**
   - Atributos: DepartamentoID (Chave Primária), NomeDepartamento

6. **Entidade "LogInsercoesFuncionarios"**
   - Atributos: LogID (Chave Primária), DataHora, Usuario, NomeFuncionario

7. **Entidade "AuditoriaSalario"**
   - Atributos: AuditoriaID (Chave Primária), FuncionarioID (Chave Estrangeira), DataAlteracao, SalarioAnterior, SalarioNovo

**Diagrama de Entidade-Relacionamento (DER):**

Aqui está uma representação visual simplificada do DER com base no MER acima:


![DER](./assets/img/diagrama_der.svg)
