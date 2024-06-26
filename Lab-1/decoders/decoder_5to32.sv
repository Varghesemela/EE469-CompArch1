`include "decoder_1to2.sv"
`include "decoder_4to16.sv"

module decoder_5to32 (outputs, inputs, ena);
	input logic ena;
	input logic [4:0] inputs;
	output logic [31:0] outputs;
	
	logic [1:0] selects;
	decoder_1to2 sel_line (.outputs(selects), .in_sel(inputs[4]), .ena(ena));

	decoder_4to16 out_31to16 (.outputs(outputs[31:16]), .inputs(inputs[3:0]), .ena(selects[1]));
	decoder_4to16 out_15to0 (.outputs(outputs[15:0]), .inputs(inputs[3:0]), .ena(selects[0]));
	
endmodule


module decoder_5to32_testbench();
	logic ena;
	logic [4:0] inputs;
	logic [31:0] outputs;
	decoder_5to32 dut (.outputs, .inputs, .ena);
	initial begin
	
	ena=0; inputs=5'b0000;  #10;
	ena=0;  inputs=5'b0001;  #10;
	ena=1;  inputs=5'b0010;  #10;
	ena=1; inputs=5'b01000;  #10;

	end
endmodule