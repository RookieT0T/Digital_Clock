module Chip(clk, rst, sel, seg, ds, shcp, stcp, oe);
    input clk, rst;
    input [5:0] sel;
    input [7:0] seg;
    output reg shcp, stcp;
    output ds, oe;
    
    wire [13:0] data;
    reg [1:0] cnt;
    reg [3:0] cnt_bit;
    
    // combine select and segment signals together
    assign data = {seg, sel};
    
    // counter 0 ~ 3
    always@(posedge clk) begin
        if(!rst) begin
            cnt <= 2'b00;
        end else if(cnt == 2'b11) begin
            cnt <= 2'b00;
        end else begin
            cnt <= cnt + 2'd1;
        end
    end
    
    // bit selector implemented based on the counter
    always@(posedge clk) begin
        if(!rst) begin
            cnt_bit <= 4'h0;
        end else if(cnt_bit == 4'hd && cnt == 2'b11) begin
            cnt_bit <= 4'h0;
        end else if(cnt == 2'b11) begin    
            cnt_bit <= cnt_bit + 4'd1;
        end else begin
            cnt_bit <= cnt_bit;
        end
    end
    
    // ds
    assign ds = data[cnt_bit];
    
    // shcp
    always@(posedge clk) begin
        if(!rst) begin
            shcp <= 1'b0;
        end else if(cnt == 2'b10) begin
            shcp <= 1'b1;
        end else if(cnt == 2'b00) begin
            shcp <= 1'b0;
        end else begin
            shcp <= shcp;
        end
     end
     
     // stcp
     always@(posedge clk) begin
        if(!rst) begin
            stcp <= 1'b0;
        end else if(cnt == 2'b00 && cnt_bit == 4'h0) begin
            stcp <= 1'b1;
        end else if(cnt == 2'b10 && cnt_bit == 4'h0) begin
            stcp <= 1'b0;
        end else begin
            stcp <= stcp;
        end
     end
        
     // oe
     assign oe = 1'b0;
            
endmodule