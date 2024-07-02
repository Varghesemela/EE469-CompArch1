//`include "mux_32to1.sv"
module mux_64w32to1(outputs, registers, selects);
		
		output logic [63:0] outputs;
		input logic [31:0][63:0] registers;
		input logic [4:0] selects;
		logic [31:0] column_data; // Temporary variable to hold the selected column
		
		logic [63:0][31:0] t_in;
		int o, k;
		always_comb begin
			for(int o=0; o < 32; o=o+1) begin
				for(int k=0; k < 64; k = k+1) begin
					t_in[k][o] = registers[o][k];
				end
			end
		end
		
		genvar i, j;
		generate
			for(i = 0; i < 64; i++) begin: assign_registers
				mux_32to1 assign_out (.out(outputs[i]), .inputs(t_in[i][31:0]), .selects(selects));
			end		
		endgenerate
					  
endmodule

module mux_64w32to1_testbench();
	logic [4:0] selects;
	logic [31:0][63:0] registers;
	logic [63:0] outputs;
	mux_64w32to1 dut (.outputs(outputs), .registers(registers), .selects(selects));
	initial begin
	
		for (int i = 0; i < 32; i = i + 1) begin
			registers[i][63:0] = 1<<i; // Example initialization (1 shifted left by i bits)
		end
		
		for (int j = 0; j < 32; j = j + 1) begin
			selects=j; #10;
		end
	end
endmodule