`timescale 1ns / 1ps
`define CORES 4
`define MEM_PAGE_SIZE 256/`CORES
`define CORES_DONE_MATCH 8'b00001111
module multicore_jimmy_tb();
    reg  clk;
    reg  reset;

    wire [7:0] code_data_bus [7:0];
    wire [7:0] code_addr_bus [7:0];

    wire [7:0] mem_data_bus [7:0];
    wire [7:0] mem_addr_bus [7:0];

    wire [3:0] out_strobe [7:0];
    wire [7:0] result [7:0];
    
    wire [7:0] output_ready;

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

    always #1 clk = !clk;
    reg [15:0] clk_cycles = 16'h0;
    reg [7:0] core_done_flag = 8'h00;
    reg [7:0] total_primes_found = 8'd0;

    genvar core_id;
    generate
        for(core_id=8'd0; core_id < `CORES; core_id=core_id+8'd1) begin

            assign output_ready[core_id] = out_strobe[core_id][2];
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
            always @ (negedge output_ready[core_id]) begin
                core_done_flag[core_id] = 1'b1;
                $display("Core %d: %d", core_id, result[core_id]);
            end
        end
    endgenerate
    
    

    always @ (posedge clk) begin
        if(core_done_flag != `CORES_DONE_MATCH) begin
            clk_cycles = clk_cycles + 1'b1;
        end
        else begin
            integer core_id;
            for(core_id=0; core_id < `CORES; core_id=core_id+1) begin
                total_primes_found = total_primes_found + result[core_id]
            end
            $display("Total Cycles: %d", clk_cycles);
            $display("Total Primes: %d", total_primes_found);
            $finish; // finish when program is done on all cores
        end
    end
    
    initial begin
        $dumpfile("test.vcd"); 
        $dumpvars(0, multicore_jimmy_tb); 
        // init signals
        clk <= 0;
        reset <= 0;
        #50;
        reset <= 1;
        #50000
        $finish; // finish after 50000 delay units
    end
endmodule