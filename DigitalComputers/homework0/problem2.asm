;Cititi de la tastatura un număr format din 2 cifre și afișați numărul siftat la dreapta cu 2.

;For this task we shall substract 48 from every ASCII character
.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

    stop_key db 13 ;CR character
    num db 3 dup(0)

.code
read_num proc

    ;read a string until Enter key is pressed
    ;AL stores the read ASCII character from keyboard
        mov bx,0 ;index
        mov dl,stop_key
    READ_AGAIN:

        mov ah,1h ;read from keyboard without echo
        int 21h

        cmp al,dl
        jz EXIT_PROC

        mov num[bx],al
        inc bx
        jmp READ_AGAIN

    EXIT_PROC:
    mov num[bx], '$' ;terminator character
    ret
read_num endp

shift_number proc
    
    ;get digits into AX,obtain numerical value and shift it

    ;get digits
    mov bl,10
    mov al,num[0]
    sub al,'0'
    mul bl

    mov ah,num[1]
    sub ah,'0'
    add al,ah

    ;shift value
    shr al,2

    ret
shift_number endp

put_number proc

    ;put digits from AX into an array

    mov bl,10
    div bl ;AL<-AL/10,AH<-AL%10

    add ah,'0'
    add al,'0'

    mov num[0],ah
    mov num[1],al

    ret

put_number endp
print_num proc
    lea dx,num
    mov ah,9h
    int 21h
    ret
print_num endp

start:
    mov ax,@data
    mov ds,ax

    call read_num
    call shift_number
    call put_number
    call print_num

    mov ah,4ch
	int 21h
end start