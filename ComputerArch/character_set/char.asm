;### Initialize program ###
    .model small ;1 64KB code segment and 1 64KB data segment
    .stack 100 ;stack segment of 100B
    .data  ;data segment

        PRINT_STRING_FUNC_NUM EQU 09h
        NEW_LINE db 0Dh, 0Ah, '$'
        dbg_str db "Pack my box with five dozen liquor jugs$"

        PRAVOSLAVNIC_FONT db 0h, 0h, 7eh, 09h, 09h, 7eh, 00h, 00h ;a
        db 00h, 00h, 0FFh, 91h, 91h, 0a1h, 40h, 00h ; b
        db 00h, 00h, 0ffh, 08h, 14h, 22h, 41h, 80h ; c
        db 00h, 60h, 19h, 17h, 11h, 1fh, 60h, 00h ; d
        db 00h, 00h, 0ffh, 91h, 91h, 91h, 91h, 00h ; e
        db 00h, 18h, 24h, 0ffh, 0ffh, 24h, 18h, 00h ; f
        db 00h, 00h, 0ffh, 01h, 01h, 01h, 01h, 00h ; g
        db 00h, 42h, 24h, 18h, 18h, 24h, 42h, 00h ; h
        db 00h, 7eh, 20h, 10h, 08h, 04h, 7eh, 00h ; i
        db 00h, 42h, 24h, 0ffh, 0ffh, 24h, 42h, 00h ; j
        db 00h, 00h, 0ffh, 08h, 14h, 22h, 41h, 80h ; k
        db 00h, 40h, 20h, 1fh, 01h, 01h, 7fh, 00h ; l
        db 0feh, 04h, 08h, 10h, 10h, 08h, 04h, 0feh ; m
        db 00h, 00h, 0feh, 10h, 10h, 0feh, 00h, 00h ; n
        db 00h, 18h, 24h, 42h, 42h, 24h, 18h, 00h ; o
        db 00h, 00h, 0feh, 02h, 02h, 0feh, 00h, 00h ; p
        db 00h, 0ch, 12h, 22h, 22h, 34h, 48h, 80h ; q
        db 00h, 000h, 0feh, 12h, 12h, 0ch, 00h, 00h ; r
        db 00h, 18h, 24h, 42h, 42h, 42h, 00h, 00h ; s
        db 00h, 02h, 02h, 7eh, 02h, 02h, 00h, 00h ; t
        db 01h, 02h, 04h, 0f8h, 04h, 02h, 01h, 00h ; u
        db 00h, 00h, 0feh, 92h, 0ach, 40h, 00h, 00h ; v
        db 3ch, 40h, 0e0h, 18h, 18h, 0e0h, 40h, 3ch ; w
        db 00h, 00h, 44h, 28h, 10h, 28h, 44h, 00h ; x
        db 04h, 02h, 04h, 0f8h, 04h, 02h, 04h, 00h ; y
        db 00h, 32h, 0b2h, 0b2h, 0b4h, 78h, 00h, 00h ; z

        println macro string_addr

            lea dx,NEW_LINE
            mov ah,PRINT_STRING_FUNC_NUM
            int 21h

            lea dx,string_addr
            mov ah,PRINT_STRING_FUNC_NUM
            int 21h
        endm

;### Initialize program ###

.code

    .startup

    mov ax,1112h ; 8x8 set
    mov bl,00h
    call loadFont
    println dbg_str
    call getChar

    println NEW_LINE
    mov ax,1111h ; 9x14 set
    mov bl,01h
    call loadFont
    println dbg_str
    call getChar

    println NEW_LINE
    mov ah,00h ; custom 8x8 set
    mov bh, 8 ; bytes per character
    mov bl, 00h
    mov dx, 'A'
    lea bp, PRAVOSLAVNIC_FONT
    call loadFont
    println dbg_str
    call getChar

    caput:
        mov ah,4ch
        int 21h

;### getChar ###
    getChar proc

        MOV AH, 00H
        INT 16H

        ret
    getChar endp
;### getChar ###

;### loadFont ###
    ; INPUTS:
    ;       - AX functia
    ;       - BH numărul de octeţi pe caracter (maxim 32);
    ;       - BL numărul blocului în care se va încărca setul de caractere;
    ;       - CX numărul de caractere de încărcat;
    ;       - DX codul ASCII al primului caracter de la care va fi încărcat noul font în blocul de memorie selectat;
    ;       - ES:BP – pointer la setul de caractere ce se doreşte a fi încărcat.

    loadFont proc

        INT 10H

        ret

    loadFont endp
;### loadFont ###
END