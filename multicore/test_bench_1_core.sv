`timescale 1ns / 1ps

module multicore_jimmy_tb();
    reg  clk;
    reg  reset;
    wire [7:0] code_data_bus_0;
    wire [7:0] code_addr_bus_0;

    wire [7:0] mem_data_bus_0;
    wire [7:0] mem_addr_bus_0;

    wire [3:0] done_signal_0;
    wire [7:0] result_0;
    wire core_0_done = done_signal_0[2];

    program_memory rom(
        .clk(clk),
        .reset(reset),
        .data_bus_0(code_data_bus_0),
        .addr_bus_0(code_addr_bus_0)
    );
    data_memory mem(
        .clk(clk),
        .reset(reset),
        .data_bus_0(mem_data_bus_0),
        .addr_bus_0(mem_addr_bus_0)
    );
    jimmy core_0(
        .clk(clk),
        .reset(reset),
        .code_data_bus(code_data_bus_0),
        .code_addr_bus(code_addr_bus_0),
        .mem_data_bus(mem_data_bus_0),
        .mem_addr_bus(mem_addr_bus_0),
        .in_port_0(8'd0),
        .in_port_3(8'd255),
        .out_port_2(result_0),
        .out_strobe(done_signal_0)
    );
    
    always #1 clk = !clk;

    always @ (negedge core_0_done) begin
        $display("Core 0: %d", result_0);
    end
    
    initial begin
        $dumpfile("test.vcd"); 
        $dumpvars(0, multicore_jimmy_tb); 
        // init signals
        clk <= 0;
        reset <= 0;
        #50;
        reset <= 1;
        #19000
        $finish;
    end
endmodule