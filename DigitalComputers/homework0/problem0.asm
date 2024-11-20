;Afișați în hexazecimal un DW( 2 bytes) începând de la adresa 0713h:00FEh.
.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

    word_digits db 1,2,3,4
    output_string db 5 dup(0) ;output string for screen
.code

fetch_word proc

    ;fetches a word into AX from a fixed location
    push DS;store DS register!
    mov bx,0713h
    mov ds,bx
    mov bx,00FEh
    mov ax,word ptr ds:[bx]
    pop DS
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

    
convert_to_ascii endp

    start:
        mov ax,@data
        mov ds,ax

        ;setup 0713h:00FEh location
        mov BX,0FFh
        mov word ptr 0713h:[00FEh],BX
        call fetch_word
        call get_digits

        mov ah,4ch
	    int 21h
    end start