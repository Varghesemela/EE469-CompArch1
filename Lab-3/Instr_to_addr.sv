`timescale 1ns/10ps
module Instr_to_addr (clk, reset, BrTaken, UncondBr, instruction, blink_sig, link_register, breg_sig, branch_register);
	parameter ClockDelay = 5000;
	input logic clk, reset, BrTaken, UncondBr, blink_sig;
	output logic [31:0] instruction;
	output logic [63:0] link_register;
	input logic breg_sig;
	input logic [63:0] branch_register;
	logic [63:0] currentPC;
	
	// Instruction Fetch code 
	instructmem inst_fetch (.address(currentPC), .instruction(instruction), .clk(clk));
	
	logic [63:0] BrAddr26_extended;
	signExtend #(.WIDTH(25-0+1)) BrAddr26(.in(instruction[25:0]), .out(BrAddr26_extended));
	

	logic [63:0] CondAddr19_extended;	
	signExtend #(.WIDTH(23-5+1)) CondAddr19(.in(instruction[23:5]), .out(CondAddr19_extended));
	
	
	logic [63:0] sign_extended_branchaddr;
	mux2_64b mem_to_reg_mux (.out(sign_extended_branchaddr), .A(CondAddr19_extended), .B(BrAddr26_extended), .sel(UncondBr)); 
	
	logic [63:0] shifted_address;
	shift_left_2 lsl1(.in(sign_extended_branchaddr), .out(shifted_address));
	
	logic [63:0] pc_plus_branch;
	pc_adder pc_adder2 (.A(currentPC), .B(shifted_address), .sum(pc_plus_branch));
	
	//adder if increment by 4 or jump
	logic [63:0]pc_plus4;
	pc_adder pc_adder1 (.A(currentPC), .B(64'd04), .sum(pc_plus4));
	
	//store pc_plus4 value in link register
	mux2_64b Alu_src_mux (.out(link_register), .A(link_register), .B(pc_plus4), .sel(blink_sig));

	
	logic [63:0] pc_branch_address;
	mux2_64b mux_branch (.out(pc_branch_address), .A(pc_plus4), .B(pc_plus_branch), .sel(BrTaken));
	
	logic [63:0] pc_input_address;
	mux2_64b mux_if (.out(pc_input_address), .A(pc_branch_address), .B(branch_register), .sel(breg_sig));
	
	
	pc storePC (.clk(clk), .reset(reset), .pc_in(pc_input_address), .pc_out(currentPC));
	
	
endmodule

module Instr_to_addr_testbench();
	logic clk, reset, BrTaken, UncondBr;
	logic [31:0] instruction;
	
	Instr_to_addr dut(.instruction, .UncondBr, .BrTaken, .clk, .reset);

	parameter CLOCK_PERIOD= 5000;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	always_comb begin
		if(instruction[31:26] == 6'b000101) begin
			UncondBr = 1'b1;
			BrTaken = 1'b1;
		end
		else begin
			UncondBr = 1'b0;
			BrTaken = 1'b0;
		end
	end
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		for(i = 0; i < 15; i++) begin
			@(posedge clk);
		end
		$stop;
	end
endmodule