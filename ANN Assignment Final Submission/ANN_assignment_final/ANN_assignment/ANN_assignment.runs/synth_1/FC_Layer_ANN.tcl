# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {E:/edu/sem6/logic2/ANN Assignment Final Submission/ANN_assignment_final/ANN_assignment/ANN_assignment.cache/wt} [current_project]
set_property parent.project_path {E:/edu/sem6/logic2/ANN Assignment Final Submission/ANN_assignment_final/ANN_assignment/ANN_assignment.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]
read_verilog -library xil_defaultlib {
  {E:/edu/sem6/logic2/ANN Assignment Final Submission/ANN_assignment_final/ANN_assignment/ANN_assignment.srcs/sources_1/imports/Help Verilog Files/fp_add.v}
  {E:/edu/sem6/logic2/ANN Assignment Final Submission/ANN_assignment_final/ANN_assignment/ANN_assignment.srcs/sources_1/imports/FLP_Lab1/fp_mul.v}
  {E:/edu/sem6/logic2/ANN Assignment Final Submission/ANN_assignment_final/ANN_assignment/ANN_assignment.srcs/sources_1/imports/Help Verilog Files/PE_FC_ANN.v}
  {E:/edu/sem6/logic2/ANN Assignment Final Submission/ANN_assignment_final/ANN_assignment/ANN_assignment.srcs/sources_1/imports/Help Verilog Files/FC_Layer_ANN.v}
}
synth_design -top FC_Layer_ANN -part xc7z020clg400-1
write_checkpoint -noxdef FC_Layer_ANN.dcp
catch { report_utilization -file FC_Layer_ANN_utilization_synth.rpt -pb FC_Layer_ANN_utilization_synth.pb }
