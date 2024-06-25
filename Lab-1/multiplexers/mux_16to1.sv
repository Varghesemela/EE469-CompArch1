module mux_16to1(out, inputs, selects);
 output logic out;
 input logic [15:0] inputs;
 input logic [3:0] selects;

 logic [1:0] intermediate;

 mux_8to1 m0(.out(intermediate[0]), .inputs(inputs[7:0]), .selects(selects[2:0]));
 mux_8to1 m1(.out(intermediate[1]), .inputs(inputs[15:8]), .selects(selects[2:0]));
 mux_2to1 m (.out(out), .inputs(intermediate), .sel(selects[3]));
 
endmodule