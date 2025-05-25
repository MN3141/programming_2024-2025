;**********************************************************************
.model small
.stack 100h
.data
crtmode db 0
.code
;**********************************************************************
SetVideoMode proc near
    mov ah,00h
    int 10h
    ret
SetVideoMode endp
;**********************************************************************
GetVideoMode proc near
    mov ah,0Fh
    int 10h
    ret
GetVideoMode endp
;**********************************************************************
Square proc near
    mov ax,0A000h
    mov es,ax
    mov bp,sp
    mov cx,[bp+4] ; y2
    sub cx,[bp+8] ; y2 - y1
    mov di,cx
    mov bx,[bp+8] ; y1
e1: mov cx,[bp+6] ; x2
    sub cx,[bp+10] ; x2 - x1
    mov dx,[bp+10] ; x1
e2: push dx
    mov ax,320
    mul bx
    pop dx
    add ax,dx
    mov si,ax ; si = 320 * y + x
    mov ax,[bp+2] ; culoare
    mov es:[si],al
    inc dx ; x++
    loop e2
    inc bx ; y++
    dec di
    jnz e1
    ret
Square endp
;**********************************************************************
SetColorRegister proc near
    mov ax,1010h
    int 10h
    ret
SetColorRegister endp
;**********************************************************************
Getch proc near
    mov ah,0
    int 16h
    ret
Getch endp
;**********************************************************************
SetBlueToGreenGradient proc near
    mov dx,03C8h
    xor al,al
    out dx,al ; index = 0

    inc dx        ; dx = 03C9h (PEL DATA REGISTER)
    mov cx,256

NextColor:
    push cx
    mov bx,256
    mov ax,256
    sub ax,cx
    mov si,ax

    ; Green
    mov ax,si
    mov dx,0
    mov bx,255
    mul bx
    mov bx,255
    div bx
    mov bl,al

    ; Blue
    mov al,63
    sub al,bl

    xor ah,ah
    out dx,al
    out dx,al
    out dx,al

    pop cx
    loop NextColor
    ret
SetBlueToGreenGradient endp
;**********************************************************************
DrawMira proc near
    mov ax,0A000h
    mov es,ax
    xor bx,bx         ; screen middle
    mov cx,320        ; screen length

    mov dx,90
    mov ax,320
    mul dx
    mov di,ax

LoopMira:
    mov al,cl
    sub al,1
    mov es:[di],al
    inc di
    loop LoopMira
    ret
DrawMira endp
;**********************************************************************
start:
    mov ax,@data
    mov ds,ax

    call GetVideoMode
    mov crtmode,al

    mov al,13h
    call SetVideoMode

    call SetBlueToGreenGradient
    call DrawMira

    call Getch

    mov al,crtmode
    call SetVideoMode

    mov ax,4C00h
    int 21h
end start
;**********************************************************************
