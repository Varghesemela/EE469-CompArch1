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
	
	always @(posedge clk, posedge reset) 
	begin
		 if(reset)
			  pc_out <= 32'b0;
		 else
			  pc_out <= pc_in;
	end

endmodule