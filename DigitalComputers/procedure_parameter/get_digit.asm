.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment
    error_message db 'Error in input! Please enter an integer from 1 to 4!$'
.code

    ;Get the digit from a word
    ;and index given as inputs
    ;AX-word,BX-index
    get_digits PROC
        
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
        jmp ERROR ;index greater than 4

    ONE:
        shr ax,12
        jmp FINISH

    TWO:
        shl ax,4
        shr ax,12
        jmp FINISH

    THREE:
        shl ax,8
        shr ax,12
        jmp FINISH

    FOUR:
        shl ax,12
        shr ax,12
        jmp FINISH
    
    ERROR:
        lea dx,error_message
        mov ah,9h
        int 21h

    FINISH:
        ret
    get_digits ENDP
    start:
    
    mov ax,@data
    mov ds,ax

    push ax
    push bx
    mov ax,1a2bh
    mov bx,5
    call get_digits
    pop bx
    pop ax

    mov ax,4ch
	int 21h

    end start