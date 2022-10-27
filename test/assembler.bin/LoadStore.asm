myloop:

addi r1, r1, #10 ;   r1 <= 10
addi r2, r2, #9  ;   r2 <= 9             
sw 10(r1), r2  	 ;   r1 mem_forwarding_one and r2 forwarding 	
                 ;   Address = 20   Data = 9
addi r6, r15, #0 ;   r6 <= 0             
addi r4, r3, #10 ;   r4 <= 10            
addi r7, r0, #8  ;   r7 <= 8             
lw r15, 10(r1)   ;   Address = 20   Data = 9
jal myloop       ;   Jump and link	     
