module FSM_tb();
    reg clk, rst, nextP;
    wire ms, mm, mh;
   
    FSM iFSM(.clk(clk), .rst(rst), .nextP(nextP), .ms(ms), .mm(mm), .mh(mh));

    always begin
        #10
        clk = ~clk;
    end
    
    initial begin
        clk = 1'b0;
        nextP = 1'b1;
        rst = 1'b0;
        #20
        rst = 1'b1;
        
        // T1
        @(posedge clk);
        nextP = 1'b0;
        @(posedge clk);
        nextP = 1'b1;
        @(posedge clk);
        if(ms != 1'b1) begin
            $display("ms  fails");
        end
        
        // T2
        #20
        @(posedge clk);
        nextP = 1'b0;
        @(posedge clk);
        nextP = 1'b1;
        @(posedge clk);
        if(mm != 1'b1 | ms != 1'b0) begin
            $display("mm  fails");
        end
        
        // T3
        #20
        @(posedge clk);
        nextP = 1'b0;
        @(posedge clk);
        nextP = 1'b1;
        @(posedge clk);
        if(mh != 1'b1 | ms != 1'b0 | mm != 1'b0) begin
            $display("mh  fails");
        end
        
        // T4
        #20
        @(posedge clk);
        nextP = 1'b0;
        @(posedge clk);
        nextP = 1'b1;
        @(posedge clk);
        if(mh != 1'b0 | ms != 1'b0 | mm != 1'b0) begin
            $display("All zeros fails");
        end
        
        $finish();
     end
endmodule