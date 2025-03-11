.data
    n: .word 10
.text

    li $t0,2 #divider
    li $t2,1 #index
    lw $t3,n
prime_loop:

    bgt $t0,$t3,prime_loop_end

    lw $a1,($t2)
    jal is_prime
    beqz $s0,prime_loop_next
    j print_num

prime_loop_next:
    addi $t2,$t2,1
    j prime_loop

prime_loop_end:
    j CAPUT
print_num:
    puti $t2
    put ' '
    j prime_loop_next

CAPUT:
    done

is_prime:

    func_loop:
        bge $t0,$a1,end_prime
        div $a1,$t0
        mfhi $t1
        beqz $t1,end_not_prime
        addi $t0,$t0,1
    func_out:
        j func_loop
end_prime:

    li $s0,0
    j func_out
end_not_prime:
    li $s0,1
    j func_out