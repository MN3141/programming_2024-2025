.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment
    x db 1

parity_check proc

    ;AL shall take the input
    ;AX shall be the output
    ;1-is even
    ;0-is odd
    mov ah,0
    mov al,x

    mov dl,2
    div dl

    cmp ah,0
    jz even
    
odd:mov ah,0
jmp proc_end
even:mov ah,1
proc_end:
ret
parity_check endp
.code
    start:
        mov ax,@data
        mov ds,ax

        call parity_check

        mov ah,x
        mov ah,4ch
	    int 21h
    end start
