/*Implementați următoarele probleme folosind numai operatori pe biți, operatorul de însumare
și tipurile de date primitive din Platform_Types.h (nu aveți voie să folosiți altfel de operatori,
array-uri, structuri, etc.)*/

#include <stdio.h>
#include "homework1.h"

int main(){

    printf("Count number of bits for 8: %d\n",CountBitsOf1(8));
    printf("Is 8 a power of number 2? %d\n",VerifyPowerOf2(8));
    printf("Nibble sum for 8 is %d",CalculateSumOfNibbles(8));
    return 0;
}