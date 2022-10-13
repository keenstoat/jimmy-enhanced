
`define CORES 16
`define MEM_PAGE_SIZE 256/`CORES
`define CORE_FINISH_MASK 16'b1111_1111_1111_1111

module multicore(
    input CLOCK_50,
    input [17:17] SW,
    output [17:2] LEDR,
    output [6:0] HEX5, 
    output [6:0] HEX4, 
    output [6:0] HEX3, 
    output [6:0] HEX2, 
    output [6:0] HEX1, 
    output [6:0] HEX0 
);
    wire clk;
    wire reset = SW;
    
    wire [7:0] code_data_bus [15:0];
    wire [7:0] code_addr_bus [15:0];

    wire [7:0] mem_data_bus [15:0];
    wire [7:0] mem_addr_bus [15:0];

    wire [3:0] out_strobe [15:0];
    wire [7:0] result [15:0];
    
    reg [15:0] clk_cycles = 16'h0; // 4cores = 0x15F0
    reg [7:0]  total_primes_found = 8'd0; // expected val = 54 = 0x36
    reg [15:0]  output_ready = 8'h00;
    assign LEDR = output_ready;

    clk_divide clk_divide(.reset(reset), .clk_in(CLOCK_50), .divisor(32'd100_000), .clk_out(clk));

    program_memory rom(
        .clk(clk),
        .reset(reset),
        .data_bus_0(code_data_bus[0]),
        .addr_bus_0(code_addr_bus[0]),
        .data_bus_1(code_data_bus[1]),
        .addr_bus_1(code_addr_bus[1]),
        .data_bus_2(code_data_bus[2]),
        .addr_bus_2(code_addr_bus[2]),
        .data_bus_3(code_data_bus[3]),
        .addr_bus_3(code_addr_bus[3]),
        .data_bus_4(code_data_bus[4]),
        .addr_bus_4(code_addr_bus[4]),
        .data_bus_5(code_data_bus[5]),
        .addr_bus_5(code_addr_bus[5]),
        .data_bus_6(code_data_bus[6]),
        .addr_bus_6(code_addr_bus[6]),
        .data_bus_7(code_data_bus[7]),
        .addr_bus_7(code_addr_bus[7]),

        .data_bus_8(code_data_bus[8]),
        .addr_bus_8(code_addr_bus[8]),
        .data_bus_9(code_data_bus[9]),
        .addr_bus_9(code_addr_bus[9]),
        .data_bus_10(code_data_bus[10]),
        .addr_bus_10(code_addr_bus[10]),
        .data_bus_11(code_data_bus[11]),
        .addr_bus_11(code_addr_bus[11]),
        .data_bus_12(code_data_bus[12]),
        .addr_bus_12(code_addr_bus[12]),
        .data_bus_13(code_data_bus[13]),
        .addr_bus_13(code_addr_bus[13]),
        .data_bus_14(code_data_bus[14]),
        .addr_bus_14(code_addr_bus[14]),
        .data_bus_15(code_data_bus[15]),
        .addr_bus_15(code_addr_bus[15])
    );
    data_memory mem(
        .clk(clk),
        .reset(reset),
        .data_bus_0(mem_data_bus[0]),
        .addr_bus_0(mem_addr_bus[0]),
        .data_bus_1(mem_data_bus[1]),
        .addr_bus_1(mem_addr_bus[1]),
        .data_bus_2(mem_data_bus[2]),
        .addr_bus_2(mem_addr_bus[2]),
        .data_bus_3(mem_data_bus[3]),
        .addr_bus_3(mem_addr_bus[3]),
        .data_bus_4(mem_data_bus[4]),
        .addr_bus_4(mem_addr_bus[4]),
        .data_bus_5(mem_data_bus[5]),
        .addr_bus_5(mem_addr_bus[5]),
        .data_bus_6(mem_data_bus[6]),
        .addr_bus_6(mem_addr_bus[6]),
        .data_bus_7(mem_data_bus[7]),
        .addr_bus_7(mem_addr_bus[7]),

        .data_bus_8(mem_data_bus[8]),
        .addr_bus_8(mem_addr_bus[8]),
        .data_bus_9(mem_data_bus[9]),
        .addr_bus_9(mem_addr_bus[9]),
        .data_bus_10(mem_data_bus[10]),
        .addr_bus_10(mem_addr_bus[10]),
        .data_bus_11(mem_data_bus[11]),
        .addr_bus_11(mem_addr_bus[11]),
        .data_bus_12(mem_data_bus[12]),
        .addr_bus_12(mem_addr_bus[12]),
        .data_bus_13(mem_data_bus[13]),
        .addr_bus_13(mem_addr_bus[13]),
        .data_bus_14(mem_data_bus[14]),
        .addr_bus_14(mem_addr_bus[14]),
        .data_bus_15(mem_data_bus[15]),
        .addr_bus_15(mem_addr_bus[15])
    );

    genvar core_id;
    generate
        for(core_id=8'd0; core_id < `CORES; core_id++) begin : create_cores
            
            jimmy core(
                .clk(clk),
                .reset(reset),
                .code_data_bus(code_data_bus[core_id]),
                .code_addr_bus(code_addr_bus[core_id]),
                .mem_data_bus(mem_data_bus[core_id]),
                .mem_addr_bus(mem_addr_bus[core_id]),
                .in_port_0(core_id*(`MEM_PAGE_SIZE)),
                .in_port_3((core_id + 1)*(`MEM_PAGE_SIZE) - 1),
                .out_port_2(result[core_id]),
                .out_strobe(out_strobe[core_id])
            );
            // always @ (negedge out_strobe[core_id][2]) begin
            //     output_ready[core_id] <= 1'b1;
            // end
            always @ (negedge out_strobe[core_id][2] or negedge reset) begin
                if(reset == 0) begin
                    output_ready[core_id] <= 1'b0;
                end
                else 
                    output_ready[core_id] <= 1'b1;
            end
        end
    endgenerate

    bin_to_7_segment hex0(.nibble(clk_cycles[3:0]), .segment(HEX0));
    bin_to_7_segment hex1(.nibble(clk_cycles[7:4]), .segment(HEX1));
    bin_to_7_segment hex2(.nibble(clk_cycles[11:8]), .segment(HEX2));
    bin_to_7_segment hex3(.nibble(clk_cycles[15:12]), .segment(HEX3));

    bin_to_7_segment hex4(.nibble(total_primes_found[3:0]), .segment(HEX4));
    bin_to_7_segment hex5(.nibble(total_primes_found[7:4]), .segment(HEX5));

    always @ (posedge clk or negedge reset) begin
        if(reset == 0) begin
            clk_cycles = 16'h0;
        end
        else if(output_ready != `CORE_FINISH_MASK) begin
            clk_cycles += 1'b1;
        end
    end

    always @ (result) begin
        total_primes_found = result[0]  + result[1]  + result[2]  + result[3] 
                           + result[4]  + result[5]  + result[6]  + result[7]
                           + result[8]  + result[9]  + result[10] + result[11]
                           + result[12] + result[13] + result[14] + result[15];
    end
endmodule