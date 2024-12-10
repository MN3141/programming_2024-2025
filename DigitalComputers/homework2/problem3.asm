;Să se scrie un program care, prin intermediul indirectării întreruperii INT
;09H, să determine convertirea caracterelor introduse în majuscule. Cu alte cuvinte, orice
;funcţie DOS, BIOS sau C care foloseşte tastatura, să recepţioneze doar majuscule.
;***************************************************************************
.MODEL SMALL
.STACK 512 ;rezervare 512 octeti pentru stiva
.DATA
CR EQU 0DH ;cod ASCII CR
LF EQU 0AH ;cod ASCII LF
EscScan EQU 01H ;cod scanare Esc
KbdPort EQU 60H ;adresa port paralel tastatura
NewHand DD NewInt9 ;adresa segment:offset pentru noul
;handler al întreruperii 09H
Kbd83 DB CR,LF,'Tastatura standard - 83 taste ',CR,LF,'$'
Kbd101 DB CR,LF,'Tastatura extinsa - 101/102 taste',CR,LF,'$'
    ASCII_MASK db 02h
.CODE
NewInt9 PROC FAR ;handler aditional pentru intreruperea 09H
PUSH AX
PUSH BX
PUSH DX
PUSH DS
IN AL,KbdPort ;citire cod scanare din portul paralel
PUSH AX ;salvare cod scanare în stiva pentru procesare.
PUSHF ;pentru revenirea din handlerul standard
DB 9AH ;codul pentru CALL FAR
Off9 DW ? ;adresa de offset pentru handlerul standard
Seg9 DW ? ;adresa de segment pentru handlerul standard
POP AX ;AL conţine codul de scanare
MOV AH,0 ;AX în domeniul 0-255
ProcScan: DIV CS:Con16 ;AL-primul digit hexa,AH-al doilea digit hexa
MOV BH,0
MOV BL,AL ;preluare în BX a primului digit hexa
MOV AL,CS:HexTab[BX] ;preluare cod ASCII din tabela
MOV CS:OutByte[0],AL ;introducere cod ASCII în şir
MOV BL,AH ;preluare în BX al 2-lea digit hexa
MOV AL,CS:HexTab[BX] ;preluare caracter hexa corespunzător
MOV CS:OutByte[1],AL ;introducere caracter hexa în şir
    ;Note:
    ;The difference between an uppercase and lower case letter
    ;lies in the sixth bit (2^5)
    ;'a'=97,'z'=122
    mov dx,word ptr CS:OutByte
    cmp dx,'a'
    jz test2
    jmp not_lower_case
    test2:
    cmp dx,'z'
    jz lower_case
    jmp not_lower_case
    lower_case:
    or dh,ASCII_MASK ;sixth bit of DX
    mov CS:OutByte[0],dh
    mov CS:OutByte[1],dl
    not_lower_case:
PUSH CS
POP DS ;DSCS pentru afişarea cu funcţia 09H
LEA DX,CS:OutByte ;DX - offset şir de afişat
MOV AH,09H ;funcţia 09H - afişare şir pe ecran
INT 21H
INC CS:LinePos ;incrementare contor linie caractere
CMP CS:LinePos,24 ;maxim 24 caractere pe linie
JB NotSkip
MOV CS:LinePos,0 ;iniţializare contor pentru linie noua
LEA DX,CS:CrLf ;adăugare CR,LF,$ în şirul de afişat
INT 21H
NotSkip: POP DS
POP DX
POP BX
POP AX
IRET
NewInt9 ENDP
;.........................program principal...........................
Start:
MOV AX,@DATA
MOV DS,AX
MOV CS:OldDS,DS
MOV AX,40H
MOV ES,AX ;ES  adresa segment a zonei de date BIOS.
TEST BYTE PTR ES:[96H],10H
;test bit 4 al locatiei 96H
;pentru determinarea tipului de tastatura.
JNZ Pres101
LEA DX,Kbd83 ;tiparire mesaj tastatura 83 taste.
MOV AH,09H
INT 21H
JMP Install
Pres101: LEA DX,Kbd101 ;tiparire mesaj tastatura 101/102 taste
MOV AH,09H
INT 21H
Install:
MOV AH,35H ;functia 35H - preluare vector
MOV AL,09H ;intrerupere 09H din IVT
INT 21H ;salvare vector intrerupere standard la
MOV Off9,BX ;adresele Off9 si
MOV Seg9,ES ;respectiv Seg9
LDS DX,NewHand ;DS-adresa segment NewHand,
;DX-offset NewHand
MOV AH,25H ;functia 25H - instalare (redirectare)
;vector intrerupere pentru intreruperea 09H
INT 21H
MOV DS,CS:OldDS ;restaurare continut anterior DS
NextKey:
MOV AH,00H ;funcţia 00H - citire caracter a
;intreruperii BIOS INT 16H
INT 16H
CMP AH,EscScan ;s-a tastat Esc?
JNE NextKey ;daca nu - procesare caracter urmator
Finis:
MOV DX,Off9 ;restaurare offset si adresa segment
MOV DS,Seg9 ;pentru handler-ul original (standard)
;al intreruperii 09H
MOV AX,2509H
INT 21H
MOV AH,0CH ;functia 0CH - stergere buffer tastatura
INT 21H
MOV AX,4C00H
INT 21H
;.............zona de date în cadrul segmentului de cod...............
OldDS DW ?
LinePos DB 0
Con16 DB 16
OutByte DB 'xx '
CrLf DB CR,LF
HexTab DB '0','1','2','3','4','5','6','7'
DB '8','9','a','b','c','d','e','f'
END Start
;****************************************************************************