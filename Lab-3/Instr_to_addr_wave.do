onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Instr_to_addr_testbench/clk
add wave -noupdate /Instr_to_addr_testbench/reset
add wave -noupdate /Instr_to_addr_testbench/BrTaken
add wave -noupdate /Instr_to_addr_testbench/UncondBr
add wave -noupdate /Instr_to_addr_testbench/instruction
add wave -noupdate /Instr_to_addr_testbench/dut/currentPC
add wave -noupdate /Instr_to_addr_testbench/dut/pc_plus4
add wave -noupdate /Instr_to_addr_testbench/dut/BrTaken
add wave -noupdate /Instr_to_addr_testbench/dut/pc_input_address
add wave -noupdate /Instr_to_addr_testbench/dut/pc_plus_branch

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1495376 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 300
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {15750 ns}