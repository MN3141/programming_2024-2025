.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment
    string db 'Please enter a symbol: $'
start:

    mov ax,@data
	mov ds,ax

    lea dx,string
	mov ah,9h ;print text
	int 21h
    ;Note:the text shall be printed from DS:DL

    mov ah,7h
	;Note:mov ah,1h ;read from keyboard without echo
    int 21h
	mov ah,2h;DL is used for printing
	mov dl,al;the value is read in AL
    int 21h

	mov ah,4ch
	int 21h
end start