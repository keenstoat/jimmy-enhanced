start:
    MOV R2 #0   ; primos encontrados
    MOV R0 #0   ; indice ram
primes:
    CMP R0 #255 ; ram ends: 1μP=255, 2μP=127, 4μP=63, 8μP=31
    BEQ output
    LDR R1 [R0]
branching:
    CMP R1 #179
    BHI cuarto_4
    CMP R1 #103
    BHI cuarto_3
    CMP R1 #43
    BHI cuarto_2
    
cuarto_1:
    CMP R1 #2
    BEQ found
    CMP R1 #3
    BEQ found
    CMP R1 #5
    BEQ found
    CMP R1 #7
    BEQ found
    CMP R1 #11
    BEQ found
    CMP R1 #13
    BEQ found
    CMP R1 #17
    BEQ found
    CMP R1 #19
    BEQ found
    CMP R1 #23
    BEQ found
    CMP R1 #29
    BEQ found
    CMP R1 #31
    BEQ found
    CMP R1 #37
    BEQ found
    CMP R1 #41
    BEQ found
    CMP R1 #43
    BEQ found
    BRA next
cuarto_2:
    CMP R1 #47
    BEQ found
    CMP R1 #53
    BEQ found
    CMP R1 #59
    BEQ found
    CMP R1 #61
    BEQ found
    CMP R1 #67
    BEQ found
    CMP R1 #71
    BEQ found
    CMP R1 #73
    BEQ found
    CMP R1 #79
    BEQ found
    CMP R1 #83
    BEQ found
    CMP R1 #89
    BEQ found
    CMP R1 #97
    BEQ found
    CMP R1 #101
    BEQ found
    CMP R1 #103
    BEQ found
    BRA next
cuarto_3:
    CMP R1 #107
    BEQ found
    CMP R1 #109
    BEQ found
    CMP R1 #113
    BEQ found
    CMP R1 #127
    BEQ found
    CMP R1 #131
    BEQ found
    CMP R1 #137
    BEQ found
    CMP R1 #139
    BEQ found
    CMP R1 #149
    BEQ found
    CMP R1 #151
    BEQ found
    CMP R1 #157
    BEQ found
    CMP R1 #163
    BEQ found
    CMP R1 #167
    BEQ found
    CMP R1 #173
    BEQ found
    CMP R1 #179
    BEQ found
    BRA next
cuarto_4:
    CMP R1 #181
    BEQ found
    CMP R1 #191
    BEQ found
    CMP R1 #193
    BEQ found
    CMP R1 #197
    BEQ found
    CMP R1 #199
    BEQ found
    CMP R1 #211
    BEQ found
    CMP R1 #223
    BEQ found
    CMP R1 #227
    BEQ found
    CMP R1 #229
    BEQ found
    CMP R1 #233
    BEQ found
    CMP R1 #239
    BEQ found
    CMP R1 #241
    BEQ found
    CMP R1 #251
    BEQ found
    BRA next
found:
    ADD R2 #1
next:
    ADD R0 #1
    BRA primes
output:
    OUTPUT R2
done:
    BRA done

