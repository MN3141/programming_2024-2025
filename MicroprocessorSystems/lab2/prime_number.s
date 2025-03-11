.data
    n: .word 12
.text

    li $t0,2
    jal is_prime

done

is_prime:

    func_loop:
        bge $t0,$a1,end_prime
        div $a1,$t0
        mfhi $t1
        beqz $t1,end_not_prime
        addi $t0,$t0,1
        j func_loop
end_prime:

end_not_prime: