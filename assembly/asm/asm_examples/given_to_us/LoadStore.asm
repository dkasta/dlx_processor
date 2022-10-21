   myloop:

addi r2, r1, #9
nop
nop
sw 20(r1), r2  
addi r6, r0, 4
addi r4, r3, #10     ; should stall
addi r7, r0, #8 ;move label into r7
lw r15, 20(r1)
jal myloop        	    ;jump
