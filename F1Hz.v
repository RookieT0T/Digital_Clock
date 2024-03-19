module F1Hz(clk, rst, out);
    input clk, rst;
    output reg out;
    
    // 50MHz clock on FPGA -> 1Hz clock
    parameter target = 26'd5000_0000;
    reg [25:0] counter;
    
    always@(posedge clk) begin
        if(!rst) begin
            counter <= 26'd0;
            out <= 1'b0;
        end 
        else begin
            if(counter == target) begin
                out <= 1'b1;
                counter <= 26'd0;
            end
            else begin
                out <= 1'b0;
                counter <= counter + 26'd1;
            end
        end
     end
            
endmodule