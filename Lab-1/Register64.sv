`include "dff.sv"


module Register64 (
    input logic clk,
    input logic reset,
	 input write_en, 
    input logic [63:0] D,     // 64-bit data input
    output logic [63:0] Q     // 64-bit data output
);
    // Array of 64 D flip-flops
    D_FF dff_array [63:0] (
        .q(Q),
        .d(D),
        .reset(reset),
        .clk(clk)
		  .en(write_en)
    );

endmodule