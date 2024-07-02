//`include "mux_16to1.sv"
//`include "mux_2to1.sv"

module mux_32to1(out, inputs, selects);
 output logic out;
 input logic [31:0] inputs;
 input logic [4:0] selects;

 logic [1:0] intermediate;

 mux_16to1 m0(.out(intermediate[0]), .inputs(inputs[15:0]), .selects(selects[3:0]));
 mux_16to1 m1(.out(intermediate[1]), .inputs(inputs[31:16]), .selects(selects[3:0]));
 mux_2to1 m (.out(out), .inputs(intermediate), .sel(selects[4]));
	 
endmodule