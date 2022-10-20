addi r9, r2, #50    ; IF  ID  EXE MEM  WB
addi r10, r2, #50   ;     IF  ID  EXE MEM   WB
add r11, r9, r10    ;         IF  ID  EXE  MEM  WB   alu_forwarding_two
addi r1, r2, #1
;add r1, r11, r10    ;             IF   ID  EXE MEM WB alu_forwarding_one mem_forwarding_two