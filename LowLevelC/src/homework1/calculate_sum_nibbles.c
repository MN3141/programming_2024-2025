#include "homework1.h"
sint8 CalculateSumOfNibbles(uint8 Byte){
/*Implementați funcția CalculateSumOfNibbles() care calculează suma dintre low nibble-ul
(cei mai puțini semnificativi 4 biți) și high nibble-ul (cei mai semnificativi 4 biți) ale unui
byte primit ca parametru, reprezentarea low nibble-ului în binar fiind interpretată ca un
număr fără semn și reprezentarea high nibble-ul în binar fiind interpretată ca un număr cu
semn (high nibble-ul poate avea valori în intervalul [-8, 7] iar low nibble-ul poate avea
valori în intervalul [0, 15]).*/

    const uint8 LOW_NIBBLE_MASK=0x0f;
    const uint8 HIGH_NIBBLE_MASK=0xf0;
    uint8 low_nibble=Byte&LOW_NIBBLE_MASK;
    uint8 high_nible=(Byte&HIGH_NIBBLE_MASK)>>4;
    sint8 high_nibble_signed = high_nible;
    if (high_nible & 0x08)/*in two's complement the most significant bit is always a negative value*/
        high_nibble_signed -= 16;

    return high_nibble_signed+low_nibble;
}