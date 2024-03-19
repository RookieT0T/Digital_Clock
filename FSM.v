module FSM(clk, rst, nextP, ms, mm, mh);
    input clk, rst, nextP;
    output ms, mm, mh;
    
    wire d0, q0, d1, q1;
    
    assign d0 = (~q1 & ~nextP) | (q0 & nextP);
    assign d1 = (q1 & nextP) | (q0 & ~nextP);
    D_FF idff0(.clk(clk), .rst(rst), .d(d0), .q(q0));
    D_FF idff1(.clk(clk), .rst(rst), .d(d1), .q(q1));
    
    assign ms = ~q1 & q0;
    assign mm = q1 & q0;
    assign mh = q1 & ~q0;

endmodule   