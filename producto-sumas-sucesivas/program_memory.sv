`timescale 1ns / 1ps

// Opcodes
`define ADD      4'b0000
`define MUL      4'b0010
`define MOV      4'b0100
`define MOV_IMM  6'b100000
`define CMP_IMM  6'b100011
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
`define loop    8'd04
`define out     8'd12
`define done    8'd13

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
            
            {rom[0], rom[1]}    <= {`MOV_IMM, `R2, 8'd0};
            rom[2]              <= {`INPUT,`R0};
            rom[3]              <= {`INPUT,`R1};
            {rom[4], rom[5]}    <= {`CMP_IMM, `R1, 8'd0}; // loop:
            {rom[6], rom[7]}    <= {`BEQ, `out};
            rom[ 8]             <= {`ADD, `R2, `R0};
            rom[ 9]             <= {`DEC, `R1};
            {rom[10], rom[11]}  <= {`BRA, `loop};
            rom[12]             <= {`OUTPUT, `R2}; // out:
            {rom[13], rom[14]}  <= {`BRA, `done}; // done:
            rom[15]             <= `NOP;
            rom[16]             <= `NOP;
     end
endmodule

/*
    LD R2 #0
    INPUT R0
    INPUT R1
loop:
    CMP R1 #0
    BEQ out
    ADD R2 R0
    DEC R1
    BRA loop
out:
    OUTPUT R2
done:
    BRA done
*/