#部分可重构流程

#1、设置板卡和FPGA芯片类型,输入和输出目录
# device and board
set device xczu2eg-sfva625-1-e
set board interwiser:none:part0:2.0
#Input Directories
set srcDir     "./Sources"
set rtlDir     "$srcDir/hdl"
set xdcDir     "$srcDir/xdc"
####Output Directories
set synthDir  "./Synth"
set implDir   "./Implement"
set dcpDir    "./Checkpoint"
set bitDir    "./Bitstreams"

#--top
#-----count inst_count(count_up,count_down)
#-----shift inst_shift(shift_left,shift_right)
set static top
set pm1 count
set inst_pm1 inst_count
set pm1_v1 ${pm1}_up
set pm1_v2 ${pm1}_down

set pm2 shift
set inst_pm2 inst_shift
set pm2_v1 ${pm2}_right
set pm2_v2 ${pm2}_left

#2、综合所有静态模块和部分可重构模块
#建立静态逻辑综合目录
#file mkdir $synthDir
#file delete -force $synthDir/Static
#file mkdir $synthDir/Static
#综合顶层静态模块
#puts "#HD: Running synthesis for block Static"
#create_project -in_memory -part ${device}
#set_property source_mgmt_mode All [current_project]
#set_property board_part ${board} [current_project]
#add_files $rtlDir/${static}/${static}.v
#synth_design -mode default -flatten_hierarchy rebuilt -top ${static} -part ${device} 
#write_checkpoint -force $synthDir/Static/${static}_synth.dcp
#report_utilization -file $synthDir/Static/${static}_utilization_synth.rpt
#close_project
#puts "#HD: Synthesis of module Static complete\n"

#建立count_up可重构模块综合目录
file mkdir $synthDir
file delete -force $synthDir/${pm1_v1}
file mkdir $synthDir/${pm1_v1}
#综合count_up可重构模块
puts "#HD: Running synthesis for block ${pm1_v1}"
create_project -in_memory -part ${device}
set_property source_mgmt_mode All [current_project]
set_property board_part ${board} [current_project]
add_files $rtlDir/${pm1_v1}/${pm1_v1}.v
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top ${pm1} -part ${device}
write_checkpoint -force $synthDir/${pm1_v1}/${pm1}_synth.dcp
report_utilization -file $synthDir/${pm1_v1}/${pm1}_utilization_synth.rpt
close_project
puts "#HD: Synthesis of module ${pm1_v1} complete\n"
#建立count_down可重构模块综合目录
file mkdir $synthDir
file delete -force $synthDir/${pm1_v2}
file mkdir $synthDir/${pm1_v2}
#综合count_down可重构模块
puts "#HD: Running synthesis for block ${pm1_v2}"
create_project -in_memory -part ${device}
set_property source_mgmt_mode All [current_project]
set_property board_part ${board} [current_project]
add_files $rtlDir/${pm1_v2}/${pm1_v2}.v
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top ${pm1} -part ${device} 
write_checkpoint -force $synthDir/${pm1_v2}/${pm1}_synth.dcp
report_utilization -file $synthDir/${pm1_v2}/${pm1}_utilization_synth.rpt
close_project
puts "#HD: Synthesis of module ${pm1_v2} complete\n"

#建立shift_right可重构模块综合目录
file mkdir $synthDir
file delete -force $synthDir/${pm2_v1}
file mkdir $synthDir/${pm2_v1}
puts "#HD: Running synthesis for block shift_right"
#综合shift_right可重构模块
create_project -in_memory -part ${device}
set_property source_mgmt_mode All [current_project]
set_property board_part ${board} [current_project]
add_files $rtlDir/${pm2_v1}/${pm2_v1}.v
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top ${pm2} -part ${device}
write_checkpoint -force $synthDir/${pm2_v1}/${pm2}_synth.dcp 
report_utilization -file $synthDir/${pm2_v1}/${pm2}_utilization_synth.rpt
close_project
puts "#HD: Synthesis of module ${pm2_v1} complete\n"

#建立shift_left可重构模块综合目录
file mkdir $synthDir
file delete -force $synthDir/${pm2_v2}
file mkdir $synthDir/${pm2_v2}
puts "#HD: Running synthesis for block shift_left"
#综合shift_left可重构模块
create_project -in_memory -part ${device}
set_property source_mgmt_mode All [current_project]
set_property board_part ${board} [current_project]
add_files $rtlDir/${pm2_v2}/${pm2_v2}.v
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top ${pm2} -part ${device}
write_checkpoint -force $synthDir/${pm2_v2}/${pm2}_synth.dcp
report_utilization -file $synthDir/${pm2_v2}/${pm2}_utilization_synth.rpt
close_project
puts "#HD: Synthesis of module shift_left complete\n"

#3、第一个config,static+shift_right+count_up,即 Config_shift_right_count_up_implement
set init_config Config_${pm2_v1}_${pm1_v1}_implement
file mkdir $implDir
file delete -force $implDir/${init_config}
file mkdir $implDir/${init_config}
file mkdir $implDir/${init_config}/reports
puts "#HD: Running implementation ${init_config}"
create_project -in_memory -part ${device}
set_property board_part ${board} [current_project]
add_files $synthDir/Static/${static}_synth.dcp
add_files $xdcDir/top_interwiser.xdc
set_property USED_IN {implementation} [get_files $xdcDir/top_interwiser.xdc]
add_file $synthDir/${pm2_v1}/${pm2}_synth.dcp
set_property SCOPED_TO_CELLS {inst_shift} [get_files $synthDir/${pm2_v1}/${pm2}_synth.dcp]
add_file $synthDir/${pm1_v1}/${pm1}_synth.dcp
set_property SCOPED_TO_CELLS {inst_count} [get_files $synthDir/${pm1_v1}/${pm1}_synth.dcp]
link_design -mode default -reconfig_partitions {inst_count inst_shift} -part ${device} -top ${static}
write_checkpoint -force $implDir/${init_config}/top_link_design.dcp
opt_design
write_checkpoint -force $implDir/${init_config}/top_opt_design.dcp 
place_design
write_checkpoint -force $implDir/${init_config}/top_place_design.dcp 
phys_opt_design
write_checkpoint -force $implDir/${init_config}/top_phys_opt_design.dcp
route_design
puts "	#HD: Completed: opt_design,place_design,phys_opt_design,route_design"
write_checkpoint -force $implDir/${init_config}/top_route_design.dcp 
#报告利用率、布线状态以及时序
report_utilization -file $implDir/${init_config}/reports/top_utilization_route_design.rpt
report_route_status -file $implDir/${init_config}/reports/top_route_status.rpt
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $implDir/${init_config}/reports/top_timing_summary.rpt
report_drc -ruledeck bitstream_checks -name top -file $implDir/${init_config}/reports/top_drc_bitstream_checks.rpt
#锁定inst_shift的shift_right布线
lock_design -level logical -cell ${inst_pm2}
write_checkpoint -force -cell ${inst_pm2} $implDir/${init_config}/${inst_pm2}_${pm2_v1}_route_design.dcp
file copy -force $implDir/${init_config}/${inst_pm2}_${pm2_v1}_route_design.dcp $dcpDir
# 将布线结果中的inst_shift替换为blackbox
update_design -cell ${inst_pm2} -black_box
#锁定${inst_pm1}的count_up布线
lock_design -level logical -cell $inst_pm1
write_checkpoint -force -cell $inst_pm1 $implDir/${init_config}/${inst_pm1}_${pm1_v1}_route_design.dcp
file copy -force $implDir/${init_config}/${inst_pm1}_${pm1_v1}_route_design.dcp $dcpDir
# 将布线结果中的inst_count替换为blackbox
update_design -cell ${inst_pm1} -black_box
# 锁定inst_shift和inst_count替换为黑盒后的布线结果
lock_design -level routing
write_checkpoint -force $implDir/${init_config}/top_static.dcp
#保存shell的布线结果，供后续role布局布线使用
file copy -force $implDir/${init_config}/top_static.dcp $dcpDir
puts "#HD: Implementation ${init_config} complete\n"
close_project

#4、第二个config,static+shift_left+count_down,即 Config_shift_left_count_down_import
set alter_config Config_${pm2_v2}_${pm1_v2}_import
file mkdir $implDir
file delete -force $implDir/${alter_config}
file mkdir $implDir/${alter_config}
file mkdir $implDir/${alter_config}/reports
puts "#HD: Running implementation ${alter_config}"
create_project -in_memory -part ${device}
set_property board_part ${board} [current_project]
add_files $dcpDir/top_static.dcp
add_file $synthDir/${pm2_v2}/${pm2}_synth.dcp
set_property SCOPED_TO_CELLS { inst_shift } [get_files $synthDir/${pm2_v2}/${pm2}_synth.dcp]
add_file $synthDir/${pm1_v2}/${pm1}_synth.dcp
set_property SCOPED_TO_CELLS { inst_count } [get_files $synthDir/${pm1_v2}/${pm1}_synth.dcp]
link_design -mode default -reconfig_partitions { inst_count inst_shift } -part ${device} -top top
write_checkpoint -force $implDir/${alter_config}/top_link_design.dcp
opt_design
write_checkpoint -force $implDir/${alter_config}/top_opt_design.dcp
place_design 
write_checkpoint -force $implDir/${alter_config}/top_place_design.dcp
phys_opt_design 
write_checkpoint -force $implDir/${alter_config}/top_phys_opt_design.dcp
route_design
puts "	#HD: Completed: opt_design,place_design,phys_opt_design,route_design"
write_checkpoint -force $implDir/${alter_config}/top_route_design.dcp
#报告利用率、布线状态以及时序
report_utilization -file $implDir/${alter_config}/reports/top_utilization_route_design.rpt
report_route_status -file $implDir/${alter_config}/reports/top_route_status.rpt
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $implDir/${alter_config}/reports/top_timing_summary.rpt
report_drc -ruledeck bitstream_checks -name top -file $implDir/${alter_config}/reports/top_drc_bitstream_checks.rpt
#锁定inst_shift的shift_left布线
lock_design -level logical -cell ${inst_pm2}
write_checkpoint -force -cell ${inst_pm2} $implDir/${alter_config}/${inst_pm2}_${pm2_v2}_route_design.dcp
file copy -force $implDir/${alter_config}/${inst_pm2}_${pm2_v2}_route_design.dcp $dcpDir
#锁定inst_count的count_down布线
lock_design -level logical -cell ${inst_pm1}
write_checkpoint -force -cell ${inst_pm1} $implDir/${alter_config}/${inst_pm1}_${pm1_v2}_route_design.dcp
file copy -force $implDir/${alter_config}/${inst_pm1}_${pm1_v2}_route_design.dcp $dcpDir
puts "#HD: Implementation ${alter_config} complete\n"
close_project

#5、验证两种配置是否兼容
puts "#HD: Running pr_verify between initial Configuration '${alter_config}' and subsequent configurations '${init_config}'"
pr_verify -full_check -initial $implDir/${alter_config}/top_route_design.dcp -additional  $implDir/${init_config}/top_route_design.dcp

#6、生成两种配置的bit和部分配置bit
puts "	#HD: Running write_bitstream on ${alter_config}"
open_checkpoint $implDir/${alter_config}/top_route_design.dcp 
write_bitstream -force  $bitDir/${alter_config}_full -no_partial_bitfile
write_bitstream -force  -cell ${inst_pm2} $bitDir/pblock_${inst_pm2}_${pm2_v2}_partial
write_bitstream -force  -cell ${inst_pm1} $bitDir/pblock_${inst_pm1}_${pm1_v2}_partial
close_project 
puts "	#HD: Running write_bitstream on ${init_config}"
open_checkpoint $implDir/${init_config}/top_route_design.dcp 
write_bitstream -force  $bitDir/${init_config}_full -no_partial_bitfile
write_bitstream -force  -cell ${inst_pm2} $bitDir/pblock_${inst_pm2}_${pm2_v1}_partial
write_bitstream -force  -cell ${inst_pm1} $bitDir/pblock_${inst_pm1}_${pm1_v1}_partial
close_project 
