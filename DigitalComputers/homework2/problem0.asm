;Să se scrie un program care să examineze biţii de la adresa 0040:0017H
;pentru diferite stări ale tastelor Insert, CapsLock, NumLock, ScrollLock, Alt, Ctrl şi Shift.

.model small ;1 64KB code segment and 1 64KB data segment
.stack 100 ;stack segment of 100B
.data ;data segment

.code

    read_key PROC

        mov ah,0h
        int 16h

        ret
    read_key ENDP
    
    check_special_keys PROC
        ;check if any special keys were also pressed (e.g. Insert,CapsLock...)
        push ax

        mov ah,[0040h:0017h]
        pop ax

        ret
    check_special_keys ENDP
    start:
    
    mov ax,@data
    mov ds,ax

    call read_key
    call check_special_keys

    mov ah,4ch
	int 21h

    end start