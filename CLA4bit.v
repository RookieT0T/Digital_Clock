module CLA4(sum, cout, cin, a, b);
    input [3:0] a, b;
    input cin;
    output cout;
    output [3:0] sum;
    
    wire [3:0] p, g, carry;
    
    assign p = a ^ b;
    assign g = a & b;
    assign carry[0] = cin;
    assign carry[1] = g[0] | (p[0] & cin);
    assign carry[2] = g[1] | (g[0] & p[1]) | (p[1] & p[0] & cin);
    assign carry[3] = g[2] | (g[1] & p[2]) | (g[0] & p[2] & p[1]) | (p[2] & p[1] & p[0] & cin);
    
    assign cout = g[3] | (g[2] & p[3]) | (g[1] & p[3] & p[2]) | (g[0] & p[3] & p[2] & p[1]) | (p[3] & p[2] & p[1] & p[0] & cin);
    assign sum = p ^ carry;
    
endmodule
    