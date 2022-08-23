`timescale 1ns / 1ps

module jimmy_promedio_tb();
    reg  clk;
    reg  reset;
    wire [7:0] prog_data_bus;
    wire [7:0] prog_addr_bus;
    wire [3:0] out_strobe;
    wire [3:0] in_strobe;
    wire in_strobe_0 = in_strobe[0];
    wire out_strobe_2 = out_strobe[2];

    wire [7:0] result;
    reg  [7:0] numeros [9:0];
    reg  [7:0] index = 0;
    wire [7:0] valor = numeros[index]; 

    jimmy cpu(
        .clk(clk),
        .reset(reset),
        .in_port_0(valor),
        .out_port_2(result),
        .in_strobe(in_strobe),
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

    always @ (negedge(in_strobe_0)) begin
        $display("feed: %d", valor);
        index = index + 1;
    end

    always @ (negedge(out_strobe_2)) begin
        $display("promedio: %d", result);
    end
    
    initial begin
        $dumpfile("test.vcd"); 
        $dumpvars(0, jimmy_promedio_tb); 

        // init para input
        numeros[ 0] <= 8'd5;
        numeros[ 1] <= 8'd3;
        numeros[ 2] <= 8'd4;
        numeros[ 3] <= 8'd5;
        numeros[ 4] <= 8'd7;
        numeros[ 5] <= 8'd2;
        numeros[ 6] <= 8'd9;
        numeros[ 7] <= 8'd6;
        numeros[ 8] <= 8'd7;
        numeros[ 9] <= 8'd4;
        numeros[10] <= 8'd0;
        numeros[11] <= 8'd0;
        // init signals
        clk <= 0;
        reset <= 0;
        index <= 0;
        
        #50;
        reset <= 1;
        #3500
        
        $finish;
    end
endmodule