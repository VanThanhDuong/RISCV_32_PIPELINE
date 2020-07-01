module ImmOrMUX42(input muxsel,
	input [31:0]MUX42_out,
	input [31:0]ID_EX_Imm,
	output [31:0]Out);
assign Out = muxsel ? ID_EX_Imm : MUX42_out;
endmodule