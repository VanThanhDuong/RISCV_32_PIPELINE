module IDIFstage(rst,en,clk,instd_in,pcd_in,pcd_out,instd_out);
parameter datawidth = 32;
input clk,IFIDWrite,IFIDFlus;
input [datawidth - 1:0] instd_in, pcd_in;
output [datawidth - 1:0] instd_out,pcd_out;
p_reg p_regpcd(.rst(rst),.en(en),.clk(clk),.data_in(pcd_in),.data_out(pcd_out));
p_reg p_reginstd(.rst(rst),.en(en),.clk(clk),.data_in(instd_in),.data_out(instd_out));
endmodule
