seq r25, r25, r25 ; r25 <= 1
sne r20, r25, r20 ; r20 <= 1 
myloop:
add r1, r31, r25   ; r1 <= 1   ->  17
add r1, r25, r1   ; r1 <= 2   ->  18
add r1, r1, r1    ; r1 <= 4   ->  36
add r1, r1, r1    ; r1 <= 8   ->  72
add r1, r1, r1    ; r1 <= 16  -> 144
xor r20, r20, r25 ; r20 <= 0     1
jal  myloop   	  ; PC = PC + 4 - 11*4 = -40 (28 hexadecimal) = go to the beginning of the program. 
