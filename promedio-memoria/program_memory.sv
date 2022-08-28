`timescale 1ns / 1ps

// Opcodes
`define ADD      4'b0000
`define MUL      4'b0010
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
`define start   8'd00
`define input   8'd04
`define ini_sum 8'd13
`define do_sum  8'd15
`define output  8'd24
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
            //start:
            {rom[0], rom[1]}    <= {`MOV_IMM, `R1, 8'd0};
            {rom[2], rom[3]}    <= {`MOV_IMM, `R2, 8'd0};
            //input:
            rom[4]              <= {`INPUT,`R0}; 
            rom[5]              <= {`STR_IND, `R0, `R1}; 
            rom[6]              <= {`INC, `R1};
            {rom[7], rom[8]}    <= {`CMP_IMM, `R1, 8'd10}; 
            {rom[9], rom[10]}   <= {`BEQ, `ini_sum};
            {rom[11], rom[12]}  <= {`BRA, `input};
            // ini_sum:
            {rom[13], rom[14]}  <= {`MOV_IMM, `R1, 8'd0};
            // do_sum:
            rom[15]             <= {`LDR_IND, `R0, `R1};
            rom[16]             <= {`ADD, `R2, `R0}; 
            rom[17]             <= {`INC, `R1};
            {rom[18], rom[19]}  <= {`CMP_IMM, `R1, 8'd10}; 
            {rom[20], rom[21]}  <= {`BEQ, `output};
            {rom[22], rom[23]}  <= {`BRA, `do_sum};
            // output:
            rom[24]             <= {`DIV_REG, `R2, `R1}; 
            rom[25]             <= {`OUTPUT, `R2}; 
            // done:
            {rom[26], rom[27]}  <= {`BRA, `done}; 
            rom[28]             <= `NOP;
            rom[29]             <= `NOP;
        end
endmodule
