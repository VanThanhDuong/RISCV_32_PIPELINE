module control(addr, PCSel, ImmSel, RegWEn, BrUn, BrEq, BrLT, BSel, ASel, ALUSel, MemRW, WBSel,Rsel,Wsel);
parameter datawidth=20;
parameter addrwidth=9;
reg [19:0]data1;
input		[addrwidth-1:0]addr;
input BrEq, BrLT;
output [2:0] ImmSel;
output [1:0] WBSel;
output [3:0] ALUSel;
output [2:0] Rsel;
output [1:0] Wsel;
output PCSel, RegWEn, BrUn, BSel, ASel, MemRW ;

reg [2:0] ImmSel1;
reg [1:0] WBSel1;
reg [3:0] ALUSel1;
reg [2:0] Rsel1;
reg [1:0] Wsel1;
reg PCSel1, RegWEn1, BrUn1, BSel1, ASel1, MemRW1 ;
initial
begin 
	PCSel1 = 1'b0;
end
always@(addr or BrEq or BrLT)
begin
	casex(addr)
	// R type
		9'b0_000_01100 : data1=20'b0_000_1_0_0_0_0000_0_00_000_01;
		9'b1_000_01100 : data1=20'b0_000_1_0_0_0_0001_0_00_000_01;
		9'b0_001_01100 : data1=20'b0_000_1_0_0_0_0010_0_00_000_01;
		9'b0_010_01100 : data1=20'b0_000_1_0_0_0_0011_0_00_000_01;
		9'b0_011_01100 : data1=20'b0_000_1_0_0_0_0100_0_00_000_01;
		9'b0_100_01100 : data1=20'b0_000_1_0_0_0_0101_0_00_000_01;
		9'b0_101_01100 : data1=20'b0_000_1_0_0_0_0110_0_00_000_01;
		9'b1_101_01100 : data1=20'b0_000_1_0_0_0_0111_0_00_000_01;
		9'b0_110_01100:  data1=20'b0_000_1_0_0_0_1000_0_00_000_01;
		9'b0_111_01100 : data1=20'b0_000_1_0_0_0_1001_0_00_000_01;
	// I type
		9'bx_000_00100: data1=20'b0_000_1_0_0_1_0000_0_00_000_01;
		9'bx_010_00100: data1=20'b0_000_1_0_0_1_0011_0_00_000_01;
		9'bx_011_00100: data1=20'b0_000_1_0_0_1_0100_0_00_000_01;
		9'bx_100_00100: data1=20'b0_000_1_0_0_1_0101_0_00_000_01;
		9'bx_110_00100: data1=20'b0_000_1_0_0_1_1000_0_00_000_01;
		9'bx_111_00100: data1=20'b0_000_1_0_0_1_1001_0_00_000_01;
		9'b0_001_00100: data1=20'b0_000_1_0_0_1_0010_0_00_000_01;
		9'b0_101_00100: data1=20'b0_000_1_0_0_1_0110_0_00_000_01;
		9'b1_101_00100: data1=20'b0_000_1_0_0_1_0111_0_00_000_01;

		9'bx_000_00000: data1=20'b0_000_1_0_0_1_0000_0_00_000_00;
		9'bx_001_00000: data1=20'b0_000_1_0_0_1_0000_0_00_001_00;
		9'bx_010_00000: data1=20'b0_000_1_0_0_1_0000_0_00_010_00;
		9'bx_100_00000: data1=20'b0_000_1_0_0_1_0000_0_00_100_00;
		9'bx_101_00000: data1=20'b0_000_1_0_0_1_0000_0_00_101_00;
	// S type
		9'bx_000_01000: data1=20'b0_001_0_0_0_1_0000_1_00_000_00;
		9'bx_001_01000: data1=20'b0_001_0_0_0_1_0000_1_01_000_00;
		9'bx_010_01000: data1=20'b0_001_0_0_0_1_0000_1_10_000_00;
	// B type
		9'bx_000_11000:begin
		case(BrEq) 
		1'b0:  data1 = 20'b0_010_0_1_1_1_0000_0_00_000_00;
		1'b1:  data1 = 20'b1_010_0_1_1_1_0000_0_00_000_00; 
		endcase
		end
		//data1 <= {{BrEq},19'b010_0_1_1_1_0000_0_00_000_00};
		9'bx_001_11000: data1 = BrEq ? 20'b0_010_0_1_1_1_0000_0_00_000_00 : 20'b1_010_0_1_1_1_0000_0_00_000_00;
		9'bx_100_11000: data1 = BrLT ? 20'b1_010_0_1_1_1_0000_0_00_000_00 : 20'b0_010_0_1_1_1_0000_0_00_000_00;
		9'bx_101_11000: data1 = (BrLT == 0) ?20'b1_010_0_1_1_1_0000_0_00_000_00 : 20'b0_010_0_1_1_1_0000_0_00_000_00;
		9'bx_110_11000: data1 = BrLT ? 20'b1_010_0_0_1_1_0000_0_00_000_00 : 20'b0_010_0_0_1_1_0000_0_00_000_00;
		9'bx_111_11000: data1 = (BrLT == 0) ? 20'b1_010_0_0_1_1_0000_0_00_000_00 : 20'b0_010_0_0_1_1_0000_0_00_000_00 ;
	// U type
		9'bx_xxx_01101: data1=20'b0_011_1_0_0_1_1010_0_00_000_01;
		9'bx_xxx_00101: data1=20'b0_011_1_0_1_1_0000_0_00_000_01;

	// J type
		9'bx_xxx_11011 : data1 = 20'b1_100_1_0_1_1_0000_0_00_000_10;
		9'bx_000_11001: data1 = 20'b1_100_1_0_0_1_0000_0_00_000_10;
endcase
{PCSel1, ImmSel1, RegWEn1, BrUn1, ASel1, BSel1, ALUSel1, MemRW1, Wsel1,Rsel1,WBSel1} <= data1;
end
assign {PCSel, ImmSel, RegWEn, BrUn, ASel, BSel, ALUSel, MemRW, Wsel,Rsel,WBSel} = {PCSel1, ImmSel1, RegWEn1, BrUn1, ASel1, BSel1, ALUSel1, MemRW1, Wsel1,Rsel1,WBSel1};
endmodule
