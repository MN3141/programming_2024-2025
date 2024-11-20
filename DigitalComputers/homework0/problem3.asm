;Afișați pe ecran primele 25 litere ale alfabetului fără sa le cititi dintr-un string.
.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

.code
print_string proc
    
    ;print the first 25 letters of the English alphabet

    mov cx,25
    mov bl,0

    PRINT_LOOP:
        mov dl,'A'
        add dl,bl
        
        mov ah,2
        int 21h

        inc bl
    loop PRINT_LOOP

    ret
print_string endp

    start:

    mov ax,@data
    mov ds,ax

    call print_string
    
    mov ah,4ch
	int 21h

    end start