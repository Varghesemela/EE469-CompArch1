// This serves as the instruction decoder module. 
// It takes in an Opcode and generates signals that are required for other blocks to compute output results. 
module control_unit(imm_sel, Reg2Loc, RegWrite, ALUSrc, ALUOp, , MemWrite, MemRead, MemToReg, UncondBr, BrTaken,
					 opcode, negative, overflow, zero_flag);
    
	input logic [10:0] opcode,
    output logic [1:0] imm_sel,
	
	output logic [2:0] ALUOp,
	
    output logic Reg2Loc, RegWrite, ALUSrc, MemToReg, MemRead, MemWrite, UncondBr, BrTaken

	input logic zero_flag, negative, overflow

	localparam [10:0]	ADD_OP 	= 	11'b10001011000,
						SUB_OP 	= 	11'b11001011000,
						LOAD_OP  = 	11'b11111000010,
						STORE_OP = 	11'b11111000000,
						B_OP   	=	11'b000101xxxxx, 
						CB_OP	=	11'b10110100xxx;
				  
	always_comb begin
		case(opcode)
			ADD_OP: begin
				Reg2Loc <= 1'b0;
				RegWrite <= 1'b1;
				imm_sel <= 2'bxx;
				ALUSrc <= 1'b0;
				ALUOp <= 2'b010;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				MemRead <= 1'b0;
				UncondBr <= 1'bx;
				BrTaken <= 1'b0;
				
			end
				
			SUB_OP: begin
				Reg2Loc <= 1'b0;
				imm_sel <= 2'bxx;
				RegWrite <= 1'b1;
				ALUSrc <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 2'b011;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				UncondBr <= 1'bx;
				BrTaken <= 1'b0; 
			end

			LOAD_OP: begin
				Reg2Loc <= 1'bx;
				imm_sel <= 2'b00;
				RegWrite <= 1'b1;
				ALUSrc <= 1'b1;
				MemToReg <= 1'b1;
				ALUOp <= 2'b00;
				MemWrite <= 1'b0;
				MemRead <= 1'b1;
				UncondBr <= 1'bx;
				BrTaken <= 1'b0;
			end

			STORE_OP: begin
				Reg2Loc <= 1'b1;
				imm_sel <= 2'b00;
				RegWrite <= 1'b0;
				ALUSrc <= 1'b1;
				MemToReg <= 1'bx;
				ALUOp <= 2'b00;
				MemWrite <= 1'b1;
				MemRead <= 1'b0;
				UncondBr <= 1'bx; 
				BrTaken <= 1'b0;
			end

			B_OP: begin
				Reg2Loc <= 1'b1;
				imm_sel <= 2'b01;
				RegWrite <= 1'b0;
				ALUSrc <= 1'b0;
				MemToReg <= 1'bx;
				ALUOp <= 3'bxxx;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				UncondBr <= 1'b1;
				BrTaken <= 1'b1;
			end
				
			CB_OP: begin
				Reg2Loc <= 1'b1;
				imm_sel <= 2'b10;
				RegWrite <= 1'b0;
				ALUSrc <= 1'b0;
				MemToReg <= 1'bx;
				ALUOp <= 3'bxxx;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				UncondBr <= 1'b0;
				if(zero_flag) begin
					BrTaken <= 1'b1;
				end
				else begin
					BrTaken <= 1'b0;
				end
			end
			  
			  default: begin
				imm_sel <= 2'bxx;
				RegWrite <= 1'b0;
				ALUSrc <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 2'b10;
				MemRead <= 1'b0;
				MemWrite <= 1'b0;
				BrTaken <= 1'b0;
				UncondBr <= 1'bx; 
			end
		endcase
	end

endmodule