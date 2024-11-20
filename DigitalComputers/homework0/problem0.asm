;Afișați în hexazecimal un DW( 2 bytes) începând de la adresa 0713h:00FEh.
.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

    word_digits db 1,2,3,4
    output_string db 5 dup(0) ;output string for screen

.code

fetch_word proc

    ;fetches a word into AX from a fixed physical address
    mov ax,[0713h]:[00FEh]
    ret

fetch_word endp

get_digits proc

    ;get digits from AX into an array

    ;AH:
    mov dx,ax
    shr ah,4
    mov word_digits[0],ah

    mov ax,dx
    shl ah,4
    shr ah,4
    mov word_digits[1],ah

    ;AL:
    mov dx,ax
    shr al,4
    mov word_digits[2],al

    mov ax,dx
    shl al,4
    shr al,4
    mov word_digits[3],al

    mov ax,dx

    ret

get_digits endp
convert_to_ascii proc

    ;converts the digits from AX into ASCII characters
    ;and stores them into an array

    ;Note:for this task we only need 4 bytes

    mov CX,4
    mov BX,CX
CONVERT_LOOP:

    mov dl,word_digits[bx]
    cmp dl,9
    jle DECIMAL

    add dl,55
    ;Note:
    ;A=10,'A'=65
    ;'A'-A=55
    jmp CONTINUE
DECIMAL:
    add dl,'0'
CONTINUE:
    mov output_string[bx],dl
    dec BX
    loop CONVERT_LOOP

    mov output_string[5],'$' ;terminator character
    ret
convert_to_ascii endp

print_string proc
    lea dx,output_string
    mov ah,9h
    int 21h
    ret
print_string endp

    start:
        mov ax,@data
        mov ds,ax

        call fetch_word
        call get_digits
        call convert_to_ascii
        call print_string

        mov ah,4ch
	    int 21h
    end start