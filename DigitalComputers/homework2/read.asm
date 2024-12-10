;***************************************************************************
.MODEL SMALL
.STACK
.DATA
CR EQU 0DH
LF EQU 0AH
Msg16 DB CR,LF,'Serviciu BIOS: Introduceţi un şir <Enter>:',CR,LF,'$'
Msg21 DB CR,LF,'Serviciu DOS: Introduceţi un şir <Enter>:',CR,LF,'$'
MsgOut DB 'S-a introdus următorul text:','$'
MaxL DB 255
CrtL DB 0
Str1 DB 256 DUP(?)
.CODE
.STARTUP
;........................Mesaj serviciu BIOS..........................
MOV AH,09H
LEA DX,Msg16
INT 21H
;.................Introducere caractere (serviciu BIOS)...............
MOV BX,0 ;BX - contor caractere.
Next16: MOV AH,0 ;Funcţia 00H - citire caractere.
INT 16H ;serviciu BIOS tastatură.
;CMP AL,0 ;tastă speciala?
;JE Next16 ;ignoră tasta specială
MOV Str1[BX],AL ;memorare caracter curent în şir.
INC BX ;incrementare contor caractere.
CMP AL,CR ;s-a tastat Enter?
JNE Next16 ;dacă nu, citeşte următorul caracter.
;...............Se adaugă LF şi '$' la sfârşitul şirului..............
MOV Str1[BX],LF
MOV Str1[BX+1],'$'
;....................Afişare MsgOut şi şir introdus...................
MOV AH,09H
LEA DX,MsgOut
INT 21H
LEA DX,Str1
INT 21H
;..........................Mesaj serviciu DOS.........................
MOV AH,09H
LEA DX,Msg21
INT 21H
;..................Introducere caractere (serviciu DOS)...............
MOV AH,0AH ; Funcţia 0AH - citire caractere.
LEA DX,MaxL ; DS:DX - adresa buffer intrare.
INT 21H
;.............Adăugare CR, LF şi '$' la sfârşitul şirului.............
MOV BL,CrtL ; BL - lungimea şirului introdus.
MOV BH,0 ; lungime şir < 256 caractere.
MOV Str1[BX],CR
MOV Str1[BX+1],LF
MOV Str1[BX+2],'$'
;...................Afişare MsgOut şi şir introdus....................
MOV AH,09H
LEA DX,MsgOut
INT 21H
LEA DX,Str1
INT 21H
MOV AH,4CH
INT 21H
END
;***************************************************************************