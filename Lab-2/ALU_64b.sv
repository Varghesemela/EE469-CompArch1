
// Test bench for ALU
`timescale 1ns/10ps

module ALU_64 (
				input [63:0] A, B, 
				input [2:0] cntrl, 
				output [63:0] result, 
				output zero, overflow, carry_out, negative
				);
				
	parameter delay = 100000;
	logic [64:0] carry_var;	
	assign carry_var[0] = cntrl[0];			
    generate
        genvar i;
        for (i = 0; i < 64; i++) begin : alu_block
			ALU_1b alu_instance (
			  .a(A[i]),
			  .b(B[i]),
			  .cin(carry_var[i]),
			  .cout(carry_var[i+1]),
			  .op(cntrl),
			  .result(result[i])
			);
        end
    endgenerate
	 			
	nor zero_out (zero,result[63:0]); // TODO: Need to test, if this doesnt work, create a seperate module
	xor overflow_out (overflow, cout[64], cout[63]);
	assign carry_out = carry_var[64];		
	assign negative = result[63];

endmodule


// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	ALU_64b dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			$display("A = %b, B = %b, result = %b, z = %b, ovf = %b, neg = %b", A, B, result, zero, overflow, negative);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
	end
endmodule


	