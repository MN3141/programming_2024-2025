;Cititi de la tastatura numele vostru ?i afi?a?i-l ?n consola.
.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

    stop_key db 13 ;CR character
    full_name db 100 dup(0)

.code
read_name proc

    ;read a string until Enter key is pressed
    ;AL stores the read ASCII character from keyboard
        mov bx,0 ;index
        mov dl,stop_key
    READ_AGAIN:

        mov ah,1h ;read from keyboard without echo
        int 21h

        cmp al,dl
        jz EXIT_PROC

        mov full_name[bx],al
        inc bx
        jmp READ_AGAIN

    EXIT_PROC:
    mov full_name[bx], '$' ;terminator character
    ret
read_name endp

print_name proc
    lea dx,full_name
    mov ah,9h
    int 21h
    ret
print_name endp

start:
    mov ax,@data
    mov ds,ax

    call read_name
    call print_name

    mov ah,4ch
	int 21h
end start