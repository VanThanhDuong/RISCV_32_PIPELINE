module immgen(inst,immsel,imm);
parameter WID_DATA=32;
input [WID_DATA-1:0] inst;
input [2:0] immsel;
output reg [WID_DATA-1:0] imm;

always@(inst or immsel)
begin
	case(immsel)
	3'b000:imm ={{20{inst[WID_DATA-1]}},inst[WID_DATA-1:WID_DATA-12]};
	3'b001: imm ={{20{inst[WID_DATA-1]}},inst[WID_DATA-1:WID_DATA-7],inst[WID_DATA-21:WID_DATA-25]};
	3'b010: imm = {{19{inst[WID_DATA - 1]}},inst[WID_DATA-1],inst[WID_DATA-25],inst[WID_DATA-2:WID_DATA-7],inst[WID_DATA-21:WID_DATA-24],1'b0}; 
	3'b011: imm = {inst[WID_DATA-1:WID_DATA-20],12'b0};
	3'b100:
	begin
		if(inst[3])
		begin
			if(inst[WID_DATA-1]) imm = {11'b1111_1111_111,inst[WID_DATA-1],inst[WID_DATA-13:WID_DATA-20],inst[WID_DATA-12],inst[WID_DATA-2:WID_DATA-11],1'b0};
			else imm = {11'b0000_0000_000,inst[WID_DATA-1],inst[WID_DATA-13:WID_DATA-20],inst[WID_DATA-12],inst[WID_DATA-2:WID_DATA-11],1'b0};
		end
		else
		begin
			if(inst[WID_DATA-1]) imm = {20'b11111111111111111111,inst[WID_DATA-1:WID_DATA-12]};
			else imm = {20'b00000000000000000000,inst[WID_DATA-1:WID_DATA-12]};
		end
	end	
	endcase
end
endmodule
