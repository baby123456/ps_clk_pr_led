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