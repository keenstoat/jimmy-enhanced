
`define CORES 4
`define MEM_PAGE_SIZE 256/`CORES
`define CORES_IMPLEMENTED 8'b00001111

module multicore(
    input CLOCK_50,
    input [17:17] SW,
    output reg [17:10] LEDR,
    output reg [6:0] HEX6, 
    output reg [6:0] HEX5, 
    output reg [6:0] HEX4, 
    output reg [6:0] HEX3, 
    output reg [6:0] HEX2, 
    output reg [6:0] HEX1, 
    output reg [6:0] HEX0 
);
    wire clk = CLOCK_50;
    reg  reset;
    
    wire [7:0] code_data_bus [7:0];
    wire [7:0] code_addr_bus [7:0];

    wire [7:0] mem_data_bus [7:0];
    wire [7:0] mem_addr_bus [7:0];

    wire [3:0] out_strobe [7:0];
    wire [7:0] result [7:0];
    
    reg [15:0] clk_cycles = 16'h0;
    reg [7:0]  total_primes_found = 8'd0; // expected val = 54
    reg [7:0]  output_ready = 8'h00;

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
        .addr_bus_7(code_addr_bus[7])
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
        .addr_bus_7(mem_addr_bus[7])
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
            always @ (negedge out_strobe[core_id][2]) begin
                output_ready[core_id] <= 1'b1;
                $display("Core %d: %d", core_id, result[core_id]);
            end
        end
    endgenerate

    bin_to_7_segment hex0(.nibble(clk_cycles[3:0]), .segment(HEX0));
    bin_to_7_segment hex1(.nibble(clk_cycles[7:4]), .segment(HEX1));
    bin_to_7_segment hex2(.nibble(clk_cycles[11:8]), .segment(HEX2));
    bin_to_7_segment hex3(.nibble(clk_cycles[15:12]), .segment(HEX3));

    bin_to_7_segment hex5(.nibble(total_primes_found[3:0]), .segment(HEX5));
    bin_to_7_segment hex6(.nibble(total_primes_found[7:4]), .segment(HEX6));

    integer core_num;
    always @(*) begin
        reset <= SW;
        LEDR <= output_ready;

        for(core_num=0; core_num < `CORES; core_num++) begin
                total_primes_found += result[core_num];
        end
    end

    always @ (posedge clk) begin
        if(output_ready != `CORES_IMPLEMENTED) begin
            clk_cycles += 1'b1;
        end
    end
    
endmodule