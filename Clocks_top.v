module Clocks_top(clk, rst, mode, add, nextP0, nextP1, ds, shcp, stcp, oe, second, minute, hour, modeDis);
    input clk, rst, add, mode, nextP0, nextP1;
    output ds, shcp, stcp, oe, second, minute, hour, modeDis;
    
    wire syn_mode, syn_add, syn_nextP0, syn_nextP1;
    wire curr_mode;
    wire ds0, ds1;
    wire shcp0, shcp1;
    wire stcp0, stcp1;
    wire oe0, oe1;
    wire second0, second1;
    wire minute0, minute1;
    wire hour0, hour1;
    
    // synchronize the signal of mode changing
    Button isyn0(.clk(clk), .rst(rst), .key_in(mode), .key_syn(syn_mode));
    
    // synchronize add
    Button isyn1(.clk(clk), .rst(rst), .key_in(add), .key_syn(syn_add));
    
    // synchronize nextP0
    Button isyn2(.clk(clk), .rst(rst), .key_in(nextP0), .key_syn(syn_nextP0));
    
    // synchronize nextP1
    Button isyn3(.clk(clk), .rst(rst), .key_in(nextP1), .key_syn(syn_nextP1));
    
    // Mode change 
    Mode imode(.clk(clk), .rst(rst), .curr(curr_mode), .change(syn_mode));
    
    // Clock 0
    Clock iclock0(.clk(clk), .rst(rst), .add(syn_add), .nextP(syn_nextP0), .ds(ds0), .shcp(shcp0), .stcp(stcp0), .oe(oe0), .second(second0), .minute(minute0), .hour(hour0));
    
    // Clock 1
    Clock iclock1(.clk(clk), .rst(rst), .add(syn_add), .nextP(syn_nextP1), .ds(ds1), .shcp(shcp1), .stcp(stcp1), .oe(oe1), .second(second1), .minute(minute1), .hour(hour1));
    
    assign ds = curr_mode ? ds1 : ds0;
    assign shcp = curr_mode ? shcp1 : shcp0;
    assign stcp = curr_mode ? stcp1 : stcp0;
    assign oe = curr_mode ? oe1 : oe0;
    assign second = curr_mode ? second1 : second0;
    assign minute = curr_mode ? minute1 : minute0;
    assign hour = curr_mode ? hour1 : hour0;
    assign modeDis = curr_mode;
    
endmodule