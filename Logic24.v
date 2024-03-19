module Logic24(add, minute, modify, display0, display1, clk, rst);
    input add, minute, modify;
    input clk, rst;
    output reg [7:0] display0, display1;
    
    wire [3:0] sum4, d4, q4;
    wire cout4, cin4, condit;
    
    wire [1:0] sum2, d2, q2;
    
    // 0-9
    assign cin4 = (modify & add) | (minute & ~modify);
    assign condit = (q2 != 2'b10 & sum4 == 4'ha) | (q2 == 2'b10 & sum4 == 4'h5);
    assign cout4 = condit ? 1'b1 : 1'b0;  
    assign d4 = cout4 ? 4'h0 : sum4;
    CLA4 icla4(.sum(sum4), .cout(), .cin(cin4), .a(q4), .b(4'h0));
    Reg4 ireg4(.clk(clk), .rst(rst), .d(d4), .q(q4));
    
    // 0-2
    assign d2 = (sum2 == 2'b11) ? 2'b00 : sum2;
    RCA2 irca2(.sum(sum2), .cout(), .cin(cout4), .a(q2), .b(2'b00));
    Reg2 ireg2(.clk(clk), .rst(rst), .d(d2), .q(q2));
    
    // q4 -> display
    always@(q4) begin
        case(q4)
            4'h0: display0 = 8'h02;
            4'h1: display0 = 8'h9e;
            4'h2: display0 = 8'h24;
            4'h3: display0 = 8'h0c;
            4'h4: display0 = 8'h98;
            4'h5: display0 = 8'h48;
            4'h6: display0 = 8'h40;
            4'h7: display0 = 8'h1e;
            4'h8: display0 = 8'h00;
            4'h9: display0 = 8'h08;
            default: display0 = 8'hff;
        endcase
     end
     
     // q2 -> display
     always@(q2) begin
        case(q2)
            2'b00: display1 = 8'h03;
            2'b01: display1 = 8'h9f;
            2'b10: display1 = 8'h25;
            default: display1 = 8'hff;
        endcase
     end

endmodule