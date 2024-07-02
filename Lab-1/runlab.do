# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

vlog "register.sv"
vlog "./flipflops/dff.sv"
vlog "./multiplexers/mux_2to1.sv"
vlog "./multiplexers/mux_4to1.sv"
vlog "./multiplexers/mux_8to1.sv"
vlog "./multiplexers/mux_16to1.sv"
vlog "./multiplexers/mux_32to1.sv"
vlog "./multiplexers/mux_64w32to1.sv"
vlog "./decoders/decoder_5to32.sv"
vlog "./decoders/decoder_4to16.sv"
vlog "./decoders/decoder_2to4.sv"
vlog "./decoders/decoder_1to2.sv"
vlog "registerfile.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.

vsim -voptargs="+acc" -t 1ps -lib work regstim
#vsim -voptargs="+acc" -t 1ps -lib work dff_testbench
#vsim -voptargs="+acc" -t 1ps -lib work register_testbench
#vsim -voptargs="+acc" -t 1ps -lib work mux_64w32to1_testbench


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.

#do ./flipflops/dff_wave.do
#do ./multiplexers/mux_2to1_wave.do
#do register_wave.do
#do ./multiplexers/mux_64w32to1_wave.do
do registerfile_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
