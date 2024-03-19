module Logic59_tb();
    reg clk, rst, add, second, modify;
    wire cout;
    wire [7:0] display0, display1;
    
    Logic59 i59(.add(add), .second(second), .modify(modify), .cout(cout), .display0(display0), .display1(display1), .clk(clk), .rst(rst));
    
    always begin
        #10
        clk = ~clk;
    end
    
    initial begin
        clk = 1'b0;
        add = 1'b0;
        second = 1'b0;
        modify = 1'b0;
        rst = 1'b0;
        @(posedge clk);
        rst = 1'b1;
        
        // T1
        @(posedge clk);
        second = 1'b1;  // second as cin
        
        // T2
        @(posedge clk);
        modify = 1'b1;  // block second 
        
        // T3
        #60
        @(posedge clk);
        add = 1'b1;     // signal of add buttom as cin
        
        // T4
        @(posedge clk);
        modify = 1'b0;  // no longer block second to see cout
        
        #1200
        $finish();
      end
      
endmodule