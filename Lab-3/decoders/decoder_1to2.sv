
module decoder_1to2 (outputs, in_sel, ena);
	input logic ena;
	input logic in_sel;
	output logic [1:0] outputs;
	
	logic not_input;
	not(not_input, in_sel);
	
	and result1 (outputs[1], in_sel, ena);
	and result0 (outputs[0], not_input, ena);
endmodule

module decoder_1to2_testbench();
	logic ena;
	logic in_sel;
	logic [1:0] outputs;
	decoder_1to2 dut (.outputs, .in_sel, .ena);
	initial begin
	ena=0; in_sel=0;  #10;
	ena=0;  in_sel=1;  #10;
	ena=1;  in_sel=0;  #10;
	ena=1; in_sel=1;  #10;

	end
endmodule