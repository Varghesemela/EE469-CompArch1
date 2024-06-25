module mux_64w32to1(outputs, registers, selects);
		
		output logic [63:0] outputs;
		input logic [31:0][63:0] registers;
		input logic [4:0] selects;
		
		
		genvar i;
		generate
			for(i = 0; i < 64; i++) begin: assign_registers
				mux_32to1 assign_out (.out(outputs[i]), .inputs(registers), .selects(selects));
			end		
		endgenerate
					  
endmodule