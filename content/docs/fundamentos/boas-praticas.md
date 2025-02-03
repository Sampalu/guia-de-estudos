---
title: "Boas Práticas"
date: 2025-02-02T12:00:00-03:00
draft: false
---


Aqui estão as explicações detalhadas das boas práticas que são princípios fundamentais na construção de sistemas de software mais claros, eficientes e de fácil manutenção:

---

## 1. **DRY** (Don't Repeat Yourself) – Não se Repita  

### Definição:
**Não repita o mesmo código** em múltiplos lugares. Sempre que você se pegar copiando e colando código, isso é um sinal de que algo pode ser extraído para uma função, classe ou módulo.

### Explicação:
O princípio **DRY** promove a ideia de que **duplicação de código** é um problema que aumenta o risco de **manutenção difícil** e **erros**. Sempre que uma mudança for necessária, ela terá que ser feita em vários locais, o que pode levar a inconsistências.

### Exemplo:
```csharp
// Violando DRY
public class Produto
{
    public double CalcularDesconto(double preco)
    {
        return preco * 0.9;
    }
}

public class ClienteVip
{
    public double CalcularDesconto(double preco)
    {
        return preco * 0.8;
    }
}
```
Aqui, a lógica de **cálculo de desconto** é repetida nas duas classes.

### Aplicando **DRY**:
```csharp
public class CalculadoraDesconto
{
    public double CalcularDesconto(double preco, double percentual)
    {
        return preco * (1 - percentual);
    }
}

public class Produto
{
    public double CalcularDesconto(double preco)
    {
        var calculadora = new CalculadoraDesconto();
        return calculadora.CalcularDesconto(preco, 0.1);
    }
}

public class ClienteVip
{
    public double CalcularDesconto(double preco)
    {
        var calculadora = new CalculadoraDesconto();
        return calculadora.CalcularDesconto(preco, 0.2);
    }
}
```
Agora, a lógica do desconto é centralizada, evitando duplicação.

---

## 2. **KISS** (Keep It Simple, Stupid) – Mantenha Simples, Estúpido  

### Definição:
**Mantenha as coisas simples** e evite complicações desnecessárias. A solução mais simples é frequentemente a melhor.

### Explicação:
O **princípio KISS** diz que, ao criar soluções para problemas, **não adicione complexidade desnecessária**. A simplicidade resulta em código mais **legível**, **manutenível** e **fácil de testar**.

### Exemplo:
```csharp
// Complexo e violando KISS
public class CalculoSalario
{
    public double Calcular(double salarioBase, double horasExtras, double desconto)
    {
        double salarioComExtras = salarioBase + horasExtras * 10;
        double salarioComDesconto = salarioComExtras - desconto;
        return salarioComDesconto + salarioBase * 0.1;
    }
}
```
Aqui, o cálculo pode ser mais simples. A lógica complexa de calcular o salário pode ser dividida ou simplificada.

### Aplicando **KISS**:
```csharp
public class CalculoSalario
{
    public double Calcular(double salarioBase, double horasExtras, double desconto)
    {
        return salarioBase + horasExtras * 10 - desconto;
    }
}
```
Agora, o cálculo é mais direto e fácil de entender.

---

## 3. **YAGNI** (You Aren't Gonna Need It) – Você Não Vai Precisar Disso  

### Definição:
**Não implemente funcionalidades** até que elas sejam realmente necessárias. Evite **adivinhar o futuro** e adicionar código que provavelmente nunca será usado.

### Explicação:
O princípio YAGNI é sobre evitar gastar tempo implementando algo que **não tem valor imediato**. Muitas vezes, os desenvolvedores tentam antecipar as necessidades futuras, o que acaba gerando **complexidade** desnecessária.

### Exemplo:
```csharp
public class Calculadora
{
    private bool precisaSalvarHistorico = false;

    // Implementei uma funcionalidade complexa que pode nunca ser usada
    public void AtivarHistorico() 
    {
        precisaSalvarHistorico = true;
    }

    public double Somar(double a, double b)
    {
        return a + b;
    }
}
```
Aqui, o código está se preparando para algo que **ainda não foi solicitado**.

### Aplicando **YAGNI**:
```csharp
public class Calculadora
{
    public double Somar(double a, double b)
    {
        return a + b;
    }
}
```
Evitar a implementação de **funcionalidades não solicitadas** pode manter o sistema mais simples e com menos código a ser mantido.

---

## 4. **SOC** (Separation of Concerns) – Separação de Responsabilidades  

### Definição:
**Divida o código em partes bem definidas**, onde cada parte tem uma responsabilidade única e separada, e **não mistura** funcionalidades diferentes.

### Explicação:
A **separação de responsabilidades** permite que diferentes **áreas de preocupação** do sistema sejam tratadas por diferentes módulos, classes ou camadas. Isso melhora a **manutenibilidade** e a **testabilidade**, pois mudanças em uma área não afetam outras.

### Exemplo:
```csharp
// Violando SOC: Mistura de lógica de cálculo com exibição
public class Relatorio
{
    public void GerarRelatorio(List<Produto> produtos)
    {
        // Geração de relatório
        foreach (var produto in produtos)
        {
            Console.WriteLine(produto.Nome + " - " + produto.Preco);
        }
    }
}
```
Neste caso, a classe `Relatorio` está responsável por gerar **dados** e **exibir no console**, o que não deveria ser o caso.

### Aplicando **SOC**:
```csharp
public class Relatorio
{
    private readonly ExibidorRelatorio _exibidor;

    public Relatorio(ExibidorRelatorio exibidor)
    {
        _exibidor = exibidor;
    }

    public void GerarRelatorio(List<Produto> produtos)
    {
        // Geração de relatório
        _exibidor.Exibir(produtos);
    }
}

public class ExibidorRelatorio
{
    public void Exibir(List<Produto> produtos)
    {
        foreach (var produto in produtos)
        {
            Console.WriteLine(produto.Nome + " - " + produto.Preco);
        }
    }
}
```
Agora, temos a **separação clara** entre gerar e exibir os relatórios.

---

Você está correto! Quando falamos de **MVP** no contexto de desenvolvimento de produtos e startups, estamos nos referindo a **Mínimo Produto Viável**, e não ao padrão de arquitetura Model-View-Presenter. Vou explicar ambos para evitar confusão:

---

## 5. **MVP** (Minimum Viable Product) - Mínimo Produto Viável 

### Definição:
O **Mínimo Produto Viável (MVP)** é uma versão inicial de um produto com **apenas as funcionalidades essenciais** que permitem **validar a ideia** no mercado, coletar **feedback de usuários reais** e entender se o produto resolve o problema do público-alvo de forma satisfatória.

### Explicação:
O objetivo do MVP é lançar rapidamente um produto com **recursos mínimos**, sem gastar tempo ou recursos em funcionalidades que podem não ser necessárias. Com o MVP, a ideia é validar hipóteses de **mercado** e **usabilidade**, evitando o desperdício de recursos no desenvolvimento de um produto completo que pode não atender às necessidades dos usuários.

### Características do MVP:
- **Funcionalidade mínima**: Apenas as funcionalidades essenciais que comprovem a proposta de valor do produto.
- **Lançamento rápido**: Desenvolvimento rápido para começar a obter **feedback de usuários reais**.
- **Iteração contínua**: Com base no feedback, o produto pode ser **melhorado e ajustado** ao longo do tempo.

### Exemplo:
Imagine que você está criando um aplicativo de **pedidos de comida online**. Em vez de criar um aplicativo complexo com **personalizações, múltiplos métodos de pagamento e integração com diversas redes sociais**, você poderia lançar uma versão MVP que permite aos usuários:
- Escolher um restaurante
- Fazer um pedido simples
- Efetuar o pagamento

A ideia é lançar o produto rapidamente e **validar a demanda**. Se os usuários gostarem, você pode adicionar novas funcionalidades em versões futuras.

---

### 📌 **Resumo Rápido:**
- **DRY** – Evitar **duplicação de código**.  
- **KISS** – **Mantenha a solução simples** e evite complicações desnecessárias.  
- **YAGNI** – **Não implemente** funcionalidades que não são necessárias **agora**.  
- **SOC** – **Separe** diferentes responsabilidades do sistema em partes distintas.  
- **MVP** – **Mínimo Produto Viável (MVP)** SFoca no desenvolvimento de um produto inicial com funcionalidades mínimas para validar a ideia.

Esses princípios ajudam a escrever **código mais limpo**, **modular**, **flexível** e **de fácil manutenção**.