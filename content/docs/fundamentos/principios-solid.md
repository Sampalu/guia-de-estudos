---
title: "SOLID"
date: 2025-02-02T12:00:00-03:00
draft: false
---

Os princípios **S.O.L.I.D.** são um conjunto de diretrizes para escrever código mais organizado, modular e de fácil manutenção. Eles foram definidos por **Robert C. Martin (Uncle Bob)** e são amplamente utilizados em **arquitetura de software e desenvolvimento orientado a objetos**.

---

## 1. **S**ingle Responsibility Principle (SRP) – Princípio da Responsabilidade Única  

### Definição:
Uma classe deve ter **apenas um motivo para mudar**, ou seja, deve ter **uma única responsabilidade**.

### Explicação:
Se uma classe tem **múltiplas responsabilidades**, mudanças em uma delas podem **afetar indevidamente** as outras, tornando o código frágil e difícil de modificar.

### Exemplo **(Violando SRP)**:
```csharp
public class Relatorio
{
    public void GerarPDF() { /* Gera um relatório em PDF */ }
    public void SalvarBancoDados() { /* Salva o relatório no banco */ }
}
```
Aqui, a classe `Relatorio` tem duas responsabilidades:  
1. Gerar um PDF  
2. Salvar no banco de dados  

Isso viola o SRP, pois mudanças na lógica de geração de PDF podem impactar a lógica de persistência no banco.

### Exemplo **(Aplicando SRP)**:
```csharp
public class GeradorRelatorio
{
    public void GerarPDF() { /* Gera um relatório em PDF */ }
}

public class RelatorioRepositorio
{
    public void SalvarBancoDados() { /* Salva o relatório no banco */ }
}
```
Agora temos **duas classes independentes**, cada uma com sua responsabilidade.

---

## 2. **O**pen/Closed Principle (OCP) – Princípio do Aberto/Fechado  

### Definição:
Um **módulo, classe ou função** deve estar **aberto para extensão, mas fechado para modificação**.

### Explicação:
Isso significa que devemos **evitar modificar código existente** para adicionar novas funcionalidades. Em vez disso, devemos permitir a **extensão** do código sem alterá-lo diretamente.

### Exemplo **(Violando OCP)**:
```csharp
public class CalculadoraSalario
{
    public double CalcularSalario(string tipoFuncionario, double salarioBase)
    {
        if (tipoFuncionario == "Gerente")
            return salarioBase * 1.5;
        else if (tipoFuncionario == "Desenvolvedor")
            return salarioBase * 1.2;
        return salarioBase;
    }
}
```
Cada vez que um novo tipo de funcionário for adicionado, será necessário modificar `CalculadoraSalario`, quebrando OCP.

### Exemplo **(Aplicando OCP - Usando Polimorfismo)**:
```csharp
public abstract class Funcionario
{
    public abstract double CalcularSalario(double salarioBase);
}

public class Gerente : Funcionario
{
    public override double CalcularSalario(double salarioBase) => salarioBase * 1.5;
}

public class Desenvolvedor : Funcionario
{
    public override double CalcularSalario(double salarioBase) => salarioBase * 1.2;
}
```
Agora podemos adicionar novos tipos de funcionários sem modificar a classe principal.

---

## 3. **L**iskov Substitution Principle (LSP) – Princípio da Substituição de Liskov  

### Definição:
Se uma classe `B` é uma **subclasse** de `A`, então `B` deve poder **substituir `A` sem alterar o comportamento esperado do programa**.

### Explicação:
Esse princípio garante que **o código que usa uma classe base possa funcionar com suas subclasses sem problemas**.

### Exemplo **(Violando LSP)**:
```csharp
public class Pato
{
    public virtual void Voar() => Console.WriteLine("O pato está voando!");
}

public class PatoDeBorracha : Pato
{
    public override void Voar() => throw new Exception("Patos de borracha não voam!");
}
```
Se um código espera um `Pato`, mas recebe um `PatoDeBorracha`, ele pode quebrar, pois `PatoDeBorracha` lança uma exceção ao tentar voar.

### Exemplo **(Aplicando LSP)**:
```csharp
public abstract class Pato
{
    public abstract void Mostrar();
}

public class PatoReal : Pato
{
    public override void Mostrar() => Console.WriteLine("Pato real na lagoa!");
}

public class PatoDeBorracha : Pato
{
    public override void Mostrar() => Console.WriteLine("Pato de borracha flutuando!");
}
```
Agora, `PatoDeBorracha` e `PatoReal` são substituíveis sem quebrar o código.

---

## 4. **I**nterface Segregation Principle (ISP) – Princípio da Segregação de Interfaces  

### Definição:
Uma interface **não deve forçar** uma classe a implementar métodos que ela **não utiliza**.

### Explicação:
Se uma interface tem **muitos métodos**, classes que a implementam podem ser **forçadas a implementar métodos desnecessários**, tornando o código confuso e difícil de manter.

### Exemplo **(Violando ISP)**:
```csharp
public interface IAve
{
    void Voar();
    void Nadar();
}

public class Pinguim : IAve
{
    public void Voar() { throw new Exception("Pinguins não voam!"); }
    public void Nadar() { Console.WriteLine("O pinguim está nadando!"); }
}
```
A interface `IAve` força o `Pinguim` a implementar `Voar()`, mesmo que ele **não possa voar**.

### Exemplo **(Aplicando ISP - Interfaces menores)**:
```csharp
public interface IAveQueVoa
{
    void Voar();
}

public interface IAveQueNada
{
    void Nadar();
}

public class Andorinha : IAveQueVoa
{
    public void Voar() => Console.WriteLine("A andorinha está voando!");
}

public class Pinguim : IAveQueNada
{
    public void Nadar() => Console.WriteLine("O pinguim está nadando!");
}
```
Agora, cada ave implementa **apenas os métodos relevantes**.

---

## 5. **D**ependency Inversion Principle (DIP) – Princípio da Inversão de Dependência  

### Definição:
Os módulos de **nível alto** **não devem depender** de módulos de **nível baixo**. Ambos devem depender de **abstrações**.

### Explicação:
Isso evita um **forte acoplamento** entre classes, tornando o sistema **mais flexível** e fácil de testar.

### Exemplo **(Violando DIP)**:
```csharp
public class MySQLRepositorio
{
    public void Salvar(string dados) => Console.WriteLine("Salvando no MySQL...");
}

public class UsuarioService
{
    private MySQLRepositorio _repositorio = new MySQLRepositorio();
    public void SalvarUsuario(string usuario) => _repositorio.Salvar(usuario);
}
```
Aqui, `UsuarioService` está **acoplado diretamente** ao `MySQLRepositorio`, dificultando mudanças futuras.

### Exemplo **(Aplicando DIP - Usando uma Interface)**:
```csharp
public interface IRepositorio
{
    void Salvar(string dados);
}

public class MySQLRepositorio : IRepositorio
{
    public void Salvar(string dados) => Console.WriteLine("Salvando no MySQL...");
}

public class UsuarioService
{
    private readonly IRepositorio _repositorio;
    
    public UsuarioService(IRepositorio repositorio)
    {
        _repositorio = repositorio;
    }

    public void SalvarUsuario(string usuario) => _repositorio.Salvar(usuario);
}
```
Agora, `UsuarioService` depende da **abstração (`IRepositorio`)**, permitindo trocar o banco sem mudar o código principal.

---

### 📌 **Resumo Rápido**
1. **SRP** – Cada classe deve ter **uma única responsabilidade**.  
2. **OCP** – Código deve ser **aberto para extensão, mas fechado para modificação**.  
3. **LSP** – Subclasses devem ser **substituíveis** sem quebrar o código.  
4. **ISP** – Interfaces devem ser **pequenas e específicas**.  
5. **DIP** – Dependa de **abstrações, não de implementações concretas**.

Esses princípios ajudam a escrever código mais **flexível, modular e fácil de manter**.