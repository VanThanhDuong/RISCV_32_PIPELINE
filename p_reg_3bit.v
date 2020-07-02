module p_reg_3b #(parameter datawidth = 3)(input rst,input en, input clk,input [datawidth-1:0]data_in,[datawidth-1:0]data_out);
reg [datawidth -1 : 0] temp;
always@(posedge clk)
begin
if (rst) temp <= 3'b0; 
else begin
if (en) 
begin
temp <= data_in;
end
else begin temp <= temp;end
end
end
assign data_out = temp;
endmodule