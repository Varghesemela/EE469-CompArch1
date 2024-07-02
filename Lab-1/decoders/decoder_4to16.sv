//`include "decoder_2to4.sv"

module decoder_4to16 (outputs, inputs, ena);	
	input logic ena;
	input logic [3:0] inputs;
	output logic [15:0] outputs;
	
	logic [3:0] selects;
	
	decoder_2to4 firstDecoder(.outputs(selects), .inputs(inputs[3:2]), .ena(ena));
	
	decoder_2to4 out_15to12 (.outputs(outputs[15:12]), .inputs(inputs[1:0]), .ena(selects[3]));
	decoder_2to4 out_11to8 (.outputs(outputs[11:8]), .inputs(inputs[1:0]), .ena(selects[2]));
	decoder_2to4 out_7to4 (.outputs(outputs[7:4]), .inputs(inputs[1:0]), .ena(selects[1]));
	decoder_2to4 out_3to0 (.outputs(outputs[3:0]), .inputs(inputs[1:0]), .ena(selects[0]));
	
endmodule
