module ALU( outmux1,outmux2, ALUSel, ALUout);
input [3:0] ALUSel;
input [31:0] outmux1,outmux2;
output reg [31:0] ALUout;
always@(*)
begin
case (ALUSel)
4'b0000: ALUout = outmux1+outmux2 ;
4'b0001: ALUout = outmux1-outmux2;
4'b0010: ALUout = outmux1<<outmux2;
4'b0011: begin
	if(outmux1[31]!= outmux2[31])
	ALUout = (outmux1[31] == 1)? 32'd1:32'd0;
	else
	ALUout = (outmux1 < outmux2)? 32'd1: 32'd0;
	end
//ALUout= (outmux1<outmux2)?32'd1:32'd0;
4'b0100: ALUout= (outmux1<outmux2)?32'd1:32'd0;
4'b0110: ALUout= outmux1>>outmux2;


4'b0101: ALUout= outmux1^outmux2;
4'b1000: ALUout= outmux1|outmux2;
4'b1001: ALUout= outmux1&outmux2;
4'b1010: ALUout = outmux2;
        endcase
end
endmodule

