start:
    MOV R1 #0 ; indice ram
    MOV R3 #1 ; swap necesario
input:
    INPUT R0
    STR R0 [R1]
    INC R1
    CMP R1 #10
    BEQ outer_loop
    BRA input
outer_loop:
    MOV R1 #0 ; indice elemento 1
    CMP R3 #0
    BEQ output
    MOV R3 #0 ; clear swap flag
ordenar:
    CMP R1 #9
    BEQ outer_loop
    LDR R0 [R1] ; cargar valor 1
    INC R1
    LDR R2 [R1] ; cargar valor 2
    CMP R0 R2
    BHI swap
    BRA ordenar
swap:
    MOV R3 #1
    STR R0 [R1] ; R1 esta en la pos de valor 2
    DEC R1
    STR R2 [R1]
    INC R1
    BRA ordenar
output:
    LDR R0 [R1]
    OUTPUT R0
    INC R1
    CMP R1 #10
    BEQ done
    BRA output
done:
    BRA done