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
    digit_index_error_message db 'Error in input! Please enter an index from 1 to 4! $'
    addr_buffer db 4 dup(0) ;store symbols as numerical values
    segment_addr dw 0
    offset_addr dw 0
.code

    print_string PROC
        ;Procedure that prints a string
        ;whose address in stored in AX
        push ax
        push dx

        mov dx,ax
        mov ah,9h
        int 21h

        pop dx
        pop ax
        ret
    print_string ENDP

    println PROC
        ;Procedure for printing a new line
        push ax
        push dx

        mov dl,10 ;new line
        mov ah,2h
        int 21h

        mov dl,13 ;carriage return
        mov ah,2h
        int 21h
        
        pop dx
        pop ax

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
        
        push ax
        mov cx,4 ;16 bits for an address
        mov bx,0
    READ_LOOP:

        mov ah,1h
        int 21h
        mov address_str[bx],al ;put the ASCII character
        inc bx
        loop READ_LOOP

        mov address_str[4],'$'
        pop ax
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

        push bx
        push cx

        mov cx,4
        mov bx,0

    CONVERSION_LOOP:
        mov al,address_str[bx]
        call ascii_digit
        mov addr_buffer[bx],al
        inc bx
        loop CONVERSION_LOOP

        ;most significant byte
        mov ah,addr_buffer[0]
        shl ah,4
        mov bl,addr_buffer[1]
        add ah,bl

        ;least significant byte
        mov al,addr_buffer[2]
        shl al,4
        mov bl,addr_buffer[3]
        add al,bl

        pop cx
        pop bx
        ret
    get_address ENDP

    get_digits PROC
        ;Get the digit from a word
        ;and index given as inputs
        ;AX-word,BX-index
        ;Note:
        ;1-most significant digit
        ;4-least significant digit

        cmp bx,1
        je ONE
        cmp bx,2
        je TWO
        cmp bx,3
        je THREE
        cmp bx,4
        je FOUR
        jmp ERROR_DIGITS ;index greater than 4

    ONE:
        shr ax,12
        jmp FINISH_DIGITS

    TWO:
        shl ax,4
        shr ax,12
        jmp FINISH_DIGITS

    THREE:
        shl ax,8
        shr ax,12
        jmp FINISH_DIGITS

    FOUR:
        shl ax,12
        shr ax,12
        jmp FINISH_DIGITS
    
    ERROR_DIGITS:
        lea dx,digit_index_error_message
        mov ah,9h
        int 21h

    FINISH_DIGITS:
        ret
    get_digits ENDP

    store_digits PROC

        ;Procedure for storing hex digits from a given word
        ;The input shall be AX
        push cx
        mov cx,4
        mov bx,1

    STORE_LOOP:
        call get_digits
        mov addr_buffer[bx],al
        inc bx
        loop STORE_LOOP

        pop cx
        ret
    store_digits ENDP

    digit_ascii PROC
        ;Convert numerical value into an ASCII code
        ;AL shall be the input and the output
        ;Note:this procedure only works for lowercase letters
        cmp al,9
        jbe DECIMAL2
        cmp al,0fh
        jbe HEX_TEST

    DECIMAL2:
        add al,'0'
        jmp FINISH_ASCII

    HEX_TEST:
        cmp al,0ah
        jge HEX_TEST2

    HEX_TEST2:
        add al,87
        ;'a'-0Ah=87
        jmp FINISH_ASCII

    FINISH_ASCII:
        ret
    digit_ascii ENDP

    start:
    
        mov ax,@data
        mov ds,ax

        ;read and parse segment address
        call read_address_keyboard
        push ax
        call get_address
        mov segment_addr,ax
        pop ax

        push ax
        lea ax,colon_symbol
        call print_string
        pop ax

        ;read and parse offset address
        call read_address_keyboard
        push ax
        call get_address
        mov offset_addr,ax
        pop ax

        call println

        ;read the content of the physical address
        push ax
        mov ax,segment_addr
        mov bx,offset_addr
        call read_physical_address

        ;store digits of the content into a buffer
        mov ax,bx
        call store_digits
        pop ax

        ;store ascii codes into output string(should have used procedure)
        mov al,addr_buffer[0]
        call digit_ascii
        mov ouput_str[0],al

        mov al,addr_buffer[1]
        call digit_ascii
        mov ouput_str[1],al

        mov al,addr_buffer[2]
        call digit_ascii
        mov ouput_str[2],al

        mov al,addr_buffer[3]
        call digit_ascii
        mov ouput_str[3],al

        mov ouput_str[4],'$'

        lea ax,ouput_str
        call print_string


        mov ah,4ch
        int 21h

    end start