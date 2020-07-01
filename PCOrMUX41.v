module PCorMUX41(
	input muxsel,
	input [31:0]MUX41,
	input [31:0]PC,
	output [31:0]Out);
assign Out = (muxsel == 1) ? PC : MUX41;
endmodule