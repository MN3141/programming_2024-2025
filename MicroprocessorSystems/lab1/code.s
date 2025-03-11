.data

.align 2 # align with 2^x bits
numere: .word 1,2,3,5,8,10,22 # 1 Word = 32b
.text

    li $t1,0 #Load Immediate
    li $t2,6
    li $t0,0 #sum
    li $t3,4 #for addressing an element from array
    la $t4,numere #Load Address

loop:

    mul $t5,$t1,$t3
    add $t5,$t5,$t4

    lw $t6,($t5) #Load Word
    add $t0,$t0,$t6
    addi $t3,$t3,1 #Load Immediate
    ble $t1,$t2,loop # Branch Lower or Equal

    puts SumaEste
    puti $t0

    li,$t1,10
    div,$t0,$t1

    mflo $t2 # Move From Low
    mfhi $t1 # Move From High
    done
