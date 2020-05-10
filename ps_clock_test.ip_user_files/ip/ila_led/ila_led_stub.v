// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Sun May 10 10:50:39 2020
// Host        : 372QMN39Y4Y0WAX running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/fastAcess/recent/xen_on_ARM/PR/ps_clock_test/ps_clock_test/ps_clock_test.srcs/sources_1/ip/ila_led/ila_led_stub.v
// Design      : ila_led
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu2eg-sfva625-1-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2017.2" *)
module ila_led(clk, probe0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0]" */;
  input clk;
  input [0:0]probe0;
endmodule
