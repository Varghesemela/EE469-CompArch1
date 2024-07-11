# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

vlog "./flipflops/dff.sv"
vlog "./multiplexers/mux_2to1.sv"
vlog "./multiplexers/mux_4to1.sv"
vlog "./multiplexers/mux_8to1.sv"
vlog "ALU_1b.sv"
vlog "ALU_64b.sv"
vlog "./adders/full_adder.sv"
vlog "./gates/nor_64b.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.

vsim -voptargs="+acc" -t 1ps -lib work alustim


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.


do ALU_64b_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
