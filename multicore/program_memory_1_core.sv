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
`define primes      8'd04
`define cuarto_1    8'd13
`define cuarto_2    8'd21
`define cuarto_3    8'd33
`define cuarto_4    8'd33
`define found       8'd33
`define next        8'd33
`define output      8'd41
`define done        8'd50

`define ram_page    8'd255

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
            {rom[0], rom[1]}    <= {`MOV_IMM, `R2, 8'd0}; // cant. de primos encontrados
            {rom[2], rom[3]}    <= {`MOV_IMM, `R0, 8'd0}; // inicio de ram
            //primes:
            {rom[4], rom[5]}    <= {`CMP_IMM, `R0, `ram_page}; 
            {rom[6], rom[7]}    <= {`BEQ, `output};
            rom[8]              <= {`LDR_IND, `R1, `R0};
            //branching:
            {rom[9], rom[10]}   <= {`CMP_IMM, `R1, 8'd179}; 
            {rom[11], rom[12]}  <= {`BHI, `cuarto_4};
            {rom[13], rom[14]}  <= {`CMP_IMM, `R1, 8'd103}; 
            {rom[15], rom[16]}  <= {`BHI, `cuarto_3};
            {rom[17], rom[18]}  <= {`CMP_IMM, `R1, 8'd43}; 
            {rom[19], rom[20]}  <= {`BHI, `cuarto_2};
            // cuarto_1
            {rom[21], rom[22]}   <= {`CMP_IMM, `R1, 8'd2}; 
            {rom[23], rom[24]}   <= {`BEQ, `found};
            {rom[25], rom[26]}   <= {`CMP_IMM, `R1, 8'd3}; 
            {rom[27], rom[28]}   <= {`BEQ, `found};
            {rom[29], rom[30]}   <= {`CMP_IMM, `R1, 8'd5}; 
            {rom[31], rom[32]}   <= {`BEQ, `found};
            {rom[33], rom[34]}   <= {`CMP_IMM, `R1, 8'd7}; 
            {rom[35], rom[36]}   <= {`BEQ, `found};
            {rom[37], rom[38]}   <= {`CMP_IMM, `R1, 8'd11}; 
            {rom[39], rom[40]}   <= {`BEQ, `found};
            {rom[41], rom[42]}   <= {`CMP_IMM, `R1, 8'd13}; 
            {rom[43], rom[44]}   <= {`BEQ, `found};
            {rom[45], rom[46]}   <= {`CMP_IMM, `R1, 8'd17}; 
            {rom[47], rom[48]}   <= {`BEQ, `found};
            {rom[49], rom[50]}   <= {`CMP_IMM, `R1, 8'd19}; 
            {rom[51], rom[52]}   <= {`BEQ, `found};
            {rom[53], rom[54]}   <= {`CMP_IMM, `R1, 8'd23}; 
            {rom[55], rom[56]}   <= {`BEQ, `found};
            {rom[57], rom[58]}   <= {`CMP_IMM, `R1, 8'd29}; 
            {rom[59], rom[60]}   <= {`BEQ, `found};
            {rom[61], rom[62]}   <= {`CMP_IMM, `R1, 8'd31}; 
            {rom[63], rom[64]}   <= {`BEQ, `found};
            {rom[65], rom[66]}   <= {`CMP_IMM, `R1, 8'd37}; 
            {rom[67], rom[68]}   <= {`BEQ, `found};
            {rom[69], rom[70]}   <= {`CMP_IMM, `R1, 8'd41}; 
            {rom[71], rom[72]}   <= {`BEQ, `found};
            {rom[73], rom[74]}   <= {`CMP_IMM, `R1, 8'd43}; 
            {rom[75], rom[76]}   <= {`BEQ, `found};
            {rom[77], rom[78]}   <= {`BRA, `next};
            // cuarto_2
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd47}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd53}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd59}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd61}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd67}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd71}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd73}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd79}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd83}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd89}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd97}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd101}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd103}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`BRA, `next};
            // cuarto_3
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd107}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd109}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd113}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd127}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd131}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd137}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd139}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd149}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd151}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd157}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd163}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd167}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd173}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd179}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`BRA, `next};
            // cuarto_4
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd181}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd191}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd193}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd197}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd199}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd211}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd223}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd229}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd233}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd239}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd241}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`CMP_IMM, `R1, 8'd251}; 
            {rom[], rom[]}   <= {`BEQ, `found};
            {rom[], rom[]}   <= {`BRA, `next};
            //found:
            {rom[], rom[]}  <= {`ADD, `R2, 8'd1};
            //next:
            {rom[], rom[]}  <= {`ADD, `R0, 8'd1};
            {rom[], rom[]}  <= {`BRA, `primes};
            //output:
            rom[]             <= {`OUTPUT, `R2};
            // done:
            {rom[], rom[]}  <= {`BRA, `done}; 
            rom[]             <= `NOP;

        end
endmodule
