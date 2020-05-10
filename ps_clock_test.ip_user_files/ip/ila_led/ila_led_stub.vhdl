-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
-- Date        : Sun May 10 10:50:39 2020
-- Host        : 372QMN39Y4Y0WAX running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/fastAcess/recent/xen_on_ARM/PR/ps_clock_test/ps_clock_test/ps_clock_test.srcs/sources_1/ip/ila_led/ila_led_stub.vhdl
-- Design      : ila_led
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu2eg-sfva625-1-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_led is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end ila_led;

architecture stub of ila_led is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2017.2";
begin
end;
