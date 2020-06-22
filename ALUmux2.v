module mux2(imm, rs2,BSel,outmux2);
parameter	WIDTH_DATA_LENGTH=32;
output		[WIDTH_DATA_LENGTH-1:0]outmux2;
input		[WIDTH_DATA_LENGTH-1:0]imm, rs2;
input		BSel;
assign		outmux2=(BSel==1'b0)? rs2: imm;
endmodule

