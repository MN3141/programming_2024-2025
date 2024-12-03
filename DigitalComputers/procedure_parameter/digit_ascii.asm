.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

.code

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

    mov ah,4ch
	int 21h

    end start