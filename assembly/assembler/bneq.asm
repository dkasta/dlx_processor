addi r25, r20, #50 ; r25 <= 1
myloop:
add r1, r1, r25   ; r1 <= 1
bneq r2, myloop   	  ; PC = PC + 4 - 11*4 = -40 (28 hexadecimal) = go to the beginning of the program. 
addi r3, r20, #50 ; r25 <= 1
addi r2, r20, #50 ; r25 <= 1

