module Logic24_tb();
    reg clk, rst, add, minute, modify;
    wire [7:0] display0, display1;
    Logic24 i24(.add(add), .minute(minute), .modify(modify), .display0(display0), .display1(display1), .clk(clk), .rst(rst));

    always begin
        #10
        clk = ~clk;
    end
    
    initial begin
        clk = 1'b0;
        add = 1'b0;
        minute = 1'b0;
        modify = 1'b0;
        rst = 1'b0;
        @(posedge clk);
        rst = 1'b1;
        
        // T1
        @(posedge clk);
        minute = 1'b1;  // miunte as cin
        
        #1200 
        $finish();
    end
    
endmodule