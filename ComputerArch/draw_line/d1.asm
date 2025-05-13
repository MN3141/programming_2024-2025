; 9.1 -> both putpixelbios and putpixeldirectmemory work for mode 12h
; 9.2 -> putpixelbios works for mode 13h
;**********************************************************************
.model small
.stack 100h
.data
    oldmode db ? ;va stoca modul video precedent
    dtX dw ?
    dtY dw ?
.code
;**********************************************************************
; Procedura: SetVideoMode
; Descriere: Setarea unui mod video.
; Parametri: al - modul video.
;**********************************************************************
SetVideoMode proc near
    mov ah,00h
    int 10h
    ret
SetVideoMode endp
;**********************************************************************
; Procedura: GetVideoMode
; Descriere: Citirea modului video curent.
; Parametri: Returneaza in al modul video.
;**********************************************************************
GetVideoMode proc near
    mov ah,0Fh
    int 10h
    ret
GetVideoMode endp
;**********************************************************************
; Procedura: PutPixel
; Descriere: Afisarea unui pixel de o anumita culoare.
; Parametri: dx rand, y
;            cx col,  x
;            al culoarea;
; Procedura: PutPixelMod12
;**********************************************************************
PutPixelMod12 proc near
    mov ah, 0Ch
    mov bx,0h
    int 10h
    ret
PutPixelMod12 endp

;**********************************************************************
; Procedura: DrawLine
; Descriere: Afisarea unei linii oarecare de o anumita culoare. Implementare
;            folosind algoritmul Brezenham
; Parametri: cx - x0  
;            dx - y0
;            si - x1
;            di - y1
;            al - culoarea       
;***********************************************************************
HorizontalLine proc near
    mov [dtX], si
    sub [dtX],cx  ; dx = x1 - x0

    mov [dtY],di
    sub [dtY],dx  ; dy = y1 - y0

    shl [dtY], 1     ; dy = dy * 2
    mov bp, [dtY]
    sub bp, [dtX]    ; D = 2*dy - dx

    ; y = y0 => dx

    shl [dtX], 1

forLoop:
    cmp cx,si
    jge finish

    call PutPixelMod12

    cmp bp,0
    jle et1
    inc dx
    sub bp, [dtX]
et1:
    add bp, [dtY]

    inc cx ; x++
    jmp forLoop
finish:
    ret
HorizontalLine endp
;**********************************************************************
; Procedura: Getch
; Descriere: Asteptarea apasarii unei taste.
; Parametri: Nu are.
;**********************************************************************
Getch proc near
    mov ah,0
    int 16h
    ret
Getch endp
;**********************************************************************
; Programul principal.
;**********************************************************************
start:
    mov ax,@data
    mov ds,ax
    call GetVideoMode;citirea modului video curent
    mov oldmode,al
    mov al,12h      ;setarea modului grafic 12h
    call SetVideoMode
    mov cx, 1
    mov dx, 1
    mov si, 320
    mov di, 320
    mov al, 4
    call HorizontalLine ;trasarea liniei orizontale
    call Getch      ;asteptarea apasarii unei taste
    mov al,oldmode
    call SetVideoMode ;restaurarea modului video initial
    mov ax,4c00h    ;iesirea din program
    int 21h
end start
;**********************************************************************