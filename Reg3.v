module Reg3(clk, rst, d, q);
    input clk, rst;
    input [2:0] d;
    output [2:0] q;
    
    D_FF ins [2:0](.clk(clk), .rst(rst), .d(d), .q(q));

endmodule