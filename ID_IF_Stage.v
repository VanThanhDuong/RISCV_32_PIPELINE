module IDIFstage(input rst,input en,input clk,input instd_in,input pcd_in,output pcd_out,output instd_out);
parameter datawidth = 32;
input [datawidth - 1:0] instd_in, pcd_in;
output [datawidth - 1:0] instd_out,pcd_out;
p_reg_32b p_regpcd(.rst(rst),.en(en),.clk(clk),.data_in(pcd_in),.data_out(pcd_out));
p_reg_32b p_reginstd(.rst(rst),.en(en),.clk(clk),.data_in(instd_in),.data_out(instd_out));
endmodule
