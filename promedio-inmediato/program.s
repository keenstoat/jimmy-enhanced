start:
    MOV R1 #0 ; suma
    MOV R2 #0 ; contador
loop:
    INPUT R0
    ADD R1 R0
    INC R2
    CMP R2 #10
    BEQ out
    BRA loop
out:
    DIV R1 R2
    OUTPUT R1
done:
    BRA done