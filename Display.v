module Display(clk, rst, seg2, seg4, seg51, seg91, seg50, seg90, finalSel, finalSeg);
    input clk;
    input rst;
    input [7:0] seg2, seg4, seg51, seg91, seg50, seg90;
    output [5:0] finalSel;
    output reg [7:0] finalSeg;
    
    reg [15:0] count;
    reg [2:0] sel;
    reg [5:0] isel;
    
    // FPGA has a 50MHz clock
    // Want to show each seg 1ms (1000Hz new clock)
    // Show time in terms of clock cycle: 50MHz / 1000Hz = 50000 clock cycles
    // Counter of keeping track of 50000 (16 bits)
    always@(posedge clk) begin
       if(!rst) begin
            count <= 16'h0000;
       end else if(count == 16'd49999) begin
            count <= 16'h0000;
       end else
            count <= count + 16'd1;
     end
     
     // Select which display is on based on the counter
     always@(posedge clk) begin
        if(!rst) begin
            sel <= 3'b000;
        end else if(sel == 3'b101 && count == 16'd49999) begin
            sel <= 3'b000;
        end else if(count == 16'd49999) begin
            sel <= sel + 3'd1;
        end else begin
            sel <= sel;
        end
      end
      
      // finalSel
      always@(sel) begin
        case(sel)
            3'b000: isel = 6'b000001;
            3'b001: isel = 6'b000010;
            3'b010: isel = 6'b000100;
            3'b011: isel = 6'b001000;
            3'b100: isel = 6'b010000;
            3'b101: isel = 6'b100000;
            default: isel = 6'b000000;
        endcase
      end
      
      assign finalSel = isel;
      
      // finalSeg
      always@(isel) begin
        case(isel)
            6'b000001: finalSeg = seg90;
            6'b000010: finalSeg = seg50;
            6'b000100: finalSeg = seg91;
            6'b001000: finalSeg = seg51;
            6'b010000: finalSeg = seg4;
            6'b100000: finalSeg = seg2;
            default: finalSeg = 8'hff;
         endcase  
      end
        
endmodule