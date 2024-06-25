module mux_4to1(out, inputs, selects);
 output logic out;
 input logic [3:0] inputs;
 input logic [1:0] selects;

 logic [1:0] intermediate;

 mux_2to1 m0(.out(intermediate[0]), .inputs(inputs[1:0]), .sel(selects[0]));
 mux_2to1 m1(.out(intermediate[1]), .inputs(inputs[3:2]), .sel(selects[0]));
 mux_2to1 m (.out(out), .inputs(intermediate), .sel(selects[1]));
 
endmodule