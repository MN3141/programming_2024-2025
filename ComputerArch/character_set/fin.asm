; Demo for reading content of a file

;### Initialize program ###
    .model small ;1 64KB code segment and 1 64KB data segment
    .stack 100 ;stack segment of 100B
    .data  ;data segment
        FILE_NAME db "foo.txt",0
        file_handle dw 0
        text_buffer db 100 dup('$')
        BYTES_TO_READ dw 13
        read_bytes dw 0

        PRINT_STRING_FUNC_NUM EQU 09h
        OPEN_FILE_FUNC_NUM EQU 3dh
        CLOSE_FILE_FUNC_NUM EQU 3eh
        READ_FILE_FUNC_NUM EQU 3fh
        READ_FILE_MODE EQU 0

        OPEN_FILE_ERROR db "Cannot open file!",'$'
        READ_FILE_ERROR db "Cannot read file!",'$'
        CLOSE_FILE_ERROR db "Cannot close file!",'$'
        NEW_LINE db 0Dh, 0Ah, '$'

        dbg_str dw 0

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
    println FILE_NAME
    call readFile
    ;println text_buffer

caput:
    mov ah,4ch
    int 21h

;### readFile ###
    readFile proc

    ; Open the file

        mov ah,OPEN _FILE_FUNC_NUM
        mov al,READ_FILE_MODE
        int 21h
        jc open_error
        mov file_handle,ax

    ; Read the file
        mov bx, file_handle
        lea dx, text_buffer
        mov cx, BYTES_TO_READ
        int 21h
        jc read_error
        mov read_bytes, ax

    ; Close the file

        mov ah,CLOSE_FILE_FUNC_NUM
        mov bx,file_handle
        int 21h
        jc close_error
        ret
    readFile endp
;### readFile ###

open_error:

    println OPEN_FILE_ERROR
    jmp caput

read_error:

    println READ_FILE_ERROR
    jmp caput

close_error:

    println CLOSE_FILE_ERROR
    jmp caput

END