`timescale 1ns / 1ns

module F1Hz_tb();

    reg clk;        
    reg reset;
    wire out;

    F1Hz dut(.clk(clk), .rst(reset), .out(out));

    always begin
        #10
        clk = ~clk;
    end

    initial begin
        clk = 1'b0;
        #20
        reset = 1'b0;
        #20
        reset = 1'b1;
        
     end
endmodule
