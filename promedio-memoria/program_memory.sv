`timescale 1ns / 1ps

// Opcodes
`define ADD      4'b0000
`define MUL      4'b0010
`define MOV      4'b0100
`define DIV_REG  4'b1100
`define LDR_IND  4'b0101
`define STR_IND  4'b0110

`define LD_IMM   6'b100000
`define CMP_IMM  6'b100011
`define INC      6'b100100
`define DEC      6'b100101
`define INPUT    6'b100110
`define OUTPUT   6'b100111
`define BRA      8'b1010_1000
`define BHI      8'b1011_0000
`define BEQ      8'b1011_0100
`define NOP      8'b0111_0000

// Registers
`define R0  2'b00
`define R1  2'b01
`define R2  2'b10
`define R3  2'b11

// labels
`define feed    8'd04
`define part2   8'd13
`define do_sum  8'd15
`define out     8'd24
`define done    8'd26

module program_memory(
    input  clk,
    input  reset,
    input  [7:0] address_bus,
    output [7:0] data_bus
    );
    
    reg [7:0] rom[255:0];
    assign data_bus = rom[address_bus];
    
    always @(posedge(clk))
        if (reset == 0) begin
            {rom[0], rom[1]}    <= {`LD_IMM, `R1, 8'd0};
            {rom[2], rom[3]}    <= {`LD_IMM, `R2, 8'd0};
            //feed:
            rom[4]              <= {`INPUT,`R0}; 
            rom[5]              <= {`STR_IND, `R0, `R1}; 
            rom[6]              <= {`INC, `R1};
            {rom[7], rom[8]}    <= {`CMP_IMM, `R1, 8'd10}; 
            {rom[9], rom[10]}   <= {`BEQ, `part2};
            {rom[11], rom[12]}  <= {`BRA, `feed};
            // part2:
            {rom[13], rom[14]}  <= {`LD_IMM, `R1, 8'd0};
            // do_sum:
            rom[15]             <= {`LDR_IND, `R0, `R1};
            rom[16]             <= {`ADD, `R2, `R0}; 
            rom[17]             <= {`INC, `R1};
            {rom[18], rom[19]}  <= {`CMP_IMM, `R1, 8'd10}; 
            {rom[20], rom[21]}  <= {`BEQ, `out};
            {rom[22], rom[23]}  <= {`BRA, `do_sum};
            // out:
            rom[24]             <= {`DIV_REG, `R2, `R1}; 
            rom[25]             <= {`OUTPUT, `R2}; 
            // done:
            {rom[26], rom[27]}  <= {`BRA, `done}; 
            rom[28]             <= `NOP;
            rom[29]             <= `NOP;
        end
endmodule

/*
    LD R1 #0 ; indice ram
    LD R2 #0 ; suma
feed:
    INPUT R0
    STR R0 [R1]
    INC R1
    CMP R1 #10
    BEQ do_sum
    BRA feed
do_sum:
    LD R1 #0 ; indice ram
    LDR R0 [R1]
    ADD R2 R0
    INC R1
    CMP R1 #10
    BEQ out
    BRA do_sum
out:
    DIV R2 R1
    OUTPUT R2
done:
    BRA done
*/