module MEMWBstage #(parameter datawidth = 32, parameter regindex = 5)(
input [datawidth - 1 : 0] DataMEM_in,
output [datawidth - 1 : 0] DataMEM_out,

input [datawidth - 1 : 0] DataALU_in,
output [datawidth - 1 : 0] DataALU_out,

input [regindex - 1 : 0] regdindex_in,
output [regindex - 1 : 0] regdindex_out,

input [1:0] WBsel_in,
output [1:0] WBsel_out,

input EX_MEM_Regwrite_in,
output EX_MEM_Regwrite_out
);
p_reg_32b DataMEM(.rst(rst),.en(en),.clk(clk),.data_in(DataMEM_in),.data_out(DataMEM_out));
p_reg_32b ALUdata(.rst(rst),.en(en),.clk(clk),.data_in(DataALU_in),.data_out(DataALU_out));
p_reg_5b regdindex(.rst(rst),.en(en),.clk(clk),.data_in(regdindex_in),.data_out(regdindex_out));
p_reg_2b WBsel(.rst(rst),.en(en),.clk(clk),.data_in(WBsel_in),.data_out(WBsel_out));
p_reg_1b REGWRITE(.rst(rst),.en(en),.clk(clk),.data_in(EX_MEM_Regwrite_in),.data_out(EX_MEM_Regwrite_out));
endmodule