//`include "mux_4to1.sv"
//`include "mux_2to1.sv"

module mux_8to1(out, inputs, selects);
 output logic out;
 input logic [7:0] inputs;
 input logic [2:0] selects;

 logic [1:0] intermediate;

 mux_4to1 m0(.out(intermediate[0]), .inputs(inputs[3:0]), .selects(selects[1:0]));
 mux_4to1 m1(.out(intermediate[1]), .inputs(inputs[7:4]), .selects(selects[1:0]));
 mux_2to1 m (.out(out), .inputs(intermediate), .sel(selects[2]));
 
endmodule