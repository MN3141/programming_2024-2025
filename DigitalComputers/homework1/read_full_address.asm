;Să se scrie un program care să accepte ca parametru de intrare (de la
;tastatură) adresa fizică în hexazecimal (adresa Segment:Offset) a unei locaţii de memorie
;şi să returneze în hexazecimal codul (conţinutul) acelei locaţii.

.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment
    address_str db 5 dup(0) ;used for segment/offset address
    ouput_str db 5 dup(0) ;used for PC screen
    colon_symbol db ':$'
    ascii_error_msg db 'Invalid symbol! Please use hexadecimal ones.$'
    temp db 0
.code

    print_string PROC
        ;Procedure that prints a string
        ;whose address in stored in AX
        mov dx,ax
        mov ah,9h
        int 21h

        ret
    print_string ENDP

    println PROC
        ;Procedure for printing a new line

        mov dl,10 ;new line
        mov ah,2h
        int 21h

        mov dl,13 ;carriage return
        mov ah,2h
        int 21h

        ret
    println ENDP

    read_physical_address PROC
        
        ;Procedure for reading content of a given physical address
        ;using AX and BX as inputs
        ;BX shall be the output

        push ds
        mov ds,ax
        mov bx,ds:[bx]
        pop ds
        ret
    name ENDP

    read_address_keyboard PROC
        ;Procedure for reading segment/offset address
        
        mov cx,4 ;16 bits for an address
        mov bx,0

    READ_LOOP:

        mov ah,1h
        int 21h
        mov address_str[bx],al ;put the ASCII character
        inc bx
        loop READ_LOOP

        mov address_str[4],'$'
        ret
    read_address_keyboard ENDP

    
    ascii_digit PROC
        ;Convert ASCII code to numerical value
        ;AL shall be the input and the output
        ;Note:this procedure only works for lowercase letters
        cmp al,'9'
        jbe DECIMAL
        cmp al,'f'
        jbe HEX0
        jmp ERROR

    DECIMAL:
        sub al,'0'
        jmp FINISH

    HEX0:
        cmp al,'a'
        jge HEX1
        jmp ERROR

    HEX1:
        sub al,'a'
        add al,10
        jmp FINISH

    ERROR:
        lea dx,ascii_error_msg
        mov ah,9h
        int 21h

    FINISH:
        ret
    ascii_digit ENDP

    get_address PROC
        ;Procedure for computing the segment/offset address
        ;The output shall be AX

        push ax
        push dx

        mov al,address_str[0]
        call ascii_digit
        mov dh,al
        
        pop dx
        pop ax
        ret
    get_address ENDP
    start:
    
        mov ax,@data
        mov ds,ax

        mov ah,4ch
        int 21h

    end start