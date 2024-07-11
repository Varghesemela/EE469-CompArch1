module control_unit(
    input logic [10:0] opcode,
    output logic [1:0] imm_sel,
	 output logic [2:0] ALUOp,
    output logic RegWrite, ALUSrc, MemToReg, MemRead, MemWrite, BrTaken, UncondBr
);

	localparam [10:0]
					ADD_OP 	= 	11'b10001011000,
					SUB_OP 	= 	11'b11001011000,
					LOAD_OP  = 	11'b11111000010,
					STORE_OP = 	11'b11111000000,
					B_OP   	=	11'b000101xxxxx, 
					CB_OP		=	11'b10110100xxx;
				  
	always @*
	begin
		 case(opcode)

			  ADD_OP:
					begin
						 imm_sel = 2'bxx;
						 RegWrite = 1'b1;
						 ALUSrc = 1'b0;
						 MemToReg = 1'b0;
						 ALUOp = 2'b010;
						 MemRead = 1'b0;
						 MemWrite = 1'b0;
						 BrTaken = 1'b0;
						 UncondBr= 1'bx; 
					end
					
				SUB_OP:
					begin
						 imm_sel = 2'bxx;
						 RegWrite = 1'b1;
						 ALUSrc = 1'b0;
						 MemToReg = 1'b0;
						 ALUOp = 2'b011;
						 MemRead = 1'b0;
						 MemWrite = 1'b0;
						 BrTaken = 1'b0;
						 UncondBr= 1'bx; 
					end

			  LOAD_OP:
					begin
						 imm_sel = 2'b00;
						 RegWrite = 1'b1;
						 ALUSrc = 1'b1;
						 MemToReg = 1'b1;
						 ALUOp = 2'b00;
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 BrTaken = 1'b0;
						 UncondBr= 1'bx;
					end

			  STORE_OP:
					begin
						 imm_sel = 2'b00;
						 RegWrite = 1'b0;
						 ALUSrc = 1'b1;
						 MemToReg = 1'b0;
						 ALUOp = 2'b00;
						 MemRead = 1'b0;
						 MemWrite = 1'b1;
						 BrTaken = 1'b0;
						 UncondBr= 1'bx; 
					end

			  B_OP:
					begin
						 imm_sel = 2'b01;
						 RegWrite = 1'b0;
						 ALUSrc = 1'b0;
						 MemToReg = 1'b0;
						 ALUOp = 3'bxxx;
						 MemRead = 1'b0;
						 MemWrite = 1'b0;
						 BrTaken = 1'b1;
						 UncondBr= 1'b1;
					end
					
				CB_OP:
					begin
						 imm_sel = 2'b10;
						 RegWrite = 1'b0;
						 ALUSrc = 1'b0;
						 MemToReg = 1'b0;
						 ALUOp = 3'bxxx;
						 MemRead = 1'b0;
						 MemWrite = 1'b0;
						 BrTaken = 1'b1;
						 UncondBr= 1'b0;
					end
			  
			  default:
					begin
						 imm_sel = 2'bxx;
						 RegWrite = 1'b1;
						 ALUSrc = 1'b0;
						 MemToReg = 1'b0;
						 ALUOp = 2'b10;
						 MemRead = 1'b0;
						 MemWrite = 1'b0;
						 BrTaken = 1'b0;
						UncondBr= 1'bx; 
					end

		 endcase
	end

endmodule