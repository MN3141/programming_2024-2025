;***************************************************************************
.MODEL SMALL
.STACK
.DATA
	Temp DW 0	; zona unde se depune temporar cifra citita din
			; sirul de parametri
	Ten  DW 10
	X    DB  0	; număr rând pe ecran
	Y    DB  0	; număr coloana pe ecran
.CODE
.STARTUP
	MOV CX,0	; iniţializare contor lungime şir  parametri
	MOV CL,ES:[80H]	; CL ← lungime şir parametri
	INC CL		; CL pointează la sfârşitul şirului de parametri
	MOV AX,ES
	ADD AX,8
	MOV ES,AX	; ES pointează la offsetul 80H în PSP
	MOV BX,0

;citire coordonata X(număr rând) din şirul de parametri

	CALL PROC1	; eliminare blancuri şi identificare poziţie prima
			; cifră zecimală din parametrul X
	CALL PROC2	; citire primul parametru (X)
	MOV X,AL	; memorare număr rând (X)

;citire coordonata Y(număr coloană) din şirul de parametri

	CALL PROC1	; eliminare blancuri şi identificare poziţie prima
			; cifră zecimală din parametrul Y
            CALL PROC2	; citire al doilea parametru (Y)
	MOV Y,AL	; memorare număr coloana (Y)

;verificare dacă X=Y=0
	ADD AL,X	; se efectuează X+Y
	CMP AL,0	; dacă X+Y=0  X=0, Y=0
	JE Fin

;setare poziţie nouă cursor

	MOV AX,40H
	MOV ES,AX	; ES ← zona de date BIOS
	MOV BH,ES:[62H]	; BH ← număr pagină video activă
	MOV AH,02H	; functia 02H a INT 10H
	MOV DH,X
	MOV DL,Y
	INT 10H ; setare pozitie cursor
	MOV AH,01H
	INT 21H
Fin:	MOV AX,4C00H
	INT 21H

;procedura PROC1 - elimină blancuri şi detectează poziţia primei cifre
;zecimale din parametrii X şi Y

PROC1 PROC NEAR

Getch:	INC BX			; ES:[BX] pointează la textul parametrilor
	MOV DL,ES:[BX]		; DL ← caracter curent din şirul parametrilor
	CMP CX,BX		; verificare sfârşit şir parametri
	JL Fin1
	CMP DL,30H		; caracter curent < '0' ?
	JL Getch		; dacă da, se ignoră
	CMP DL,39H		; caracter curent < '9' ?
	JA Getch		; dacă da, se ignoră
Fin1:	RET

PROC1 ENDP

;procedura PROC2 - citeşte un parametru (X sau Y) din linia de comandă
;şi returnează valoarea numerică în AL
;DL=caracter curent, BX=offset curent faţă de începutul şirului
;CX=lungime şir, ES=pointează la offsetul 80H din PSP
;rezultat returnat în AL

PROC2 PROC	NEAR
	MOV AX,0	; iniţializare registru rezultat
Next:	CMP DL,30H	; caracter curent < '0' ?
	JL Fin2
	CMP DL,39H	; caracter curent < '9' ?
	JA Fin2
	SUB DL,30H	; conversie caracter → valoare numerică
	MOV Temp,DX	; memorare cifră curentă
	MUL Ten		; AX*10
	ADD AX,Temp
	MOV DX,0	; iniţializare DX pentru procesare caracter următor
	INC BX		; avans contor caractere
	MOV DL,ES:[BX]	; DL ← următorul caracter
    CMP BX,CX	; sfsrşit şir ?
	JL Next
Fin2:	RET

PROC2	ENDP
		END
;***************************************************************************