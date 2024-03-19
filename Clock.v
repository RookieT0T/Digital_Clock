module Clock(clk, rst, add, nextP, ds, shcp, stcp, oe, second, minute, hour);
    input clk, rst, add, nextP;
    output ds, shcp, stcp, oe, second, minute, hour;
    
    wire ms, mm, mh;
    wire out, cout590, cout591;
    wire [7:0] dis590_0, dis590_1, dis591_0, dis591_1, dis24_0, dis24_1;
    wire [5:0] finalSel;
    wire [7:0] finalSeg;
      
    // FSM to change second, minute, or hour
    FSM iFSM(.clk(clk), .rst(rst), .nextP(~nextP), .ms(ms), .mm(mm), .mh(mh));
    
    // 1Hz clock
    F1Hz iF1Hz(.clk(clk), .rst(rst), .out(out));
    
    // seconds
    Logic59 i590(.add(add), .second(out), .modify(ms), .cout(cout590), .display0(dis590_0), .display1(dis590_1), .clk(clk), .rst(rst));
    
    // minutes
    Logic59 i591(.add(add), .second(cout590), .modify(mm), .cout(cout591), .display0(dis591_0), .display1(dis591_1), .clk(clk), .rst(rst));
    
    // hours
    Logic24 i24(.add(add), .minute(cout591), .modify(mh), .display0(dis24_0), .display1(dis24_1), .clk(clk), .rst(rst));
    
    // display
    Display idisplay(.clk(clk), .rst(rst), .seg2(dis24_1), .seg4(dis24_0), .seg51(dis591_1), .seg91(dis591_0), .seg50(dis590_1), .seg90(dis590_0), .finalSel(finalSel), .finalSeg(finalSeg));
    
    // chip driver
    Chip ichip(.clk(clk), .rst(rst), .sel(finalSel), .seg(finalSeg), .ds(ds), .shcp(shcp), .stcp(stcp), .oe(oe));
    
    // signals to indicate which part can be modified
    assign second = ~ms;
    assign minute = ~mm;
    assign hour = ~mh;
   
endmodule