module RCA2(sum, cout, cin, a, b);
    input cin;
    input [1:0] a, b;
    output cout;
    output [1:0] sum;
    
    wire [1:0] carry;
    RCA1 iRCA[1:0](.sum(sum), .cout(carry), .cin({carry[0], cin}), .a(a), .b(b));
    assign cout = carry[1];

endmodule

module RCA1(sum, cout, cin, a, b);
    input cin, a, b;
    output cout, sum;
    
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | ((a ^ b) & cin);
    
endmodule