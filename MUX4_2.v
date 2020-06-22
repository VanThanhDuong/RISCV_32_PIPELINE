module mux4_2 #(parameter datawidth = 32)(
input [1:0] muxsel,
input [datawidth - 1 : 0] pcx,
input [datawidth - 1 : 0] datareg2,
input [datawidth - 1 : 0] dataALU,
input [datawidth - 1 : 0] dataWB,
input Bsel;
output [datawidth - 1 : 0] MUX_out, );
case(muxsel)
2'b00: 
begin
if (Bsel == 1) MUX_out = pcx;
else MUX_out = datareg2;
end
2'b01: assign MUX_out = dataWB;
2'b10: assign MUX_out = dataALU;
default: assign MUX_out = pcx;
endcase
endmodule