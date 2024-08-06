`timescale 1ns/10ps
module pc_adder(A, B, sum);
	input logic [63:0] A, B;
	output logic [63:0] sum;
	logic [63:0] carryTemp;
	
	fulladder LSB_adder (.a(A[0]), .b(B[0]), .carry_in(1'b0), .carry_out(carryTemp[0]), .sum(sum[0])); 
    // Adder is 2's complement in address adding, so we dont need to worry about add/sub
	
	genvar i;
	generate 
		for (i = 1; i<64; i++) begin: eachAdder
			fulladder adder_instance (.a(A[i]), .b(B[i]), .carry_in(carryTemp[i-1]), .carry_out(carryTemp[i]), .sum(sum[i]));
			end
		endgenerate
endmodule