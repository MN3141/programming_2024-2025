.data

.align 2 # align with 2^x bits
numere: .word 1,2,3,5,8,10,22 # 1 Word = 32b

.text

__start:

    li $t1,0 #Load Immediate
    li $t2,6
    li $t0,0 #sum
    li $t3,4 #for addressing an element from array
    la $t4,numere #Load Address

loop:

    mul $t5,$t1,$t3
    add $t5,$t5,$t4

    lw $t6,($t5) #Load Word
    div $t6,$t6,2
    mfhi $t8
    beqz $t8,print_even
    j INCREMENT_INDEX

print_even:
    puti $t6
    j INCREMENT_INDEX

INCREMENT_INDEX:
    addi $t3,$t3,1 #Load Immediate

    ble $t1,$t2,loop # Branch Lower or Equal
    done