#include "homework1.h"

boolean VerifyPowerOf2(uint8 Number){
/*Implementați funcția VerifyPowerOf2() care verifică dacă un număr primit ca parametru
este putere a lui 2.*/

/*Note:we know that if the given number is a power of 2
       then it should have only one bit set*/

    if(CountBitsOf1(Number)==1)
        return 1;
    return 0;
}