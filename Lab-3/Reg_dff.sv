`timescale 1ns/10ps
 
module Reg_dff #(parameter W1=64) (data_out, data_in, clk, reset, WriteEnable); 
 output logic [W1-1:0] data_out; 
 input logic [W1-1:0] data_in; 
input logic clk, reset, WriteEnable;                              


initial assert(W1>0); 
 genvar i; 
 generate
                                                                               
  for(i=0; i<W1; i++) begin : eachDff 
    D_FF den (.q(data_out[i]), .d(data_in[i]), .clk(clk), .reset(reset), .en(WriteEnable)); 
 
 end
  
 endgenerate 
endmodule 

module Reg_dff_testbench;
	logic [63:0] data_in;
	logic WriteEnable, reset, clk;
	logic [63:0] data_out;
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	initial begin
		@(posedge clk);
		reset <= 1;
		WriteEnable <= 0;
		data_in <= 253;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		WriteEnable <= 1;
		@(posedge clk);
		@(posedge clk);
		data_in <= 55632;
		@(posedge clk);
		@(posedge clk);
		WriteEnable <= 0;
		@(posedge clk);
		data_in <= 54362;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
	Reg_dff dut (.data_out, .data_in, .clk, .reset, .WriteEnable);
endmodule