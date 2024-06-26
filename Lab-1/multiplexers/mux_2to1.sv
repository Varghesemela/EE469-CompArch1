module mux_2to1(out, inputs, sel);
 output logic out;
 input logic [1:0] inputs;
 input logic sel;

 and mux1 (temp1, inputs[0], ~sel);
 and mux2 (temp2, inputs[1], sel);
 or add (out, temp1, temp2);
 
endmodule

module mux_2to1_testbench();
	logic [1:0] inputs;
	logic sel;
	logic out;
	mux_2to1 dut (.out, .inputs, .sel);
	initial begin
	sel=0; inputs[0]=0; inputs[1]=0; #10;
	sel=0; inputs[0]=0; inputs[1]=1; #10;
	sel=0; inputs[0]=1; inputs[1]=0; #10;
	sel=0; inputs[0]=1; inputs[1]=1; #10;
	sel=1; inputs[0]=0; inputs[1]=0; #10;
	sel=1; inputs[0]=0; inputs[1]=1; #10;
	sel=1; inputs[0]=1; inputs[1]=0; #10;
	sel=1; inputs[0]=1; inputs[1]=1; #10;
	end
endmodule