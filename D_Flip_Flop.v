module D_FF(clk, rst, d, q);
    input clk;
    input rst;
    input d;
    output reg q;
    
    always @(posedge clk or negedge rst) begin
        if(!rst)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule