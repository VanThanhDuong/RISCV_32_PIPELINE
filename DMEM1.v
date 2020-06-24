module DMEM(DataR,DataW,Addr,WSel,RSel,MemRW,clk);
parameter 	DATA_WIDTH =  32;
parameter	MEM_DEPTH = 1<<18;

output reg 	[DATA_WIDTH-1:0]DataR;

input 		[DATA_WIDTH-1:0]Addr,DataW;
input		[2:0]RSel;
input		[1:0]WSel;
input 		MemRW,clk;

reg    		[DATA_WIDTH-1:0] DMEM [0:MEM_DEPTH-1];

wire		[DATA_WIDTH-1:0]tempR,tempW;
wire		[29:0]pWord;
wire		[1:0]pByte;

assign		pWord = Addr[31:2];	//lay 18 bit 2 : 19 cua aluout
assign		pByte = Addr[1:0];	//lay 2 bit 0 1 cua aluout
assign		tempW = DMEM[pWord];	//lay gia tri DMEM tai dia chi pWord
assign		tempR = DMEM[pWord];	//lay gia tri DMEM tai dia chi pWord

always@(negedge clk) 
begin 
   	if (MemRW) begin				//Write
		if (pByte == 2'b00) begin
		case (WSel)
		2'b10:	DMEM[pWord] <= DataW;	//gan rs2_out vao dmemco dia chi pWord
		2'b00:	DMEM[pWord] <= (tempW & 32'hffffff00) | (DataW & 32'h000000ff); 	//lay byte cuoi rs2_out or gia tri DMEM tai pWord gan vao DMEM tai pWord
		2'b01:	DMEM[pWord] <= (tempW & 32'hffff0000) | (DataW & 32'h0000ffff); 	//lay 2 byte cuoi cua rs2_out or 
		endcase
		end
	end
	else begin					//Read		
		if (pByte == 2'b00) begin			
		case (RSel)
		3'b010: DataR <= tempR; 
		3'b000: DataR <= {{24{tempR[7]}},tempR[7:0]}; 
		3'b001: DataR <= {{16{tempR[7]}},tempR[15:0]}; 	
		3'b100: DataR <= {{24{1'b0}},tempR[7:0]}; 
		3'b101: DataR <= {{16{1'b0}},tempR[15:0]}; 	      
		endcase
		end
	end
end

endmodule

