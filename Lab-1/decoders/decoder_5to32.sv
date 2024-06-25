`include "decoder_1to2.sv"
`include "decoder_4to16.sv"

module decoder_5to32 (outputs, inputs, ena);
	input logic ena;
	input logic [4:0] inputs;
	output logic [31:0] outputs;
	
	logic [1:0] selects;
	decoder_1to2 sel_line (.outputs(selects), .inputs(inputs[4]), .ena(ena));

	decoder_4to16 out_31to16 (.outputs(outputs[31:16]), .inputs(inputs[3:0]), .ena(selects[1]));
	decoder_4to16 out_15to0 (.outputs(outputs[15:0]), .inputs(inputs[3:0]), .ena(selects[0]));
	
endmodule
