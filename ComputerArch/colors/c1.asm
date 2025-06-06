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
mov cx,[bp+4] ;y2
sub cx,[bp+8] ;y2-y1
mov di,cx
mov bx,[bp+8] ;y1
e1: mov cx,[bp+6] ;x2
sub cx,[bp+10] ;x2-x1
mov dx,[bp+10] ;x1
e2: push dx
mov ax,320
mul bx
pop dx
add ax,dx
mov si,ax ;si=320*y+x
mov ax,[bp+2] ;culoare
mov es:[si],al
inc dx ;x++
loop e2
inc bx ;y++
dec di
jnz e1
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
start:
mov ax,@data
mov es,ax
call GetVideoMode ;citirea modului video curent
mov crtmode,al
mov al,13h
call SetVideoMode ;setarea modului video 13h
mov ax,10 ;x1
push ax
mov ax,10 ;y1
push ax
mov ax,50 ;x2
push ax
mov ax,50 ;y2
push ax
mov ax,1 ;color
push ax ;transmiterea parametrilor se face prin stiva !!!
call Square ;desenarea unui dreptunghi
call Getch ;asteptarea unei taste
    mov bx,1 ;culoare 1 (albastru)
    mov ch,0 ;intensitate verde
    mov cl,0 ;intensitate albastru
    mov dh,0 ;intensitate rosu
    call SetColorRegister ;modificarea definitiei culorii 1 (albastru)
call Getch ;asteptarea unei taste
    mov bx,1 ;culoare 1 (albastru)
    mov ch,0 ;intensitate verde
    mov cl,255 ;intensitate albastru
    mov dh,0 ;intensitate rosu
    call SetColorRegister ;modificarea definitiei culorii 1 (albastru)
call Getch
mov al,crtmode
call SetVideoMode ;restaurarea modului video initial
mov ax,4c00h ;terminarea programului
int 21h
end start
;**********************************************************************