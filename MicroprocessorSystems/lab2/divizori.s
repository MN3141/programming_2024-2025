.data

.align 2 # align with 2^x bits
contor: .word 1

.text

    geti $t0 # t0<-getch() = n

loop:

    lw $t2,contor # t2<-contor
    div $t0,$t2
    mfhi $t3
    beqz $t3,DIVIDE

loop_next:
    addi $t2,$t2,1
    sw $t2,contor # contor<-t2
    beq $t2,$t0,loop_out
    j loop

DIVIDE:

    puti $t2
    put ' '
    j loop_next

loop_out:
    put 'K'
    done
