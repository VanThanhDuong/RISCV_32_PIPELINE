module mux2_control(input muxsel,
input zero,
input [1:0] Wbsel_in,
output reg [1:0] Wbsel_out,

input MemRw_in,
output reg MemRw_out,

input  [3:0] ALUsel_in,
output reg [3:0]  ALUsel_out,

 input Asel_in,
output reg Asel_out,

input Bsel_in,
output reg Bsel_out,

input [2:0] Rsel_in,
output reg [2:0] Rsel_out,

input [1:0] Wsel_in,
output reg [1:0] Wsel_out,

input [3:0] immsel_in,
output reg [3:0] immsel_out,

input IF_ID_Regwrite_in,
output reg IF_ID_Regwrite_out);
always @(muxsel)
case(muxsel)
1'b0: 
begin
assign Wbsel_out = zero;
assign MemRw_out = zero;
assign ALUsel_out = zero;
assign Asel_out = zero;
assign Bsel_out =zero;
assign Rsel_out = zero;
assign Wsel_out = zero;
assign immsel_out = zero;
assign IF_ID_Regwrite_out = zero;
end
1'b1:
begin
assign Wbsel_out = Wbsel_in;
assign MemRw_out = MemRw_in;
assign ALUsel_out =ALUsel_in;
assign Asel_out = Asel_in;
assign Bsel_out = Bsel_in;
assign Rsel_out = Rsel_in;
assign Wsel_out = Wsel_in;
assign immsel_out = immsel_in;
assign IF_ID_Regwrite_out =IF_ID_Regwrite_in;
end
endcase
endmodule
