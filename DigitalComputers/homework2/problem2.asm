;Să se scrie un program pentru introducerea unui text de la tastatură folosind
;funcţia 3FH a întreruperii INT 21H (serviciu DOS).
.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment
    buffer db 256 dup(0)
.code

    read_n_bytes PROC
        ;read from keyboard using function 3FH
        ;take number of bytes to be read in CX as input

        ;AX shall return the number of read bytes

        push bx
        push dx

        mov bx,0
        lea dx,buffer

        mov ah,3FH
        int 21h
        ;Note:
        ;Num read bytes=read symbols+CR+LF
        ;Unix uses only LF
        ;CR-LF Enter in DOS/Windows
        pop dx
        pop bx

        ret
    read_n_bytes ENDP
    start:
    
    mov ax,@data
    mov ds,ax

    push ax
    push cx
    mov cx,10
    call read_n_bytes
    pop cx
    pop ax

    mov ah,4ch
	int 21h

    end start