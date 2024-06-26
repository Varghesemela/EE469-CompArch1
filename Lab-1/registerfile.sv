module registerfile (clk, RegWrite, WriteData, ReadRegister1, ReadRegister2, WriteRegister, ReadData1, ReadData2);

	input logic clk;
	input logic RegWrite;
    input logic [63:0] WriteData;	
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister; 
	output logic [63:0] ReadData1, ReadData2;
	 
	 logic [31:0] wr_reg_sel
	 logic [31:0] [63:0] regbank;
	
	decoder_5to32 sel_write_reg (
	.outputs(wr_reg_sel), .inputs(WriteRegister), .ena(RegWrite)
	)
	assign regbank[wr_reg_sel] = WriteData;
	assign regbank[31] = 64'b0;
	
	mux_64w32to1 mux_rm (.outputs(ReadData1), .registers(regbank[wr_reg_sel]), .selects(ReadRegister1))
	mux_64w32to1 mux_rn (.outputs(ReadData2), .registers(regbank[wr_reg_sel]), .selects(ReadRegister2))


endmodule