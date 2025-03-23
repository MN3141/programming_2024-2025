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
    ENTER_CODE EQU 13

    READ_KEY_FUNC_NUM EQU 08h ;functie din INT 21h
    PRINT_STRING_FUNC_NUM EQU 09h
    WHITE_COLOR EQU 07h
    RED_COLOR EQU 04h
    YELLOW_COLOR EQU 02h
    BLUE_COLOR EQU 01h

    FILE_NORMAL_STR DB 'F',WHITE_COLOR,'I',WHITE_COLOR,'L',WHITE_COLOR,'E',WHITE_COLOR
    FILE_HIGHLIGHT_STR DB 'F',RED_COLOR,'I',RED_COLOR,'L',RED_COLOR,'E',RED_COLOR
    EDIT_NORMAL_STR DB 'E',WHITE_COLOR,'D',WHITE_COLOR,'I',WHITE_COLOR,'T',WHITE_COLOR
    EDIT_HIGHLIGHT_STR DB 'E',YELLOW_COLOR,'D',YELLOW_COLOR,'I',YELLOW_COLOR,'T',YELLOW_COLOR
    EXIT_NORMAL_STR DB 'E',WHITE_COLOR,'X',WHITE_COLOR,'I',WHITE_COLOR,'T',WHITE_COLOR
    EXIT_HIGHLIGHT_STR DB 'E',BLUE_COLOR,'X',BLUE_COLOR,'I',BLUE_COLOR,'T',BLUE_COLOR
    STR_LEN DW 8

    FILE_STR_INDEX DW 0
    EDIT_STR_INDEX DW 160
    EXIT_STR_INDEX DW 320

    DISTANCE_THRESHOLD DB 9

    ; Check if the cursor is already at an option
    ALREADY_THERE_FILE DB 0
    ALREADY_THERE_EDIT DB 0
    ALREADY_THERE_EXIT DB 0

    ENTER_PRESSED DB 0

    READ_KEY MACRO

        MOV AH,READ_KEY_FUNC_NUM
        INT 21h

    ENDM

    PRINT_STRING MACRO str_addr, str_index

        MOV AX,0B800H   ; 0B800H ??? adresa de segment a memoriei video
        MOV ES,AX   ; ES pointeaz?? la bufferul video
        MOV DI,str_index    ; ES:DI - adresa ??nceputului bufferului video
        LEA SI,str_addr ; DS:SI - adresa textului de afi??at
        MOV CX,STR_LEN  ; CX - lungime ??ir (text)
        REP MOVSB   ; trimitere ??ir ??n memoria video

    ENDM

.CODE
    .STARTUP
        mov ah,0
        mov X,ah
        mov al,0
        mov Y,al
        ; NOTE: in this implementation, the "buttons" are
        ;       located in a 4x3 matrix

        PRINT_STRING FILE_NORMAL_STR,FILE_STR_INDEX
        PRINT_STRING EDIT_NORMAL_STR,EDIT_STR_INDEX
        PRINT_STRING EXIT_NORMAL_STR,EXIT_STR_INDEX

    MAIN:

        CALL CHECK_PRESSED_KEY
        CALL CHECK_POSITION
        jmp MAIN

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

    CHECK_PRESSED_KEY proc

            READ_KEY

            mov ah,0
            mov ENTER_PRESSED,ah

            cmp AL, W_CODE
            je UP_MOV
            cmp AL, S_CODE
            je DOWN_MOV
            cmp AL,A_CODE
            je LEFT_MOV
            cmp AL,D_CODE
            je RIGHT_MOV
            cmp AL,ENTER_CODE
            je ENTER_KEY
            jmp _check_key_caput

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

        ENTER_KEY:

            mov al,1
            mov ENTER_PRESSED,al

        _check_key_caput:

            RET
        ; Check coordinates for debugging reasons
        mov dh,X
        mov dl,Y
        CHECK_PRESSED_KEY ENDP

    COMPUTE_DISTANCE proc

        ; compute the distance between the cursor and the menu
        ; and ouput the value in DL register

        mov al,X
        mul al
        mov bh,al ; x*x

        mov al,Y
        mul al
        mov bl,al ; y*y

        add bh,bl
        cmp bh,DISTANCE_THRESHOLD
        jnae _true
        mov DL,0
        jmp _compute_distance_caput

    _true:
        mov DL,1

    _compute_distance_caput:
        RET

    COMPUTE_DISTANCE ENDP

    CHECK_POSITION proc

        call COMPUTE_DISTANCE
        cmp dl,1 ; the cursor is in the menu area
        je _in_area
        mov dl,0
        ; reset highlight flags
        mov ALREADY_THERE_FILE,dl
        mov ALREADY_THERE_EDIT,dl
        mov ALREADY_THERE_EXIT,dl
        jmp _check_postition_caput

    _in_area:
        ; check button

        mov dl,Y
        cmp dl,0
        je _file_button
        cmp dl,1
        je _edit_button
        cmp dl,2
        je _exit_button

    _file_button

        mov dl,ALREADY_THERE_FILE
        cmp dl,1 ; check if the button was already highlighted
        jne _highlight_file
        jmp _check_key_caput

    _highlight_file:
        mov dl,1
        mov ALREADY_THERE_FILE,dl
        PRINT_STRING FILE_HIGHLIGHT_STR, FILE_STR_INDEX
        jmp _check_key_caput

    _edit_button:

        mov dl,ALREADY_THERE_EDIT
        cmp dl,1
        jne _highlight_edit
        jmp _check_postition_caput

    _highlight_edit:

        mov dl,1
        mov ALREADY_THERE_EDIT,dl
        PRINT_STRING EDIT_HIGHLIGHT_STR, EDIT_STR_INDEX
        jmp _check_postition_caput

    _exit_button:

        mov dl,ALREADY_THERE_EXIT
        cmp dl,1
        jne _highlight_exit
        mov dl,ENTER_PRESSED
        cmp dl,1
        je END
        jmp _check_postition_caput

    _highlight_exit:

        mov dl,1
        mov ALREADY_THERE_EXIT,dl
        PRINT_STRING EXIT_HIGHLIGHT_STR, EXIT_STR_INDEX
        jmp _check_postition_caput

    _check_postition_caput:
        RET
    CHECK_POSITION ENDP
END
;***************************************************************************