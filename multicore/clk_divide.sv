module clk_divide(
    input reset,
    input clk_in,
    input [31:0] divisor,
    output reg clk_out
);
    reg [31:0] prescaler;
    always @(posedge clk_in) begin
        if(reset == 1) begin
            if(prescaler == 0) begin
                clk_out = !clk_out;
                prescaler = divisor / 2;
            end
            prescaler = prescaler - 32'd1;
        end
        else begin
            prescaler = divisor / 2;
        end
    end
endmodule