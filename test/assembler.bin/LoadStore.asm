myloop:

addi r2, r2, #9  ;   2 <= 9                    -->  2 <= 18
sw 20(r1), r2  	 ;   Address = 20    Data = 9  -->  Address = 20  Data = 18		
addi r6, r15, #0 ;   6 <= 0                    -->  6 <= 9
addi r4, r3, #10 ;   4 <= 10                   -->  4 <= 10
addi r7, r0, #8  ;   7 <= 8                    -->  7 <= 8
lw r15, 20(r1)   ;   Address = 20    Data = 9  -->  Address = 20  Data = 18
jal myloop       ;   Jump and link	     
