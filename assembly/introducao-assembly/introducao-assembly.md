# Introdução ao Assembly

Etapas de compilação de um programa em C :

1. Pré-Processador
2. Compilador
3. Assembler
4. Linker

### Pré-Processador

Ele cuida das linhas que começa com # (include e define), ele é responsável por importar os includes para o nosso arquivo.

Saida : arquivo.i

### Compilador

Transforma o arquivo.i em um assembly

Saida : arquivo.s

### Assembler

### Linker



## Visão do Programador

A CPU tem :

* Conjunto de registradores
	1 - RIP : Endereço da próxima instrução (pc)
	2 - RFLAGS : Status da Ultima Operação (Overflow ?)
	3 - Registradores para guardar valores, endereços ...
	
* ULA - Unidade Logica Aritmetica

	1 - Realiza as operações aritmeticas
	2 - Operação de Atribuição ...


As instruções dos programas estão salvas na memória, logo a comunicação entre CPU e memória é intensa.

É bem comum que os dados obtidos na memoria vão para os registradores para que sejam realizadas operações na ULA.

Operações que passam pela ULA

* Atribuição
* Soma
* Subtração
* ...

A cada operação realizada na ULA o RFLAGS é atualizado com o sinal da operação.


OBS : A ULA só realiza os calculos com os valores que estão nos registradores.


## Tipos Básicos de Dados

* Valores Inteiros

	* 1, 2, 4, 8 bytes
	* Endereços de Memória
	* Valores em ponto flutuante
	
## Programa assembly

O programa assembly é dividido em seções, onde :

.data : é a seção onde vamos declarar as váriaveis globais.

.text : onde fica o código.

```
.data
    nums: .int 10, -21, -30, 45

.text

.globl main

main: 

<Aqui vai o código main>

```

### Labels

Os labels são utilizados sempre que queremos dar um nome para algo, geralmente para definir um label é utilizado uma sequência de caracteres seguida por dois pontos :

Vamos usar labels para nomear variáveis globais, funções e posições para JUMP.

Sintaxe :

``nome_label: tipo_dado inicialização ``

Sintaxe para declarar uma váriavel global.


```
    nums: 
    main:
    .L1:
    .L2:
```

## Compilação

Para compilar um programa Assembly usando o gcc


```
gcc -o <output> <files>


gcc -o prog prog.S
```

As vezes precisamos desativar o PIE :


```
gcc -no-pie -o <output> <files>
```


# Armazenamento de Dados

Podemos ter :

* Registradores
* Variáveis Globais
* Variáveis Locais

Na arquitetura da AMD 64 temos 16 registradores, eles podem ser usados como
valores de 8, 16, 32 ou 64 bits.

Algumas instruções demandam registradores especificos.


## Variáveis Globais

Como dito anteriormente, elas são definidas na sessão de dados, e para
declarar a sintaxe é :

```<nome>: <tipo> <expressão>```

Exempo :

* Nome - Label
* Tipo - Númerico ou String
* Expressão - Valores Escalares ou array (O valor não pode ser omitido)

Ex: 


```assembly
.data 

    num: .int 1024
    i: .short 0x33AF
    str01: .ascii "Hello\0"

    vet: .int 1, 2, 3, 4, 5
```

## Tipos númericos

Tipo      | Sinonimo | Tamanho
--------- | ------   | ------
.byte     |          | 1 Byte
.word     | .short   | 2 Bytes
.long     | .int     | 4 Bytes 
.quad     |          | 8 Bytes


> Cuidado com o long de assembly, pois ele é o int de C

## Agora string, temos os tipos :

Tipo      | Sinonimo | Obs.
--------- | ------   | ------
.ascii    |    -     | Não adiciona o \0 no final da string
.asciz    | .string  | Adiciona o \0 no final da string



## Alinhamento

Variáveis globais tambem precisam de alinhamento na memória, para
realizar o alinhamento usamos a sintaxe:

```
.align <tamanho>

```

Tamanho pode ser : 2, 4, 8

O alinhamento faz com que o dado seja salvo em uma posição de memoria 
multipla de 2, 4, 8 pois assim o processador consegue acessar os dados
de forma eficiente.

exemplos :

```
.data
    .align 4
    num: .int 1024
    
    .align 2
    i: short 0x33AF
```

# Exportando Variáves


Quando escrevemos um programa em C, da forma :

aux.c
```C
    int val = 1024;
    
    int sum(int a, int b){
	return a+b;     
    }
```

Por padrão essas variáveis estão sendo exportadas, logo podemos
usa-las em outros arquivos da forma :


main.c
```C
int main(){
    sum(1, 2);
}
```

considerando a main, basta compilar da forma :

```
gcc main.c aux.c -o output
```

dessa forma automaticamente, as variáveis de aux são acessiveis pela main.c.

quando queremos que a variável fique com privada, usamos :

```C
    static int val = 1024;
```

Dessa forma a variável só pode ser acessada por esse arquivo. 


Em assembly temos que por default as variáveis são privadas, ou seja, tem o
funcionamento semelhante ao static do C, para deixar a variável publica
usamos o globl.

Sintaxe :

```
    globl val
    .align 4
    val: .int 1024
```


# Movimentação de Dados

Atribuição, em assembly temos :

```
    mov[b, w, l, q] font, destino # destino = fonte;
```


ou seja, 

mov<sufixo> fonte, destino

Significado dos sufixos :

* movb - move 1 byte
* movw - move 2 bytes (word)
* movl - move 4 bytes (long)
* movq - move 8 bytes (quads)


Combinações possiveis :

| Fonte  | Destino |
|--------|---------|
| const  |  reg    |    
| const  |  mem    |
| reg    |  reg    | 
| reg    |  mem    |     
| mem	 |  reg    |


Note que não é possivel fazer a combinação memória -> memória.


## Metodos de acesso a Memória </br></br>

### Constantes : são indicadas por _$_ </br></br>

* $362 - Inteiro
* $0xF3E3 - Hexadecimal

### Registradores </br></br>

São especificados por nomes :

* %rax
* %ecx
* %si
* %esi



### Memória

1) Modo de Acesso Direto

Em C, teriamos :

```C

int num = 0;

int main(){
    num = 10;    
}
```

que é uma forma de inserir valores diretamente, em assembly o equivalente é : </br>


```Assembly
.data
    num: .int 0

.text
    movl $10, num
``` 

Para realizar a leitura : 

```Assembly
.data
    num: .int 0

.text
    movl $10, num
    movl num, %eax
``` 

note que estamos pegando o valor da variável e jogando em um registrador de tamanho compativel.


2) Modo de acesso indireto

Seria o equivalente a ponteiro em C:


Quando nos referenciamos a uma variável como : </br>

```$nome_variavel```

Estamos nos referindo ao endereço de memória dessa variável.

```Assembly
.data
    num: .int 0

.text
    movq $num, %rax
``` 

OBS : Nesse caso precisa ser um registrador de 64 Bits pois ele precisa guardar um endereço de memória.

Quando usamos o nome do regisrador entre parenteses, estamos acessando o endereço de memória que ele esta referenciando.

Então :

```Assembly
.data
    num: .int 0

.text
    movq $num, %rax
    movl $1, (%rax) # gravando 1 na variável num

``` 


# Operações Aritméticas

### - inc opr

Esse operador vai incrementar 1 ao opr


### - dec opr

Esse operador vai subtrair 1 do opr

### - neg opr

Esse operador vai trocar o valor


--------------------------
Exemplos :

```
incl %eax # %eax = %eax + 1
incl (%rdx) # (%rdx) = (%rdx) + 1

decq %rax # %rax = %rax - 1

negl val # val = -val

```
--------------------------


### Soma e Subtração

Para somar|subtração dois operadores é necessário que eles tenham o mesmo tamanho, então para realizar a operação :

Sintaxe :

- add fonte, destino (destino = destino + fonte)
- sub fonte, destino (destino = destino - fonte)

Exemplos :

```Assembly
addl %ebx, %eax
addq $4, %rbx
addl (%r12), %eax
```

### Multiplicação

### Operadores Bit a Bit

- and fonte, destino # destino = destino & fonte
- or  fonte, destino # destino = destino | fonte
- xor fonte, destino # destino = destino ^ fonte
- not destino        # destino = ~destino

Esses são os operadores e sua comparação com os operadores bit a bit da linguagem C.



