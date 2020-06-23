module EXMEMstage #(parameter datawidth = 32, parameter regindex = 5)(input rst,input clk,input en,
input [datawidth - 1 : 0] ALU_in,
output [datawidth - 1 : 0] ALU_out,

input [datawidth - 1 : 0] pcm_in,
output [datawidth - 1 : 0] pcm_out,

input [datawidth - 1 : 0] datareg_in,
output [datawidth - 1 : 0] datareg_out,

input [regindex - 1 : 0] regdindex_in,
output [regindex - 1 : 0] regdindex_out,

input [1:0] WBsel_in,
output [1:0] WBsel_out,

input MEMRw_in,
output MEMRw_out,

input [2:0] Rsel_in,
output [2:0] Rsel_out,

input [1:0] Wsel_in,
output [1:0] Wsel_out,

input ID_EX_Regwrite_in,
output ID_EX_Regwrite_out
);
p_reg_32b ALUdata(.rst(rst),.en(en),.clk(clk),.data_in(ALU_in),.data_out(ALU_out));
p_reg_32b pcm(.rst(rst),.en(en),.clk(clk),.data_in(pcm_in),.data_out(pcm_out));
p_reg_32b datareg(.rst(rst),.en(en),.clk(clk),.data_in(datareg_in),.data_out(datareg_out));
p_reg_5b regindex(.rst(rst),.en(en),.clk(clk),.data_in(regdindex_in),.data_out(regdindex_out));
p_reg_2b WBsel(.rst(rst),.en(en),.clk(clk),.data_in(WBsel_in),.data_out(WBsel_out));
p_reg_1b MEMRw(.rst(rst),.en(en),.clk(clk),.data_in(MEMRw_in),.data_out(MEMRw_out));
p_reg_3b Rsel(.rst(rst),.en(en),.clk(clk),.data_in(Rsel_in),.data_out(Rsel_out));
p_reg_2b Wsel(.rst(rst),.en(en),.clk(clk),.data_in(Wsel_in),.data_out(Wsel_out));
p_reg_1b RegWrite(.rst(rst),.en(en),.clk(clk),.data_in(ID_EX_Regwrite_in),.data_out(ID_EX_Regwrite_out));
endmodule