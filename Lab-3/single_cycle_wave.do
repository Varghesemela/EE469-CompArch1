onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /single_cycle_cpu_testbench/clk
add wave -noupdate /single_cycle_cpu_testbench/reset
add wave -noupdate /single_cycle_cpu_testbench/cpu/instruction
add wave -noupdate /single_cycle_cpu_testbench/cpu/zero
add wave -noupdate /single_cycle_cpu_testbench/cpu/negative
add wave -noupdate /single_cycle_cpu_testbench/cpu/overflow
add wave -noupdate /single_cycle_cpu_testbench/cpu/carry_out
add wave -noupdate /single_cycle_cpu_testbench/cpu/BrTaken
add wave -noupdate /single_cycle_cpu_testbench/cpu/ALUOp
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/fetchInstruction/currentPC
add wave -noupdate /single_cycle_cpu_testbench/cpu/controlUnit/opcode
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/register_bank/registers
add wave -noupdate /single_cycle_cpu_testbench/cpu/datapathUnit/zeroFlag 
add wave -noupdate /single_cycle_cpu_testbench/cpu/datapathUnit/negativeFlag
add wave -noupdate /single_cycle_cpu_testbench/cpu/datapathUnit/overflowFlag
add wave -noupdate /single_cycle_cpu_testbench/cpu/datapathUnit/carryOutFlag
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/Imm_value
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/ALUOut
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/MemWrite
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/Rm_or_Rd
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/Da
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/Db
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/Dw
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/datapathUnit/memoryOut
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/fetchInstruction/sign_extended_branchaddr
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/fetchInstruction/shifted_address
add wave -noupdate -radix decimal /single_cycle_cpu_testbench/cpu/fetchInstruction/pc_plus_branch

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