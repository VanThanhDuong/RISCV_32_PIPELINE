module mux1(pc, rs1,ASel,outmux1);
parameter	WIDTH_DATA_LENGTH=32;
output		[WIDTH_DATA_LENGTH-1:0]outmux1;
input		[WIDTH_DATA_LENGTH-1:0]pc, rs1;
input		ASel;
assign		outmux1=(ASel==1'b0)? rs1: pc;
endmodule

