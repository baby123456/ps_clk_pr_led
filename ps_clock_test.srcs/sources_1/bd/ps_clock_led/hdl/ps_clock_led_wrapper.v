//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Sat May  9 23:06:19 2020
//Host        : 372QMN39Y4Y0WAX running 64-bit major release  (build 9200)
//Command     : generate_target ps_clock_led_wrapper.bd
//Design      : ps_clock_led_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ps_clock_led_wrapper
   (pl_clk,
    pl_resetn);
  output pl_clk;
  output pl_resetn;

  wire pl_clk;
  wire pl_resetn;

  ps_clock_led ps_clock_led_i
       (.pl_clk(pl_clk),
        .pl_resetn(pl_resetn));
endmodule
