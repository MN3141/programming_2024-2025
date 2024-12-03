.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

.code

    get_kbd_codes PROC
        ;Get scan code and ASCII code for a pressed key
        ;return the output into AX register

        mov ah,0
        int 16h ;BIOS interrupt
        ;AH<-Scan code
        ;AL<-ASCII code

        ret
    get_kbd_codes ENDP
    start:
    
    mov ax,@data
    mov ds,ax

    push ax
    call get_kbd_codes
    pop ax
    
    mov ah,4ch
	int 21h

    end start