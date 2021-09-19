# Mecanismos de Controle

Por padrão, a proxima instrução do programa é executada de acordo com o Registrador RIP, que guarda
o endereço da proxima instrução, se temos o programa carregado em memória :


| Endereço| Destino 
|---------|---------
| 1150    |  MOVQ L1, %rdx       
| 1158    |  MOVQ L1, %rdx
| 115b    |  SUBL val, %ecx     
| 1162    |  ANDL %eax, %ecx


no inicio da execução do programa o RIP vale 1150 e a cada instrução é somado 1 nele.

Podemos alterar esse funcionamento criando desvios de fluxo em nosso programa, alterando o valor do RIP.

## Comparação de Dados

### comp

O comp compara um valor com o outro realizando a subtração deles, mas essa subtração não retorna nada,
ela altera um registrador em RFLAGS indicando o sinal da operação.

```Assembly
cmpl %eax, %ebx # %ebx - %eax 
```

Se o resultado for :  

* Igual a ZERO, temos que os valores são iguais
* Negativo, temos que %eax é maior que %ebx


### Teste de Dados

Temos o operador teste, ele faz um & de bit bit nos operadores.

```Assembly
test fonte_2, fonte_1 # fonte_1 & fonte_2
```

Exemplo :

```Assembly
testl %eax, %ebx
```

## Desvios

No assembly temos o JUMP, que nos permite modificar o fluxo de execução do programa.




