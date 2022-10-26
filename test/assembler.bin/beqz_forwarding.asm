addi r1, r0, 0     ; 1 <- 0
xor r2, r2, r2     ; 2 <- 0

ciclo:
addi r3, r3, 10    ; 3 <- 10     3 <- 20
addi r2, r2, 4     ; 2 <- 4      2 <- 8
beqz r1, ciclo     ; branch      branch

addi r4, r0, 65535 
ori r5, r4, 100000
