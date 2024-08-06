`timescale 1ns/10ps
module datapath_unit (Reg2Loc, RegWrite, ALUSrc, ALUOp, MemWrite, MemToReg, MemRead, instruction,
					 xfer_size, clk, reset, overflow, negative, zero, zeroCheck, carry_out, flagset, imm_select,
					 link_register, branch_register);
	input logic [31:0] instruction;
	input logic Reg2Loc, RegWrite, MemWrite, MemToReg, MemRead, flagset, imm_select;
	input logic clk, reset;
	input logic ALUSrc;
	input logic [2:0] ALUOp;
	input logic [3:0] xfer_size;
	input logic [63:0] link_register;
	output logic [63:0] branch_register;
	output logic overflow, negative, zero, carry_out, zeroCheck;
	
	logic [4:0] Rm_or_Rd;
	// RegToLoc Mux
	mux_5w2to1 RegToLocMux (.A(instruction[20:16]), .B(instruction[4:0]), .sel(Reg2Loc), .out(Rm_or_Rd));
	
	logic [63:0] Dw, Da, Db;
	registerfile register_bank (.ReadData1(Da), .ReadData2(Db), 
                            .ReadRegister1(instruction[9:5]), .ReadRegister2(Rm_or_Rd), 
                            .WriteRegister(instruction[4:0]), .WriteData(Dw), .link_register, 
                            .RegWrite, .clk(clk), .reset(reset));
	
	// MOV Logic
	logic [1:0] shamt;
	assign shamt = instruction[22:21];
	
	
		
	// Sign extend for DAddr9
	logic [63:0] DAddr9_extended;
	signExtend #(.WIDTH(9)) DAddr9(.in(instruction[20:12]), .out(DAddr9_extended));
	// Zero extend for Imm12
	logic [63:0] Imm12Extended;
	zeroExtend #(.WIDTH(12)) Imm12(.in(instruction[21:10]), .out(Imm12Extended));
	
	logic [63:0] Imm_value;
	mux2_64b imm_select_mux (.out(Imm_value), .A(DAddr9_extended), .B(Imm12Extended), .sel(imm_select));
	
	// ALUSrc MUX
	logic [63:0] alub_input;
	mux2_64b Alu_src_mux (.out(alub_input), .A(Db), .B(Imm_value), .sel(ALUSrc));
	
	// Put information into ALU
	logic [63:0] ALUOut;
	logic negativeFlag, zeroFlag, overflowFlag, carryOutFlag;
	ALU_64b theALU (.A(Da), .B(alub_input), .cntrl(ALUOp), .result(ALUOut), .negative(negativeFlag), .zero(zeroFlag), .overflow(overflowFlag), .carry_out(carryOutFlag));
	
	assign branch_register = ALUOut;
	assign zeroCheck = zeroFlag;
	
	eDFF forZero (.q(zero), .d(zeroFlag), .en(flagset), .clk, .reset);
	eDFF forNegative (.q(negative), .d(negativeFlag), .en(flagset), .clk, .reset);
	eDFF forCarryout (.q(carry_out), .d(carryOutFlag), .en(flagset), .clk, .reset);
	eDFF forOverflow (.q(overflow), .d(overflowFlag), .en(flagset), .clk, .reset);
	
	logic [63:0] memoryOut;
	datamem theDataMem (.address(ALUOut), .write_enable(MemWrite), .read_enable(MemRead), .write_data(Db), .clk, .xfer_size, .read_data(memoryOut));	
	
	// MemToReg Mux
	mux2_64b theMemToRegMux (.A(ALUOut), .B(memoryOut), .sel(MemToReg), .out(Dw));
	
endmodule
	

module datapath_testbench();
	logic [31:0] instruction;
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, MemRead, flagset, imm_select, clk, reset;
	logic ALUSrc;
	logic [2:0] ALUOp;
	logic	[3:0]	xfer_size;
	assign xfer_size = 4'b1000;
	logic overflow, negative, zero, zeroCheck, carry_out;
	
	logic BrTaken, UncondBr;
	
	control_unit controlUnit(.Reg2Loc, .RegWrite, .ALUSrc, .ALUOp, .MemWrite, .MemRead(MemRead), .MemToReg, .UncondBr, .BrTaken,
					 .opcode(instruction[31:21]), .negative, .overflow, .zero_flag(zero), .flagset, .imm_select);
	
	datapath dut(.Reg2Loc, .RegWrite, .ALUSrc, .ALUOp, .MemWrite, .MemToReg, .MemRead, .instruction,
					 .xfer_size, .clk, .reset, .overflow, .negative, .zero, .zeroCheck, .carry_out, .flagset, .imm_select);								
								
	parameter CLOCK_PERIOD= 1000;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	reset = 1'b1;             @(posedge clk);
   reset = 1'b0;             @(posedge clk);
	
	instruction = 32'b1001000100_000000000111_11111_00000; @(posedge clk); 
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	$stop;
	end
endmodule