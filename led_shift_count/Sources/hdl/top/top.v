//////////////////////////////////////////////////////////////////////////////
//  Top-level, static design
//////////////////////////////////////////////////////////////////////////////

module top(
   output [3:0] count_out,   // mapped to general purpose LEDs[4-7]
   output [3:0] shift_out    // mapped to general purpose LEDs[0-3]
);
   reg [34:0]  count;
   wire pl_clk;
   wire pl_resetn;

    ps_clock_led_wrapper ps_clock(
        .pl_clk(pl_clk),
        .pl_resetn(pl_resetn)
   );
   
   ila_led ila_test (
       .clk(pl_clk),           // input wire clk
       .probe0(count[0])       // input wire [0:0] probe0
   );
   
   // instantiate module shift
   shift inst_shift (
      .en       (pl_resetn),
      .clk      (pl_clk),
      .addr     (count[34:23]),
      .data_out (shift_out) 
   );
 
   // instantiate module count
   count inst_count (
      .rst       (pl_resetn),
      .clk       (pl_clk),
      .count_out (count_out)
   );

   // MAIN

   always @(posedge pl_clk or negedge pl_resetn)
     if (!pl_resetn)
       begin
         count <= 0;
       end
     else
       begin
         count <= count + 1;
       end
endmodule

// black box definition for module_shift
module shift(
   input         en,
   input         clk,
   input  [11:0] addr,
   output  [3:0] data_out);
endmodule

// black box definition for module_count
module count(
   input        rst,
   input        clk,
   output [3:0] count_out);
endmodule
