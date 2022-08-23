`timescale 1ns / 1ps

module jimmy_promedio_tb();
    reg  clk;
    reg  reset;
    wire [7:0] prog_data_bus;
    wire [7:0] prog_addr_bus;
    wire [3:0] out_strobe;
    wire [7:0] result;
    reg  [7:0] a;
    reg  [7:0] b;
    
    jimmy cpu(
        .clk(clk),
        .reset(reset),
        .in_port_0(a),
        .in_port_1(b),
        .out_port_2(result),
        .out_strobe(out_strobe),
        .inst_data_bus(prog_data_bus),
        .inst_address_bus(prog_addr_bus)
    );
    
    program_memory rom(
        .clk(clk),
        .reset(reset),
        .data_bus(prog_data_bus),
        .address_bus(prog_addr_bus)
    );

    always #5 clk = !clk;

    always @ (negedge(out_strobe[2])) begin
      $display("%d * %d = %d", a, b, result);
    end
    
    initial begin
        $dumpfile("test.vcd"); 
        $dumpvars(0, jimmy_suma_sucesiva_tb); 
        clk <= 0;
        reset <= 0;
        a <= 3;
        b <= 11;
        #50;
        reset <= 1;
        #2200
        
        $finish;
    end
  
endmodule