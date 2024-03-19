module Logic59(add, second, modify, cout, display0, display1, clk, rst);
    input clk, rst;
    input add, second;
    input modify;
    output cout;
    output reg [7:0] display0, display1;
         
    wire [3:0] sum4, d4, q4;
    wire cin4, cout4;
     
    wire [2:0] sum3, d3, q3; 
    wire cout3;
     
    // 0-9
    assign cin4 = (modify & add) | (second & ~modify);
    assign cout4 = (sum4 == 4'ha) ? 1'b1 : 1'b0;
    assign d4 = cout4 ? 4'h0 : sum4;
    CLA4 icla4(.sum(sum4), .cout(), .cin(cin4), .a(q4), .b(4'h0));
    Reg4 ireg4(.clk(clk), .rst(rst), .d(d4), .q(q4));
    
    // 0-5
    assign cout3 = (sum3 == 3'b110) ? 1'b1 : 1'b0;
    assign d3 = cout3 ? 3'b000 : sum3;
    CLA3 icla3(.sum(sum3), .cout(), .cin(cout4), .a(q3), .b(3'b000));
    Reg3 ireg3(.clk(clk), .rst(rst), .d(d3), .q(q3));
    
    // q4 -> display
    always@(q4) begin
        case(q4)
            4'h0: display0 = 8'h03;
            4'h1: display0 = 8'h9f;
            4'h2: display0 = 8'h25;
            4'h3: display0 = 8'h0d;
            4'h4: display0 = 8'h99;
            4'h5: display0 = 8'h49;
            4'h6: display0 = 8'h41;
            4'h7: display0 = 8'h1f;
            4'h8: display0 = 8'h01;
            4'h9: display0 = 8'h09;
            default: display0 = 8'hff;
        endcase
     end
     
     // q3 -> display
     always@(q3) begin
        case(q3)
            3'b000: display1 = 8'h03;
            3'b001: display1 = 8'h9f;
            3'b010: display1 = 8'h25;
            3'b011: display1 = 8'h0d;
            3'b100: display1 = 8'h99;
            3'b101: display1 = 8'h49;
            default: display1 = 8'hff;
        endcase
     end
     
    // cout
    assign cout = cout3 & ~modify;
   
endmodule