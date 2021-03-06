module IDEXstage #(parameter datawidth = 32,parameter regindex = 5)( input clk,input rst, input en,
input [regindex - 1 : 0] IFIDreg1_in,
output [regindex - 1 : 0] IFIDreg1_out,
input [regindex - 1 : 0] IFIDreg2_in,
output [regindex - 1 : 0] IFIDreg2_out,
input [regindex - 1 : 0] IFIDregd_in,
output [regindex - 1 : 0] IFIDregd_out,
input [datawidth - 1 : 0] datareg1_in,
output [datawidth - 1 : 0] datareg1_out,
input [datawidth - 1 : 0] datareg2_in,
output [datawidth - 1 : 0] datareg2_out,
input [datawidth - 1 : 0] pcx_in,
output [datawidth - 1 : 0] pcx_out,
//control signal
input [1:0] Wbsel_in,
output [1:0] Wbsel_out,

input MemRw_in,
output MemRw_out,

input  [3:0] ALUsel_in,
output [3:0] ALUsel_out,

 input Asel_in,
output Asel_out,

input Bsel_in,
output Bsel_out,

input [2:0] Rsel_in,
output [2:0] Rsel_out,

input [1:0] Wsel_in,
output [1:0] Wsel_out,

input [31:0] imm_in,
output [31:0] imm_out,

input IF_ID_Regwrite_in,
output IF_ID_Regwrite_out,
input [4:0] IF_ID_Opcode,
output [4:0] ID_EX_Opcode
);
p_reg_5b IFIDreg1(.rst(rst),.en(en),.clk(clk),.data_in(IFIDreg1_in),.data_out(IFIDreg1_out));
p_reg_5b IFIDreg2(.rst(rst),.en(en),.clk(clk),.data_in(IFIDreg2_in),.data_out(IFIDreg2_out));
p_reg_5b IFIDregd(.rst(rst),.en(en),.clk(clk),.data_in(IFIDregd_in),.data_out(IFIDregd_out));
p_reg_32b datareg1(.rst(rst),.en(en),.clk(clk),.data_in(datareg1_in),.data_out(datareg1_out));
p_reg_32b datareg2(.rst(rst),.en(en),.clk(clk),.data_in(datareg2_in),.data_out(datareg2_out));
p_reg_32b pcd(.rst(rst),.en(en),.clk(clk),.data_in(pcx_in),.data_out(pcx_out));
p_reg_2b Wbsel(.rst(rst),.en(en),.clk(clk),.data_in(Wbsel_in),.data_out(Wbsel_out));
p_reg_1b MemRw1(.rst(rst),.en(en),.clk(clk),.data_in(MemRw_in),.data_out(MemRw_out));
p_reg_4b ALUsel1(.rst(rst),.en(en),.clk(clk),.data_in(ALUsel_in),.data_out(ALUsel_out));
p_reg_1b Asel(.rst(rst),.en(en),.clk(clk),.data_in(Asel_in),.data_out(Asel_out));
p_reg_1b Bsel(.rst(rst),.en(en),.clk(clk),.data_in(Bsel_in),.data_out(Bsel_out));
p_reg_3b Rsel(.rst(rst),.en(en),.clk(clk),.data_in(Rsel_in),.data_out(Rsel_out));
p_reg_2b Wsel(.rst(rst),.en(en),.clk(clk),.data_in(Wsel_in),.data_out(Wsel_out));
p_reg_32b IF_ID_imm(.rst(rst),.en(en),.clk(clk),.data_in(imm_in),.data_out(imm_out));
p_reg_1b immsel124(.rst(rst),.en(en),.clk(clk),.data_in(IF_ID_Regwrite_in),.data_out(IF_ID_Regwrite_out));
p_reg_5b ID_EX_Opcode11(.rst(rst),.en(en),.clk(clk),.data_in(IF_ID_Opcode),.data_out(ID_EX_Opcode));
endmodule

