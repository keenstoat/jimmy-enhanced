start:
    MOV R1 #0 ; indice ram
    MOV R2 #0 ; suma
input:
    INPUT R0
    STR R0 [R1]
    INC R1
    CMP R1 #10
    BEQ ini_sum
    BRA input
ini_sum:
    MOV R1 #0 ; indice ram
do_sum:
    LDR R0 [R1]
    ADD R2 R0
    INC R1
    CMP R1 #10
    BEQ output
    BRA do_sum
output:
    DIV R2 R1
    OUTPUT R2
done:
    BRA done