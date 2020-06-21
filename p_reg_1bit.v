module p_reg_1b #(parameter datawidth = 1)(input rst,input en, input clk,input [datawidth-1:0]data_in,[datawidth-1:0]data_out);
reg [datawidth -1 : 0] temp;
always@(posedge clk)
begin
if (rst) temp <= 1'b0;
if (en) 
begin
temp <= data_in;
end
end
assign data_out = temp;
endmodule