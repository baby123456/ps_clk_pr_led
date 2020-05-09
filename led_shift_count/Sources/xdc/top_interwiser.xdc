#create_clock -period 20.000 -name clk -waveform {0.000 10.000} [get_ports {clk}]

#-------------------------------------------------
# pblock_inst_count 
#            for pr instance inst_count 
#-------------------------------------------------
create_pblock pblock_inst_count
add_cells_to_pblock [get_pblocks pblock_inst_count] [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_inst_count] -add {SLICE_X2Y65:SLICE_X16Y112}
resize_pblock [get_pblocks pblock_inst_count] -add {DSP48E2_X0Y26:DSP48E2_X0Y43}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB18_X0Y26:RAMB18_X1Y43}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB36_X0Y13:RAMB36_X1Y21}

#-------------------------------------------------
# pblock_inst_shift
#            for pr instance inst_shift 
#-------------------------------------------------
create_pblock pblock_inst_shift
add_cells_to_pblock [get_pblocks pblock_inst_shift] [get_cells -quiet [list inst_shift]]
resize_pblock [get_pblocks pblock_inst_shift] -add {SLICE_X2Y124:SLICE_X13Y165}
resize_pblock [get_pblocks pblock_inst_shift] -add {DSP48E2_X0Y50:DSP48E2_X0Y65}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB18_X0Y50:RAMB18_X1Y65}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB36_X0Y25:RAMB36_X1Y32}

#led0
set_property PACKAGE_PIN H10 [get_ports {shift_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[0]}]
#led1
set_property PACKAGE_PIN H9 [get_ports {shift_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[1]}]
#led2
set_property PACKAGE_PIN G10 [get_ports {shift_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[2]}]
#led3
set_property PACKAGE_PIN F10 [get_ports {shift_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[3]}]
#led4
set_property PACKAGE_PIN H11 [get_ports {count_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[0]}]
#led5
set_property PACKAGE_PIN G11 [get_ports {count_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[1]}]
#led6
set_property PACKAGE_PIN G12 [get_ports {count_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[2]}]
#led7
set_property PACKAGE_PIN F12 [get_ports {count_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[3]}]