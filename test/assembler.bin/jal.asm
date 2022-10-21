addi r2, r25, #5 ; just to try 
myloop:
addi r1, r4, #10   ; r1 <= 1, 17 , 145
addi r3, r4, #15   ; r1 <= 2, 18 , 146
add r30, r31, #0    ; r1 <= 4, 36 , 292
jal myloop   	  ; PC = PC + 4 - 11*4 = -40 (28 hexadecimal) = go to the beginning of the program. 