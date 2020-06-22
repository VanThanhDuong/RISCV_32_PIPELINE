module mux4_1 #(parameter datawidth = 32)(input [1:0] muxsel,
input [datawidth - 1 : 0] pcx,
input [datawidth - 1 : 0] datareg1,
input [datawidth - 1 : 0] dataALU,
input [datawidth - 1 : 0] dataWB,
output [datawidth - 1 : 0] MUX_out );
case(muxsel)
2'b00: 
begin
if (Asel == 1) MUX_out = pcx;
else MUX_out = datareg1;
end
2'b01: assign MUX_out = dataWB;
2'b10: assign MUX_out = dataALU;
endcase
endmodule