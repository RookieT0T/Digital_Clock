module Mode(clk, rst, curr, change);
    input clk, rst, change;
    output curr;
    
    wire d;
    assign d = change ? ~curr : curr;
    D_FF ins (.clk(clk), .rst(rst), .d(d), .q(curr));
            
endmodule