module CLA3(sum, cout, cin, a, b);
    input [2:0] a, b;
    input cin;
    output cout;
    output [2:0] sum;
    
    wire [2:0] p, g, carry;
    
    assign p = a ^ b;
    assign g = a & b;
    assign carry[0] = cin;
    assign carry[1] = g[0] | (p[0] & cin);
    assign carry[2] = g[1] | (g[0] & p[1]) | (p[1] & p[0] & cin);
    
    assign cout = g[2] | (g[1] & p[2]) | (g[0] & p[2] & p[1]) | (p[2] & p[1] & p[0] & cin);
    assign sum = p ^ carry;

endmodule