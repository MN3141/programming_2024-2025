/*Implementați următoarele probleme folosind numai operatori pe biți, operatorul de însumare
și tipurile de date primitive din Platform_Types.h (nu aveți voie să folosiți altfel de operatori,
array-uri, structuri, etc.)*/

#include <stdio.h>
#include "homework1.h"

uint8 CountBitsOf1(uint8 Number){
/*Implementați funcția CountBitsOf1() care numără câți biți de unu sunt în reprezentarea în
binar a unui număr primit ca parametru*/

    const uint8 BITS_NUM=8;
    uint8 MASK=1;
    uint8 bits_count=0;

    for(int i=0;i<BITS_NUM;i++)
        bits_count+=(Number & (MASK<<i))!=0;

    return bits_count;
}