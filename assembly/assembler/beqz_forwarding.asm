addi r1, r0, 0
xor r2, r2, r2

ciclo:
addi r3, r3, 10
addi r2, r2, 4
beqz r1, ciclo

addi r4, r0, 65535 
ori r5, r4, 100000
