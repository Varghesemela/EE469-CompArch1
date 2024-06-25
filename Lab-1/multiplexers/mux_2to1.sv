module mux_2to1(out, inputs, sel);
 output logic out;
 input logic [1:0] inputs;
 input logic sel;

 and mux1 (temp1, inputs[0], ~sel);
 and mux2 (temp2, inputs[1], sel);
 or add (out, temp1, temp2);
 
endmodule