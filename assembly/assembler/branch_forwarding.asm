addi r1, r0, 100
xor r2, r2, r2

ciclo:
addi r3, r3, 10
subi r1, r1, 1
addi r2, r2, 4
nop
bnez r1, ciclo

addi r4, r0, 65535 
ori r5, r4, 100000
