module Reg2(clk, rst, d, q);
    input clk, rst;
    input [1:0] d;
    output [1:0] q;
    
    D_FF ins [1:0](.clk(clk), .rst(rst), .d(d), .q(q));

endmodule