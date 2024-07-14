// Imm select and sign extend
module imm_conversion (instruction, imm_sel, imm_out);

    input logic [31:0] instruction;
    input logic [1:0] imm_sel;
    output logic [63:0] imm_out;

	// internal signal representation
	logic [63:0] immediate;

	localparam [1:0]	D_TYPE = 2'b00,
				  		B_TYPE = 2'b01,
				  		CB_TYPE = 2'b10; 

	always @(*)
	begin
		 case(imm_sel)

		 D_TYPE:
			  immediate <= {{55{instr[20]}}, instr[20:12]};

		 B_TYPE:
			  immediate <= {{38{instr[25]}}, instr[25:0]};

		 CB_TYPE:
			  immediate <= {{45{instr[23]}}, instr[23:5]};

		 default:
			  immediate <= 64'bx;

		 endcase
	end

	assign imm_out = immediate;

endmodule