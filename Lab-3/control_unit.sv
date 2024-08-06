`timescale 1ns/10ps
// This serves as the instruction decoder module. 
// It takes in an Opcode and generates signals that are required for other blocks to compute output results. 
module control_unit(Reg2Loc, RegWrite, ALUSrc, ALUOp, MemWrite, MemRead, MemToReg, UncondBr, BrTaken,
					 opcode, negative, overflow, zero, zeroCheck, flagset, imm_select, xfer_size);
	parameter DELAY = 0.05;
    
	input logic [10:0] opcode;
	output logic [2:0] ALUOp;
	
	
   output logic Reg2Loc, RegWrite, ALUSrc, MemToReg, MemRead, MemWrite, UncondBr, BrTaken, flagset, imm_select;

	input logic zero, zeroCheck, negative, overflow;
	output logic [3:0] xfer_size;
	
	logic BLTxorResult;
	xor #DELAY BLTxor (BLTxorResult, negative, overflow);

	localparam [10:0]	ADD_OP 	= 	11'b10001011000,
							ADDI_OP	=	11'b1001000100x,
							ADDS_OP 	= 	11'b10101011000,
							SUBS_OP	= 	11'b11101011000,
							SUB_OP 	= 	11'b11001011000,
							LOAD_OP  = 	11'b11111000010,
							STORE_OP = 	11'b11111000000,
							B_OP   	=	11'b000101xxxxx, 
							CBZ_OP	=	11'b10110100xxx,
							BLT_OP 	= 	11'b01010100xxx;
				  
	always_comb begin
		casex(opcode)
			ADD_OP: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b1;
				
				ALUSrc = 1'b0;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				MemRead = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				flagset = 1'b1;
				xfer_size = 4'bxxxx;
				
			end
			
			ADDI_OP: begin
				Reg2Loc = 1'b1;
				RegWrite = 1'b1;
				
				ALUSrc = 1'b1;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				MemRead = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				flagset = 1'b0;
				imm_select = 1'b1;
				xfer_size = 4'bxxxx;
			
			end
			
			ADDS_OP: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b1;
				ALUSrc = 1'b0;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				MemRead = 1'b0;
				flagset = 1'b1;
				imm_select = 1'b0;
				xfer_size = 4'bxxxx;
			end
				
			SUBS_OP: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b1;
				ALUSrc = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 3'b011;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				flagset = 1'b1;
				imm_select = 1'b0;
				xfer_size = 4'bxxxx;
			end
				
			SUB_OP: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b1;
				ALUSrc = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 3'b011;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				flagset = 1'b1;
				imm_select = 1'b0;
				xfer_size = 4'bxxxx;	
			end

			LOAD_OP: begin
				Reg2Loc = 1'bx;
				
				RegWrite = 1'b1;
				ALUSrc = 1'b1;
				MemToReg = 1'b1;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemRead = 1'b1;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				flagset = 1'b0;
				imm_select = 1'b0;
				xfer_size = 4'b1000;
			end

			STORE_OP: begin
				Reg2Loc = 1'b1;
				
				RegWrite = 1'b0;
				ALUSrc = 1'b1;
				MemToReg = 1'bx;
				ALUOp = 3'b010;
				MemWrite = 1'b1;
				MemRead = 1'b0;
				UncondBr = 1'bx; 
				BrTaken = 1'b0;
				flagset = 1'b0;
				imm_select = 1'b0;
				xfer_size = 4'b1000;
			end

			B_OP: begin
				Reg2Loc = 1'b1;
				
				RegWrite = 1'b0;
				ALUSrc = 1'b0;
				MemToReg = 1'bx;
				ALUOp = 3'bxxx;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				UncondBr = 1'b1;
				BrTaken = 1'b1;
				flagset = 1'b0;
				imm_select = 1'b0;
				xfer_size = 4'bxxxx;
			end
				
			CBZ_OP: begin
				Reg2Loc = 1'b1;
				RegWrite = 1'b0;
				ALUSrc = 1'b0;
				MemToReg = 1'bx;
				ALUOp = 3'b000;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				UncondBr = 1'b0;
				BrTaken = zeroCheck;
				flagset = 1'b0;
				imm_select = 1'b0;
				xfer_size = 4'bxxxx;
			end
			
			BLT_OP: begin
				Reg2Loc = 1'bx;
				RegWrite = 1'b0;
				ALUSrc = 1'b0;
				MemToReg = 1'bx;
				ALUOp = 3'bxxx;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				UncondBr = 1'b0;
				BrTaken = BLTxorResult;
				flagset = 1'b0;
				xfer_size = 4'bxxxx;
				end
			  
			default: begin
				
				RegWrite = 1'b0;
				ALUSrc = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 3'b010;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				BrTaken = 1'b0;
				UncondBr = 1'bx;
				flagset = 1'b0;	
			end
		endcase
	end

endmodule