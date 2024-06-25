module registerfile (clk, RegWrite, WriteData, ReadRegister1, ReadRegister2, WriteRegister, ReadData1, ReadData2);

	input logic clk;
	input logic RegWrite;
    input logic [63:0] WriteData;	
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister; 
	output logic [63:0] ReadData1, ReadData2;


endmodule