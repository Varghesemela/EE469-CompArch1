module regfile (Read_reg1, Read_reg2, WriteReg, WriteData, RegWrite, Read_data1, Read_data2, clk);
 
  input logic [4:0] Read_reg1, Read_reg2, WriteReg;
  input logic [63:0] WriteData;
  input logic RegWrite, clk;
  output logic [63:0] Read_data1, Read_data2;
  logic [63:0][31:0] muxin;     // input to mux
  logic [31:0][63:0] dataout;  //output of reg
  logic [31:0] WriteEnable;                          //decoder output

 
decoder_5to32 d1 (.outputs(WriteEnable), .inputs(WriteReg), .ena(RegWrite));
integer j, k;
	always_comb begin
		for(j = 0; j < 64; j++)
			for(k = 0; k < 32; k++)
				muxin[j][k] = dataout[k][j];
	end

genvar i;
generate
                                                                
  for(i=0; i<31; i++) begin : eachD
    Reg_dff reg1 (.data_out(dataout[i][63:0]), .data_in(WriteData[63:0]), .clk(clk),.reset(reset), .WriteEnable(WriteEnable[i])); 
  end
 endgenerate

   Reg_dff reg31 (.data_out(dataout[31][63:0]), .data_in(64'b0), .clk(clk), .reset(1'b0), .WriteEnable(1'b1));

generate
 for (i=0; i<64;i++) begin: mux1eachbit
   
   mux_32to1  data1(.out(Read_data1[i]), .inputs(muxin[i][31:0]),  .selects(Read_reg1[4:0]));
 end
endgenerate
generate
 for (i=0; i<64;i++) begin: mux2eachbit
   
	mux_32to1  data2(.out(Read_data2[i]), .inputs(muxin[i][31:0]),  .selects(Read_reg2[4:0]));
 end
endgenerate

 
 
endmodule

// Test bench for Register file
`timescale 1ns/10ps

module regstim(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.Read_reg1(ReadRegister1), .Read_reg2(ReadRegister2), .WriteReg(WriteRegister), .WriteData(WriteData), .RegWrite(RegWrite), 
	.Read_data1(ReadData1), .Read_data2(ReadData2), .clk(clk));

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule
