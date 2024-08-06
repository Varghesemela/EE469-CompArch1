onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_testbench/zero
add wave -noupdate /datapath_testbench/xfer_size
add wave -noupdate /datapath_testbench/reset
add wave -noupdate /datapath_testbench/read_enable
add wave -noupdate /datapath_testbench/overflow
add wave -noupdate /datapath_testbench/negative
add wave -noupdate /datapath_testbench/memoryOut
add wave -noupdate /datapath_testbench/instruction
add wave -noupdate /datapath_testbench/clk
add wave -noupdate /datapath_testbench/carry_out
add wave -noupdate /datapath_testbench/UncondBr
add wave -noupdate /datapath_testbench/RegWrite
add wave -noupdate /datapath_testbench/Reg2Loc
add wave -noupdate /datapath_testbench/MemWrite
add wave -noupdate /datapath_testbench/MemToReg
#add wave -noupdate /datapath_testbench/Imm12Extended
add wave -noupdate /datapath_testbench/dut/Dw
add wave -noupdate /datapath_testbench/dut/Db
add wave -noupdate /datapath_testbench/dut/Da
add wave -noupdate /datapath_testbench/dut/DAddr9_extended
add wave -noupdate /datapath_testbench/dut/alub_input
add wave -noupdate /datapath_testbench/dut/ALUOp
add wave -noupdate /datapath_testbench/dut/register_bank/registers
#add wave -noupdate /datapath_testbench/DAddr9Extended
add wave -noupdate /datapath_testbench/CLOCK_PERIOD
add wave -noupdate /datapath_testbench/BrTaken
add wave -noupdate /datapath_testbench/dut/Rm_or_Rd
add wave -noupdate /datapath_testbench/ALUSrcMuxOut
add wave -noupdate /datapath_testbench/ALUSrc
add wave -noupdate /datapath_testbench/dut/ALUOut
add wave -noupdate /datapath_testbench/ALUOp
add wave -noupdate /datapath_testbench/controlUnit/opcode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1203 ps}
