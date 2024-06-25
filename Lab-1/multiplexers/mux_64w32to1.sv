module mux_64w32to1(outputs, i31, i30, i29, i28, i27, i26, i25, i24, i23, i22, i21, i20, i19, i18, i17, i16,
						  i15, i14, i13, i12, i11, i10, i9, i8, i7, i6, i5, i4, i3, i2, i1, i0, selects);
		
		output logic [63:0] outputs;
		input logic [63:0] i31, i30, i29, i28, i27, i26, i25, i24, i23, i22, i21, i20, i19, i18, i17, i16,
								 i15, i14, i13, i12, i11, i10, i9, i8, i7, i6, i5, i4, i3, i2, i1, i0;
		input logic [4:0] selects;
		
		
		genvar i;
		generate
			for(i = 0; i < 64; i++) begin: findOut
				mux_32to1 findResult (.out(outputs[i]), .i({ i31[i], i30[i], i29[i], i28[i], i27[i], i26[i], i25[i], i24[i], i23[i], i22[i], i21[i], i20[i],
													i19[i], i18[i], i17[i], i16[i], i15[i], i14[i], i13[i], i12[i], i11[i], i10[i], i9[i], i8[i],
													i7[i], i6[i], i5[i], i4[i], i3[i], i2[i], i1[i], i0[i] }), .selects(selects));
			end		
		endgenerate
					  
endmodule