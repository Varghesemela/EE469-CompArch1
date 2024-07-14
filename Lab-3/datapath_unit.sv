`timescale 1ns/10ps
module datapath (Reg2Loc, RegWrite, ALUSrc, ALUOp, MemWrite, MemToReg, MemRead, instruction,
					xfer_size, clk, reset, overflow, negative, zero, carry_out);
                    imm_sel, Reg2Loc, RegWrite, ALUSrc, ALUOp, , MemWrite, MemRead, MemToReg, UncondBr, BrTaken,
					 opcode, negative, overflow, zero_flag
	input logic [31:0] instruction;
	input logic Reg2Loc, RegWrite, MemWrite, MemToReg, MemRead, NOOP, clk, reset, LDURB, MOVZnotMOVK;
	input logic [1:0] ALUSrc;
	input logic [2:0] ALUOp;
	input logic [3:0] xfer_size;
    input logic [1:0] imm_sel;
	output logic overflow, negative, zero, carry_out;
	parameter DELAY = 0.05;
	
	
	logic [4:0] Rm_or_Rd;
	// RegToLoc Mux
	mux_5w2to1 RegToLocMux (.A(instruction[4:0]), .B(instruction[20:16]), .sel(Reg2Loc), .out(Rm_or_Rd));
	
	logic [63:0] Dw, Da, Db;
	registerfile register_bank (.ReadData1(Da), .ReadData2(Db), 
                            .ReadRegister1(instruction[9:5]), .ReadRegister2(Rm_or_Rd), 
                            .WriteRegister(instruction[4:0]), .WriteData(Dw), 
                            .RegWrite(RegWrite), .clk(clk), .reset(0));
	
    imm_conversion (.instruction(instruction), .imm_sel(imm_sel), imm_out)

	
endmodule
