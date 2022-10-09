`timescale 1ns / 1ps

// Opcodes
// Category 00, 01, 11 
`define ADD_REG  6'b000000
`define MUL      6'b000010
`define CMP_REG  6'b000011
`define MOV      6'b000100
`define NOP      6'b000111
`define LDR_IND  6'b000101
`define STR_IND  6'b000110
`define DIV_REG  6'b001100
// Category 10
`define MOV_IMM  6'b100000
`define CMP_IMM  6'b100011
`define INC      6'b100100
`define DEC      6'b100101
`define INPUT    6'b100110
`define OUTPUT   6'b100111
`define BRA      6'b101010
`define BHI      6'b101100
`define BEQ      6'b101101

`define CAT_00    2'b00
`define CAT_01    2'b01
`define CAT_11    2'b11
`define CAT_10    2'b10

// Control Logic States, One-Hot Encoded
`define FETCH      3'b001
`define EXECUTE    3'b010
`define WRITE_BACK 3'b100

module jimmy(
    input clk,
    input reset,

    input  [7:0]  in_port_0,
    input  [7:0]  in_port_1,
    input  [7:0]  in_port_2,
    input  [7:0]  in_port_3,
    output reg [3:0] in_strobe,

    output [7:0] out_port_0,
    output [7:0] out_port_1,
    output [7:0] out_port_2,
    output [7:0] out_port_3,
    output reg [3:0] out_strobe,

    input  [7:0] code_data_bus,
    output [7:0] code_addr_bus,

    inout  [7:0] mem_data_bus,
    output [7:0] mem_addr_bus
    );
    
    // Registers
    reg [7:0] R[3:0];    // Register Bank
    reg [7:0] PC;        // Program Counter to Program Memory
    reg [7:0] SP;        // Stack Pointer to Data Memory
    reg Z;               // Zero Flag
    reg C;               // Carry Bit
    reg N;               // Negative Flag
    reg V;               // Overflow Flag
    // Special Registers
    reg [5:0] OPCODE;
    reg [1:0] Ra;
    reg [1:0] Rb;
    reg A7;
    reg B7;
    reg [7:0] RESULT;
    wire R7 = RESULT[7];

    // Data Memory
    mem_addr_bus = R[Rb];

    // State Machine
    reg [2:0] state;
    
    // I/O mappings
    wire [7:0]  in_port [3:0];
    assign  in_port[0] = in_port_0;
    assign  in_port[1] = in_port_1;
    assign  in_port[2] = in_port_2;
    assign  in_port[3] = in_port_3;

    reg  [7:0] out_port [3:0];
    assign out_port_0 = out_port[0];
    assign out_port_1 = out_port[1];
    assign out_port_2 = out_port[2];
    assign out_port_3 = out_port[3];
    
    wire [7:0] argument = code_data_bus;
   
    assign code_addr_bus = PC;
    wire [15:0] mult = R[Rb] * R[Ra];
    
    // These four signals make the cpu registers available 
    // as signals to the EDA Playground waveform simulator.
    wire [7:0] R0 = R[0];
    wire [7:0] R1 = R[1];
    wire [7:0] R2 = R[2];
    wire [7:0] R3 = R[3];
    
    // Procedural Code
    
    always @(posedge(clk)) begin
        if (reset == 0) begin
            state <= `FETCH;
            PC    <= 8'b0000_0000;
            SP    <= 8'b1111_1111;
            in_strobe  <= 4'b1111; 
            out_strobe <= 4'b1111;
        end
        else begin
            case(state)
                `FETCH: begin
                    in_strobe  <= 4'b1111;
                    out_strobe <= 4'b1111;
                    if (code_data_bus[7:6] != `CAT_10) begin
                        OPCODE <= {2'b00,code_data_bus[7:4]};
                        Ra <= code_data_bus[3:2];
                        Rb <= code_data_bus[1:0];
                    end
                    else begin // Category 10
                        OPCODE <= code_data_bus[7:2];
                        Ra <= code_data_bus[1:0];
                        case(code_data_bus[7:2])
                            `MOV_IMM,
                            `CMP_IMM, 
                            `BRA, 
                            `BHI,
                            `BEQ:  PC <= PC + 8'd1;
                        endcase
                    end
                    state <= `EXECUTE;
                end
                `EXECUTE: begin
                    case(OPCODE)
                        // OPCODE CATEGORY 00, 01, 11 =============================================================
                        `ADD_REG: begin
                            RESULT <= R[Ra] + R[Rb];
                            A7     <= R[Ra][7];
                            B7     <= R[Rb][7];
                            state  <= `WRITE_BACK;
                        end
                        `MUL: begin
                            {R[Rb],R[Ra]} <= (Ra == Rb) ? {mult[7:0],mult[7:0]} : (mult);
                            PC            <= PC + 8'd1;
                            state         <= `FETCH;
                        end
                        `CMP_REG: begin
                            RESULT  <= R[Ra] - R[Rb];
                            A7      <= R[Ra][7];
                            B7      <= R[Rb][7];
                            state   <= `WRITE_BACK;
                        end
                        `DIV_REG: begin
                            RESULT <= R[Ra] / R[Rb];
                            A7     <= R[Ra][7];
                            B7     <= R[Rb][7];
                            state  <= `WRITE_BACK;
                        end
                        `MOV: begin
                            R[Ra]   <= R[Rb];
                            Z       <= (R[Rb] == 8'd0) ? 1'b1 : 1'b0;
                            N       <= R[Rb][7];
                            V       <= 0;
                            PC      <= PC + 8'd1;
                            state   <= `FETCH;
                        end
                        `NOP: begin
                            PC      <= PC + 8'd1;
                            state   <= `FETCH;
                        end
                        `LDR_IND: begin
                            R[Ra]   <= mem_data_bus;
                            Z       <= (mem_data_bus == 8'd0) ? 1'b1 : 1'b0;
                            N       <= mem_data_bus[7];
                            V       <= 0;
                            PC      <= PC + 8'd1;
                            state   <= `FETCH;
                        end
                        `STR_IND: begin
                            mem_data_bus    <= R[Ra];
                            Z               <= (R[Ra] == 8'd0) ? 1'b1 : 1'b0;
                            N               <= R[Ra][7];
                            V               <= 0;
                            PC              <= PC + 8'd1;
                            state           <= `FETCH;
                        end
                        // OPCODE CATEGORY 10 =============================================================
                        `MOV_IMM: begin
                            R[Ra]   <= argument;
                            Z       <= (argument == 8'd0) ? 1'b1 : 1'b0;
                            N       <= argument[7];
                            V       <= 0;
                            PC      <= PC + 8'd1;
                            state   <= `FETCH;
                        end
                        `CMP_IMM: begin
                            RESULT  <= R[Ra] - argument;
                            A7      <= R[Ra][7];
                            B7      <= argument[7];
                            state   <= `WRITE_BACK;
                        end
                        `INC: begin
                            RESULT  <= R[Ra] + 8'd1;
                            A7      <= R[Ra][7];
                            B7      <= 0;
                            state   <= `WRITE_BACK;
                        end
                        `DEC: begin
                            RESULT  <= R[Ra] - 8'd1;
                            A7      <= R[Ra][7];
                            state   <= `WRITE_BACK;
                        end 
                        `INPUT: begin
                            R[Ra] = in_port[Ra];
                            state <= `WRITE_BACK;
                        end
                        `OUTPUT: begin
                            out_port[Ra] = R[Ra];
                            state        <= `WRITE_BACK;
                        end
                        `BRA: begin
                            PC      <= argument;
                            state   <= `FETCH;
                        end                         
                        `BHI: begin          //   11111111 > 00000000
                            if(C == 0 && Z == 0) 
                                PC <= argument;
                            else
                                PC <= PC + 8'd1;
                            state <= `FETCH;
                        end
                        `BEQ: begin
                            if(Z == 1) 
                                PC <= argument;
                            else
                                PC <= PC + 8'd1;
                            state <= `FETCH;
                         end 
                    endcase
                end
                `WRITE_BACK: begin
                    case(OPCODE)
                        `ADD_REG: begin
                            R[Ra] <= RESULT;
                            V     <= (A7 & B7 & ~R7) | (~A7 & ~B7 & R7);
                            N     <= R7;
                            Z     <= (RESULT == 8'd0) ? 1'b1 : 1'b0;
                            C     <= (A7 & B7) | (B7 & ~R7) | (~R7 & A7);
                        end
                        `DIV_REG: begin
                            R[Ra] <= RESULT;
                            // TODO set flags later
                        end
                        `CMP_REG: begin
                            V <= (A7 & ~B7 & ~R7) | (~A7 & B7 & R7);
                            // N <= (R[Ra] < R[Rb])  ? 1'b1 : 1'b0;
                            // Z <= (R[Ra] == R[Rb]) ? 1'b1 : 1'b0;
                            // C <= (R[Ra] >= R[Rb]) ? 1'b1 : 1'b0;
                            N <= R7;
                            Z <= (RESULT == 8'd0) ? 1'b1 : 1'b0;
                            C <= (~A7 & B7) | (B7 & R7) | (R7 & ~A7);
                        end
                        `CMP_IMM: begin
                            V <= (A7 & ~B7 & ~R7) | (~A7 & B7 & R7);
                            N <= R7;
                            Z <= (RESULT == 8'd0) ? 1'b1 : 1'b0;
                            C <= (~A7 & B7) | (B7 & R7) | (R7 & ~A7);
                        end
                        `INC: begin
                            R[Ra] <= RESULT;
                            V     <= (A7 & B7 & ~R7) | (~A7 & ~B7 & R7);
                            N     <= R7;
                            Z     <= (RESULT == 8'd0) ? 1'b1 : 1'b0;
                            C     <= (A7 & B7) | (B7 & ~R7) | (~R7 & A7);
                        end
                        `DEC: begin
                            R[Ra] <= RESULT;
                            V     <= ~R7 & A7;
                            N     <= R7;
                            Z     <= (RESULT == 8'd0) ? 1'b1 : 1'b0;
                        end   
                        `INPUT:  in_strobe[Ra] = 1'b0;
                        `OUTPUT: out_strobe[Ra] = 1'b0;
                    endcase
                    PC <= PC + 8'd1;
                    state <= `FETCH;
                end
                default: begin
                    state      <= `FETCH;
                    PC         <= 8'b0000_0000;
                    SP         <= 8'b1111_1111;
                    in_strobe  <= 4'b1111; 
                    out_strobe <= 4'b1111;
                end
            endcase
        end
    end
endmodule
