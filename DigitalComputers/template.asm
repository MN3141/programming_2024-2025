.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

.code

    start:
    
    mov ax,@data
    mov ds,ax

    mov ah,4ch
	int 21h

    end start