`timescale 1ns / 1ps

// Opcodes
`define ADD      4'b0000
`define MUL      4'b0010
`define CMP_REG  6'b0011
`define MOV      4'b0100
`define DIV_REG  4'b1100
`define LDR_IND  4'b0101
`define STR_IND  4'b0110

`define MOV_IMM  6'b100000
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
`define start       8'd00
`define input       8'd04
`define outer_loop  8'd13
`define ordenar     8'd21
`define swap        8'd33
`define output      8'd41
`define done        8'd50

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
            // start:
            {rom[0], rom[1]}    <= {`MOV_IMM, `R1, 8'd0};
            {rom[2], rom[3]}    <= {`MOV_IMM, `R3, 8'd1};
            //input
            rom[4]              <= {`INPUT,`R0}; 
            rom[5]              <= {`STR_IND, `R0, `R1}; 
            rom[6]              <= {`INC, `R1};
            {rom[7], rom[8]}    <= {`CMP_IMM, `R1, 8'd10}; 
            {rom[9], rom[10]}   <= {`BEQ, `outer_loop};
            {rom[11], rom[12]}  <= {`BRA, `input};
            // outer_loop:
            {rom[13], rom[14]}  <= {`MOV_IMM, `R1, 8'd0};
            {rom[15], rom[16]}  <= {`CMP_IMM, `R3, 8'd0}; 
            {rom[17], rom[18]}  <= {`BEQ, `output};
            {rom[19], rom[20]}  <= {`MOV_IMM, `R3, 8'd0};
            // ordenar:
            {rom[21], rom[22]}  <= {`CMP_IMM, `R1, 8'd9}; 
            {rom[23], rom[24]}  <= {`BEQ, `outer_loop};
            rom[25]             <= {`LDR_IND, `R0, `R1};
            rom[26]             <= {`INC, `R1};
            rom[27]             <= {`LDR_IND, `R2, `R1};
            rom[28]             <= {`CMP_REG, `R0, `R2};
            {rom[29], rom[30]}  <= {`BHI, `swap};
            {rom[31], rom[32]}  <= {`BRA, `ordenar};
            // swap
            {rom[33], rom[34]}  <= {`MOV_IMM, `R3, 8'd1};
            rom[35]             <= {`STR_IND, `R0, `R1}; 
            rom[36]             <= {`DEC, `R1};
            rom[37]             <= {`STR_IND, `R2, `R1}; 
            rom[38]             <= {`INC, `R1};
            {rom[39], rom[40]}  <= {`BRA, `ordenar};
            // output
            rom[41]             <= {`LDR_IND, `R0, `R1};
            rom[42]             <= {`OUTPUT, `R0};
            rom[43]             <= {`INC, `R1};
            {rom[44], rom[45]}  <= {`CMP_IMM, `R1, 8'd10}; 
            {rom[46], rom[47]}  <= {`BEQ, `done};
            {rom[48], rom[49]}  <= {`BRA, `output};
            // done:
            {rom[50], rom[51]}  <= {`BRA, `done}; 
            rom[52]             <= `NOP;
            rom[53]             <= `NOP;
        end
endmodule
