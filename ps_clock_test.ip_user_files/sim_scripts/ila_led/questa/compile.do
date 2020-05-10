vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../ps_clock_test.srcs/sources_1/ip/ila_led/hdl/verilog" "+incdir+../../../../ps_clock_test.srcs/sources_1/ip/ila_led/hdl/verilog" \
"D:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../ps_clock_test.srcs/sources_1/ip/ila_led/hdl/verilog" "+incdir+../../../../ps_clock_test.srcs/sources_1/ip/ila_led/hdl/verilog" \
"../../../../ps_clock_test.srcs/sources_1/ip/ila_led/sim/ila_led.v" \


vlog -work xil_defaultlib \
"glbl.v"

