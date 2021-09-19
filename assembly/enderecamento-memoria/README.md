# Modos de acesso a memória

Em assembly temos algumas formas de acessar a memória.


## Modo Direto

O endereço de memória de uma variável global é especificado por um label ou uma constante.

Exemplo :

```Assembly

.data
    val: .int 10

.text

    movl val, %eax
    movl %eax, val

```

Como pode se ver no exemplo o acesso foi realizado de forma direta usando o label _val_


## Modo Indireto

Fazendo uma analogia de C, o modo indireto é usar "ponteiros" para realizar o acesso.

Considere :

```Assembly

.data
    val: .int 10

.text

    movq $val, %rax # Pegando o endereço de memoria e salvando em um reg de 64 bits.
    movl (%rax), %eax # em c é equivalente : registrador_eax = *registrador_rax
```

Endereços de memória são guardados em registradores de 64 bits.

a linha ```movl $val, %rax``` está pegando o endereço de val e salvando no registrador %rax.

Nota : sempre que usamos a notação $nome_variavel estamos referenciando o endereço de memória 
determinada variável e quando usamos (%registrador) estamos acessando o endereço que esse registrador
guarda.



## Modo Base-Deslocamento

Considere o programa : 

```Assembly

.data
    vet: .int 4, 5, 6, 7

.text
main:
    movq $vet, %rbx
    movl $1, 4(%rbx)
    movl 8(%rbx), %eax
```

Sendo que na memória teriamos a representação:


| Endereço| Destino 
|---------|---------
| 0x200c  |  7        
| 0x2008  |  6    
| 0x2004  |  5     
| 0x2000  |  4      


A linha ```movl $1, 4(%rbx)``` soma 4 bytes ao endereço de memoria de %rbx, e insere 1 na posição 0x2004

- %rbx guarda o endereço base 0x2000
- 4(%rbx) -> 0x2000 + 4 bytes


## Modo Indexado

Vamos usar um registrador base e outro de indice, de forma que :

(R_{base}, R_{index}) = R_{base} + R_{index}

Ou seja, podemos fazer :

```Assembly

.data
    vet: .int 4, 5, 6, 7

.text
main:
    movq $vet, %rbx
    movq $8, %rcx
    movl $1, (%rbx, %rcx) #salta 8 bytes e insere 1 na posição de memória.
```

A ultima linha desse programa acessa a 3 posição de memória : (2*4 bytes) realizando a operação de (0x2000 + 8 bytes) e insere 1 nessa posiçao do vetor.


Podemos tambem combinar esse metodo de acesso com o anterior :

```Assembly
.data
    vet: .int 4, 5, 6, 7

.text
main:
    movq $vet, %rbx
    movq $8, %rcx
    movl $10, 4(%rbx, %rcx)
```

Nesse caso o endereço será : 4 bytes + 8 bytes + 0x2000.


## Modo Indexado e Escalado


## Leaq