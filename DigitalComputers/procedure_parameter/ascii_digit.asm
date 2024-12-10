.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment
    error_msg db 'Invalid symbol! Please use hexadecimal ones.$'
.code

    ;Convert ASCII code to numerical value
    ;AL shall be the input and the output
    ascii_digit PROC
        
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
        lea dx,error_msg
        mov ah,9h
        int 21h

    FINISH:
        ret
    ascii_digit ENDP
    
    start:
    
    mov ax,@data
    mov ds,ax

    push ax
    mov ah,0
    mov al,'0'
    call ascii_digit
    pop ax

    mov ah,4ch
	int 21h

    end start