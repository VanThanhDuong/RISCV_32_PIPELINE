
/*
DESCRIPTION:
Hazard Detection Unit
NOTES:
TODO:
Author:
*/

module hazardDetectionUnit_r0 (
	input [7:0] IF_ID_Opcode,
	input [4:0] IF_ID_Rs,
	input [4:0] IF_ID_Rt,
	input ID_EX_MemRead,
	input [4:0] ID_EX_Rt,
	input Breq,
	input Brlt,
	input [4:0] ID_EX_Rd,
	input [4:0] EX_MEM_Rd,
	input ID_EX_RegWrite,
	input EX_MEM_RegWrite,
	output reg PCWrite,
	output reg ID_EX_CtrlFlush,
	output reg IF_ID_Flush,
	output reg IF_ID_Hold,
	input [4:0] ID_EX_Opcode
);

wire temp1,temp3;
reg temp2;
 parameter jal		= 5'b11011;
 parameter jalr	= 8'b000_11001;
 parameter beq		= 8'b000_11000;
 parameter bne		= 8'b001_11000;
 parameter blt = 8'b100_11000;
 parameter bge = 8'b101_11000;
 parameter bgeu = 8'b111_11000;
 parameter bltu = 8'b110_11000;
 parameter load = 5'b00000;
 assign  temp1 = Breq && 1;
 initial 
 begin
 	PCWrite <= 1'b1;
 	ID_EX_CtrlFlush <= 1'b0;
 	IF_ID_Flush <= 1'b0;
 	IF_ID_Hold <= 1'b1; 
 end
	always @(IF_ID_Opcode, IF_ID_Rs, IF_ID_Rt, ID_EX_MemRead, ID_EX_Rt, ID_EX_Rd, EX_MEM_Rd,Breq,Brlt, ID_EX_RegWrite, EX_MEM_RegWrite) begin
	temp2 <= Breq && 1;
		if(((ID_EX_MemRead == 1'b1) && ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt))) || ((ID_EX_Opcode == load)&&((ID_EX_Rd == IF_ID_Rs)||(ID_EX_Rd == IF_ID_Rt)))) begin
			PCWrite <= 1'b0; // 
			ID_EX_CtrlFlush <= 1'b1;//control signals = 0
			IF_ID_Flush <= 1'b0;// erase 
			IF_ID_Hold <= 1'b0;
		end else if(((IF_ID_Opcode == beq) || (IF_ID_Opcode == bne)||(IF_ID_Opcode == blt)||(IF_ID_Opcode == bge)||(IF_ID_Opcode == bgeu)||(IF_ID_Opcode == bltu)) 
		&& (((ID_EX_Rd == IF_ID_Rs || ID_EX_Rd == IF_ID_Rt) && (ID_EX_RegWrite == 1'b1)) || ((EX_MEM_Rd == IF_ID_Rs || EX_MEM_Rd == IF_ID_Rt) && (EX_MEM_RegWrite == 1'b1)))) begin
			PCWrite <= 1'b0;
			ID_EX_CtrlFlush <= 1'b1;
			IF_ID_Flush <= 1'b0;
			IF_ID_Hold <= 1'b0;
		end else if((IF_ID_Opcode[4:0] == jal) || ((IF_ID_Opcode == beq) && (Breq == 1'b1)) || ((IF_ID_Opcode == bne) && (Breq == 1'b0))
			||(IF_ID_Opcode == blt && (Brlt == 1'b1))|| (IF_ID_Opcode == bge && (Brlt == 1'b0))||(IF_ID_Opcode == bgeu && (Brlt == 1'b0))
			|| (IF_ID_Opcode == bltu && (Brlt == 1'b1))) begin
			PCWrite <= 1'b1;
			ID_EX_CtrlFlush <= 1'b0;
			IF_ID_Flush <= 1'b1;
			IF_ID_Hold <= 1'b1;
		end else if(IF_ID_Opcode == jalr) begin
			PCWrite <= 1'b1;
			ID_EX_CtrlFlush <= 1'b0;
			IF_ID_Flush <= 1'b1;
			IF_ID_Hold <= 1'b1;
		end else begin
			PCWrite <= 1'b1;
			ID_EX_CtrlFlush <= 1'b0;
			IF_ID_Flush <= 1'b0;
			IF_ID_Hold <= 1'b1;
		end
	end	
endmodule