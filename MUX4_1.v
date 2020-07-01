module mux4_1 #(parameter datawidth = 32)(input [1:0] muxsel,
input [datawidth - 1 : 0] datareg1,
input [datawidth - 1 : 0] dataALU,
input [datawidth - 1 : 0] dataWB,
output [datawidth - 1 : 0] MUX_out );
reg [31:0] mux_temp;
always@(muxsel )
begin
case(muxsel)
2'b00: mux_temp <= datareg1;
2'b01:  mux_temp <= dataWB;
2'b10: mux_temp <= dataALU;
endcase
end
assign MUX_out = mux_temp;
endmodule