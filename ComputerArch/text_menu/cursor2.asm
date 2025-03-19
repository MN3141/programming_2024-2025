;***************************************************************************
.MODEL SMALL
.STACK
.DATA
    Temp DW 0   ; zona unde se depune temporar cifra citita din
            ; sirul de parametri
    Ten  DW 10
    X    DB  0  ; num??r r??nd pe ecran
    Y    DB  0  ; num??r coloana pe ecran

    ; ASCII CODES FOR WASD KEYS
    W_CODE EQU 119
    S_CODE EQU 115
    A_CODE EQU 97
    D_CODE EQU 100

    READ_KEY_FUNC_NUM EQU 08h ;functie din INT 21h
    PRINT_STRING_FUNC_NUM EQU 09h

    DBG_STRING DB 'D','$'

    READ_KEY MACRO

        MOV AH,READ_KEY_FUNC_NUM
        INT 21h
    ENDM

    PRINT_STRING MACRO string_addr

        lea dx,string_addr
        mov ah,PRINT_STRING_FUNC_NUM
        int 21h

    ENDM

.CODE
    .STARTUP
        MOV CX,0    ; ini??ializare contor lungime ??ir  parametri
        MOV CL,ES:[80H] ; CL ??? lungime ??ir parametri
        INC CL      ; CL pointeaz?? la sf??r??itul ??irului de parametri
        MOV AX,ES
        ADD AX,8
        MOV ES,AX   ; ES pointeaz?? la offsetul 80H ??n PSP
        MOV BX,0


    KEY_PRESS_LOOP:

        READ_KEY

        cmp AL, W_CODE
        je UP_MOV
        cmp AL, S_CODE
        je DOWN_MOV
        cmp AL,A_CODE
        je LEFT_MOV
        cmp AL,D_CODE
        je RIGHT_MOV

    UP_MOV:

        mov al,Y
        dec al
        mov Y,al
        jmp KEY_PRESS_CALL

    DOWN_MOV:


        mov al,Y
        inc al
        mov Y,al
        jmp KEY_PRESS_CALL

    LEFT_MOV:


        mov al,X
        dec al
        mov X,al
        jmp KEY_PRESS_CALL

    RIGHT_MOV:


        mov al,X
        inc al
        mov X,al
        jmp KEY_PRESS_CALL

    KEY_PRESS_CALL:
        call MV_CURSOR
        PRINT_STRING DBG_STRING
        jmp KEY_PRESS_LOOP
    Fin:

        MOV AX,4C00H
        INT 21H


    MV_CURSOR PROC

    ;setare pozi??ie nou?? cursor

        MOV AX,40H
        MOV ES,AX   ; ES ??? zona de date BIOS
        MOV BH,ES:[62H] ; BH ??? num??r pagin?? video activ??
        MOV AH,02H  ; functia 02H a INT 10H
        MOV DH,Y
        MOV DL,X
        INT 10H ; setare pozitie cursor
        RET

    MV_CURSOR ENDP
END
;***************************************************************************