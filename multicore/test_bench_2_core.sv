`timescale 1ns / 1ps

module multicore_jimmy_tb();
    reg  clk;
    reg  reset;
    // Core 0
    wire [7:0] code_data_bus_0;
    wire [7:0] code_addr_bus_0;

    wire [7:0] mem_data_bus_0;
    wire [7:0] mem_addr_bus_0;

    wire [3:0] done_signal_0;
    wire [7:0] result_0;
    wire core_0_done = done_signal_0[2];

    // Core 1
    wire [7:0] code_data_bus_1;
    wire [7:0] code_addr_bus_1;

    wire [7:0] mem_data_bus_1;
    wire [7:0] mem_addr_bus_1;

    wire [3:0] done_signal_1;
    wire [7:0] result_1;
    wire core_1_done = done_signal_1[2];

    program_memory rom(
        .clk(clk),
        .reset(reset),
        .data_bus_0(code_data_bus_0),
        .addr_bus_0(code_addr_bus_0),
        .data_bus_1(code_data_bus_1),
        .addr_bus_1(code_addr_bus_1)
    );
    data_memory mem(
        .clk(clk),
        .reset(reset),
        .data_bus_0(mem_data_bus_0),
        .addr_bus_0(mem_addr_bus_0),
        .data_bus_1(mem_data_bus_1),
        .addr_bus_1(mem_addr_bus_1)
    );
    jimmy core_0(
        .clk(clk),
        .reset(reset),
        .code_data_bus(code_data_bus_0),
        .code_addr_bus(code_addr_bus_0),
        .mem_data_bus(mem_data_bus_0),
        .mem_addr_bus(mem_addr_bus_0),
        .in_port_0(8'd0),
        .in_port_3(8'd127),
        .out_port_2(result_0),
        .out_strobe(done_signal_0)
    );
    jimmy core_1(
        .clk(clk),
        .reset(reset),
        .code_data_bus(code_data_bus_1),
        .code_addr_bus(code_addr_bus_1),
        .mem_data_bus(mem_data_bus_1),
        .mem_addr_bus(mem_addr_bus_1),
        .in_port_0(8'd128),
        .in_port_3(8'd255),
        .out_port_2(result_1),
        .out_strobe(done_signal_1)
    );
    
    always #1 clk = !clk;
    reg [31:0] ciclos = 32'h0;
    reg [7:0] core_done_flag = 8'h00;

    always @ (negedge core_0_done) begin
        core_done_flag[0] = 1'b1;
        $display("Core 0: %d", result_0);
    end
     always @ (negedge core_1_done) begin
        core_done_flag[1] = 1'b1;
        $display("Core 1: %d", result_1);
    end

    always @ (posedge clk) begin
        if(core_done_flag != 8'b00000011) begin
            ciclos = ciclos + 1'b1;
        end
        else begin
            $display("Total Cycles: %d", ciclos);
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