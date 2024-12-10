;Test 0 for procedure with parameters

.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

;In C:
;short in compute_double(short int ax){
;
;   return ax<<1;}

.code

compute_double PROC
    ;compute double the value of a given parameter
    ;AX shall be used as the input
    shl ax,1
    ret
compute_double ENDP

    start:
    
    mov ax,@data
    mov ds,ax
    
    push ax ;store AX
    mov ax,10
    call compute_double
    mov dx,ax
    pop ax

    mov ah,4ch
	int 21h
    end start