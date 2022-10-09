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
`define cuarto_1    8'd21
`define cuarto_2    8'd79
`define cuarto_3    8'd133
`define cuarto_4    8'd191
`define found       8'd241
`define next        8'd243
`define output      8'd247
`define done        8'd248

`define max_ram_addr    8'd255

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
            {rom[4], rom[5]}    <= {`CMP_IMM, `R0, `max_ram_addr}; 
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
            {rom[79], rom[80]}   <= {`CMP_IMM, `R1, 8'd47}; 
            {rom[81], rom[82]}   <= {`BEQ, `found};
            {rom[83], rom[84]}   <= {`CMP_IMM, `R1, 8'd53}; 
            {rom[85], rom[86]}   <= {`BEQ, `found};
            {rom[87], rom[88]}   <= {`CMP_IMM, `R1, 8'd59}; 
            {rom[89], rom[90]}   <= {`BEQ, `found};
            {rom[91], rom[92]}   <= {`CMP_IMM, `R1, 8'd61}; 
            {rom[93], rom[94]}   <= {`BEQ, `found};
            {rom[95], rom[96]}   <= {`CMP_IMM, `R1, 8'd67}; 
            {rom[97], rom[98]}   <= {`BEQ, `found};
            {rom[99], rom[100]}   <= {`CMP_IMM, `R1, 8'd71}; 
            {rom[101], rom[102]}   <= {`BEQ, `found};
            {rom[103], rom[104]}   <= {`CMP_IMM, `R1, 8'd73}; 
            {rom[105], rom[106]}   <= {`BEQ, `found};
            {rom[107], rom[108]}   <= {`CMP_IMM, `R1, 8'd79}; 
            {rom[109], rom[110]}   <= {`BEQ, `found};
            {rom[111], rom[112]}   <= {`CMP_IMM, `R1, 8'd83}; 
            {rom[113], rom[114]}   <= {`BEQ, `found};
            {rom[115], rom[116]}   <= {`CMP_IMM, `R1, 8'd89}; 
            {rom[117], rom[118]}   <= {`BEQ, `found};
            {rom[119], rom[120]}   <= {`CMP_IMM, `R1, 8'd97}; 
            {rom[121], rom[122]}   <= {`BEQ, `found};
            {rom[123], rom[124]}   <= {`CMP_IMM, `R1, 8'd101}; 
            {rom[125], rom[126]}   <= {`BEQ, `found};
            {rom[127], rom[128]}   <= {`CMP_IMM, `R1, 8'd103}; 
            {rom[129], rom[130]}   <= {`BEQ, `found};
            {rom[131], rom[132]}   <= {`BRA, `next};
            // cuarto_3
            {rom[133], rom[134]}   <= {`CMP_IMM, `R1, 8'd107}; 
            {rom[135], rom[136]}   <= {`BEQ, `found};
            {rom[137], rom[138]}   <= {`CMP_IMM, `R1, 8'd109}; 
            {rom[139], rom[140]}   <= {`BEQ, `found};
            {rom[141], rom[142]}   <= {`CMP_IMM, `R1, 8'd113}; 
            {rom[143], rom[144]}   <= {`BEQ, `found};
            {rom[145], rom[146]}   <= {`CMP_IMM, `R1, 8'd127}; 
            {rom[147], rom[148]}   <= {`BEQ, `found};
            {rom[149], rom[150]}   <= {`CMP_IMM, `R1, 8'd131}; 
            {rom[151], rom[152]}   <= {`BEQ, `found};
            {rom[153], rom[154]}   <= {`CMP_IMM, `R1, 8'd137}; 
            {rom[155], rom[156]}   <= {`BEQ, `found};
            {rom[157], rom[158]}   <= {`CMP_IMM, `R1, 8'd139}; 
            {rom[159], rom[160]}   <= {`BEQ, `found};
            {rom[161], rom[162]}   <= {`CMP_IMM, `R1, 8'd149}; 
            {rom[163], rom[164]}   <= {`BEQ, `found};
            {rom[165], rom[166]}   <= {`CMP_IMM, `R1, 8'd151}; 
            {rom[167], rom[168]}   <= {`BEQ, `found};
            {rom[169], rom[170]}   <= {`CMP_IMM, `R1, 8'd157}; 
            {rom[171], rom[172]}   <= {`BEQ, `found};
            {rom[173], rom[174]}   <= {`CMP_IMM, `R1, 8'd163}; 
            {rom[175], rom[176]}   <= {`BEQ, `found};
            {rom[177], rom[178]}   <= {`CMP_IMM, `R1, 8'd167}; 
            {rom[179], rom[180]}   <= {`BEQ, `found};
            {rom[181], rom[182]}   <= {`CMP_IMM, `R1, 8'd173}; 
            {rom[183], rom[184]}   <= {`BEQ, `found};
            {rom[185], rom[186]}   <= {`CMP_IMM, `R1, 8'd179}; 
            {rom[187], rom[188]}   <= {`BEQ, `found};
            {rom[189], rom[190]}   <= {`BRA, `next};
            // cuarto_4
            {rom[191], rom[192]}   <= {`CMP_IMM, `R1, 8'd181}; 
            {rom[193], rom[194]}   <= {`BEQ, `found};
            {rom[195], rom[196]}   <= {`CMP_IMM, `R1, 8'd191}; 
            {rom[197], rom[198]}   <= {`BEQ, `found};
            {rom[199], rom[200]}   <= {`CMP_IMM, `R1, 8'd193}; 
            {rom[201], rom[202]}   <= {`BEQ, `found};
            {rom[203], rom[204]}   <= {`CMP_IMM, `R1, 8'd197}; 
            {rom[205], rom[206]}   <= {`BEQ, `found};
            {rom[207], rom[208]}   <= {`CMP_IMM, `R1, 8'd199}; 
            {rom[209], rom[210]}   <= {`BEQ, `found};
            {rom[211], rom[212]}   <= {`CMP_IMM, `R1, 8'd211}; 
            {rom[213], rom[214]}   <= {`BEQ, `found};
            {rom[215], rom[216]}   <= {`CMP_IMM, `R1, 8'd223}; 
            {rom[217], rom[218]}   <= {`BEQ, `found};
            {rom[219], rom[220]}   <= {`CMP_IMM, `R1, 8'd229}; 
            {rom[221], rom[222]}   <= {`BEQ, `found};
            {rom[223], rom[224]}   <= {`CMP_IMM, `R1, 8'd233}; 
            {rom[225], rom[226]}   <= {`BEQ, `found};
            {rom[227], rom[228]}   <= {`CMP_IMM, `R1, 8'd239}; 
            {rom[229], rom[230]}   <= {`BEQ, `found};
            {rom[231], rom[232]}   <= {`CMP_IMM, `R1, 8'd241}; 
            {rom[233], rom[234]}   <= {`BEQ, `found};
            {rom[235], rom[236]}   <= {`CMP_IMM, `R1, 8'd251}; 
            {rom[237], rom[238]}   <= {`BEQ, `found};
            {rom[239], rom[240]}   <= {`BRA, `next};
            //found:
            {rom[241], rom[242]}  <= {`ADD, `R2, 8'd1};
            //next:
            {rom[243], rom[244]}  <= {`ADD, `R0, 8'd1};
            {rom[245], rom[246]}  <= {`BRA, `primes};
            //output:
            rom[247]             <= {`OUTPUT, `R2};
            // done:
            {rom[248], rom[249]}  <= {`BRA, `done}; 
            rom[250]              <= `NOP;
        end
endmodule
