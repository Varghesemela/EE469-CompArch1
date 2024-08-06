# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

vlog "Reg_dff.sv"
vlog "regfile.sv"


vlog "registerfile.sv"
vlog "register.sv"
vlog "pc_adder.sv"
vlog "pc.sv"
vlog "nor_64b.sv"
vlog "multiplexers.sv"
vlog "left_shift_2.sv"
vlog "instructmem.sv"
vlog "full_adder.sv"
vlog "dff.sv"
vlog "edff.sv"
vlog "decoders.sv"
vlog "zeroExtend.sv"
vlog "signExtend.sv"
vlog "Instr_to_addr.sv"
vlog "control_unit.sv"
vlog "datapath_unit.sv"
vlog "datamem.sv"
vlog "ALU_64b.sv"
vlog "ALU_1b.sv"
vlog "single_cycle_cpu.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.

vsim -voptargs="+acc" -t 1ps -lib work single_cycle_cpu_testbench


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.


do single_cycle_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
