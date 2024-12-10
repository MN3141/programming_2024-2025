.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment
    dummy_string db 'This is a dummy string :)$'
.code

    ;Procedure that prints a string
    ;whose address in stored in AX
    print_string PROC
        
        mov dx,ax
        mov ah,9h
        int 21h

        ret
    print_string ENDP
    
    start:
    
    mov ax,@data
    mov ds,ax

    push ax
    lea ax,dummy_string
    call print_string
    pop ax

    mov ah,4ch
	int 21h

    end start