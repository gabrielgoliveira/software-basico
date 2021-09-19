#include <stdio.h>

int main(){

    /*
        10 = 1010
        9 =  1001

            1010
        &   1001
        ----------
            1000
        
        8 = 1000
    */

    char numero = 100;

    printf("Operador E : %d\n", 10&9);



    printf("Operador Negação : %d\n", 10<<1);
    
    printf("Char : %c\n", numero);
    
    return 0;
}