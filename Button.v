module Button(clk, rst, key_in, key_syn);
    input clk, rst, key_in;
    output reg key_syn;

    parameter CNT_MAX = 20'd999999;
    reg [19:0] cnt_20ms;

    always@(posedge clk or negedge rst)
        if(rst == 1'b0)
            cnt_20ms <= 20'b0;
        else if(key_in == 1'b1)
            cnt_20ms <= 20'b0;
        else if(cnt_20ms == CNT_MAX && key_in == 1'b0)
            cnt_20ms <= cnt_20ms;
        else
            cnt_20ms <= cnt_20ms + 1'b1;

    always@(posedge clk or negedge rst)
        if(rst == 1'b0)
            key_syn <= 1'b0;
        else if(cnt_20ms == CNT_MAX - 1'b1)
            key_syn <= 1'b1;
        else
            key_syn <= 1'b0;
endmodule