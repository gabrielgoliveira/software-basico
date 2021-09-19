#include <stdio.h>

void dump(void *addr, int n) {
  //addr é o endereço de memoria de 1 inteiro
  //n é o tamanho em bytes desse endereço

  /*
    - Int tem 4 bytes
    00000000 00000000 00000000 00000000

    Cada byte possui um endereço de memoria


  */
  unsigned char *p = (unsigned char *)addr; //recebe o endereço de memoria equivalente ao primeiro byte
  
  while (n--) {

    printf("%p - %02x\n", p, *p); /*Imprime o endereço de memoria daquele byte e o valor dele
    em hexadecimal*/

    p++; /*Incrementa para o proximo endereço*/

  }

}

int main(){
    int i = 10000;

    dump(&i, sizeof(i));

    return 0;
}