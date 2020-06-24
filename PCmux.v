//version 1.1 last edit 11:15PM 4/6/2020
/*
PCmux module

PCSel: tin hieu tu control dieu khien bo mux.
pc_plus4: tin hieu 32 bits tu PCPLUS4.
alu: tin hieu 32 bits tu alu.
pc_in: ngo ra 32 bits cua bo mux.

muc dich: dua vao tin hieu PCSel neu:
	+ PCSel = 0 thi pc_in = pc_plus4.
	+ PCSel = 1 thi pc_in = alu.
*/
module PCmux(pc_in, PCSel, pc_plus4, alu);
input PCSel;
input [31:0] pc_plus4, alu;
output wire [31:0] pc_in;

assign pc_in = PCSel?alu:pc_plus4;

endmodule