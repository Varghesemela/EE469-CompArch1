`include "decoder_1to2.sv"
module decoder_2to4 (outputs, inputs, ena);
	input logic ena;
	input logic [1:0] inputs;
	output logic [3:0] outputs;
	
	logic [1:0] selects;
	
	decoder_1to2 sel_line (.outputs(selects), .in_sel(inputs[1]), .ena(ena));

	decoder_1to2 result0 (.outputs(outputs[1:0]), .in_sel(inputs[0]), .ena(selects[0]));
	decoder_1to2 result1 (.outputs(outputs[3:2]), .in_sel(inputs[0]), .ena(selects[1]));
	
endmodule
