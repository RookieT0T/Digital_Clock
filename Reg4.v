module Reg4(clk, rst, d, q);
    input clk, rst;
    input [3:0] d;
    output [3:0] q;
    
    D_FF ins [3:0](.clk(clk), .rst(rst), .d(d), .q(q));

endmodule