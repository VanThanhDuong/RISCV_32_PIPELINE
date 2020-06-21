module IDIFstage(IFIDwrite,clk,instd_in,pcd_in,pcd_out,instd_out);
parameter datawidth = 32;
input reg clk,IFIDwrite;
input [datawidth - 1:0] instd_in, pcd_in;
output [datawidth - 1:0] instd_out,pcd_out;
initial 
begin
pcd_in <=32'h0;
instd_in <=32'h0;
pcd_out <=32'h0;
instd_out <= 32'h0;
end
always@(clk or IFIDwrite)
begin
case(IFIDwrite)
1'b0: 