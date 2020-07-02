
module PCOrRS1(input [7:0] IF_ID_Opcode, input [31:0] PC_in, input [31:0] Rs1,output [31:0] out);
assign out = (IF_ID_Opcode == 8'b000_11001) ? Rs1 : PC_in;
endmodule