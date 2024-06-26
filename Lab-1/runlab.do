# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./decoders/decoder_5to32.sv"

#vlog "./multiplexers/mux_2to1.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work decoder_1to2_testbench
vsim -voptargs="+acc" -t 1ps -lib work decoder_5to32_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do ./decoders/decoder_5to32_wave.do
#do ./multiplexers/mux_2to1_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
