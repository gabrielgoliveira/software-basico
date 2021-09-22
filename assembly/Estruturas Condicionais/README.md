 ## Desvio Incondicional

Em assembly temos o desvio incondicional, que é chamado de jump, similar ao
goto do C.

Sintaxe :

jmp label

## Desvio Condicional

Muda o fluxo de acordo com o RFLAGS, se ele guardar 1 então é feita a mudança.

Antes de realizar as comparações precisamos verificar se estamos usando inteiros com ou sem sinal.


* e -> Equal
* g -> greater
*l -> less

Signed (Com sinal)


Instrução  | Sinônimo | Descrição
-----------|----------|---------
je label   | jz       | equal / zero
jne label  | jnz      | not equal / not zero
js label   |          | negative
jns label  |          | non negative
jg label   | jnle     | > (greater)
jge label  | jnl      | >= (greater or equal)
jl label   | jnge     | < (less)
jle label  | jng      | <= (less or equal)


Unsigned (Sem Sinal)





# Estrutura Condicional



O "if" na verdade só desvia o fluxo quando a expressão que ele testa é falsa,
caso seja verdadeira ele não faz nada, um if padrão :

```C
if(<expr>) {
	// bloco if
}

// continuacao	
```

No exemplo acima, temos que o _bloco if_ só vai ser ignorado quando a <expr> for falsa.

Podemos reescrever essa instrução como :


```C
if(!<expr>) goto depois_if
	// bloco if

depois_if:
	// continuacao	
```


Nesse caso quando <expr> é false, a negação faz se tornar true e um salto é 
realizado para depois_if, mantendo o comportamento exatamente o mesmo do 
anterior.

No lugar da negação ainda podemos usar o complemento, note que as expressões são equivalentes : 

a > b equivalente a <= b


Visto isso, podemos escrever a estrutura condicional em assembly, de forma que :

```Assembly
# Recuperando os valores de a, b da memória, visto que a comparação só
# é realizada com valores presentes nos registradores

movl a, %eax # %eax = a
movl b, %ebx # %ebx = b 

cmpl %ebx, %eax # %eax <= % ebx (a <= b) op : %eax - %ebx
jle depois_if

addl %ebx, %eax

depois_if:
	call printf
```
