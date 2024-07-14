module pc(
	clk,
	reset,
	pc_in,
	pc_out
);

	// I/O ports
	input clk;
	input reset;
	input [31:0] pc_in;
	output reg [31:0] pc_out;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: eachDFF
			D_FF theDFF (.q(pc_out[i]), .d(pc_in[i]), .reset, .clk);
		end
	endgenerate

endmodule