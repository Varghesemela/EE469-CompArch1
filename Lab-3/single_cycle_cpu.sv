`timescale 1ns/10ps
module single_cycle_cpu(clk, reset);
input logic clk, reset;
logic [31:0] instruction;
logic [2:0] ALUOp;
logic Reg2Loc, RegWrite, ALUSrc, MemToReg, MemRead, MemWrite, UncondBr, BrTaken, flagset, imm_select, blink_sig, breg_sig;
logic zero, zeroCheck, negative, overflow, carry_out;
logic	[3:0]	xfer_size;
logic [63:0] link_register, branch_register;

// Instruction Fetch code 
Instr_to_addr  fetchInstruction(.clk, .reset, .BrTaken, .UncondBr, .instruction, .blink_sig, .link_register, .breg_sig, .branch_register);

control_unit controlUnit(.Reg2Loc, .RegWrite, .ALUSrc, .ALUOp, .MemWrite, .MemRead, .MemToReg, .UncondBr, .BrTaken,
					 .opcode(instruction[31:21]), .negative, .overflow, .zero, .zeroCheck, .flagset,
					 .imm_select, .xfer_size, .blink_sig, .breg_sig);
	
datapath_unit datapathUnit(.Reg2Loc, .RegWrite, .ALUSrc, .ALUOp, .MemWrite, .MemToReg, .MemRead, .instruction,
					 .xfer_size, .clk, .reset, .overflow, .negative, .zero, .zeroCheck, .carry_out,
					 .flagset, .imm_select, .link_register, .branch_register);

endmodule


module single_cycle_cpu_testbench(); 		
	logic clk, reset;
	single_cycle_cpu cpu(.clk, .reset);
	
	parameter CLOCK_PERIOD=500;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	int i;
	
   initial begin
	
	reset = 1; @(posedge clk);
	   reset = 0; @(posedge clk);
		           @(posedge clk);
		for (i=0; i<100; i++) begin
			@(posedge clk);
		end
		$stop;
	end
endmodule
