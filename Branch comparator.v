module branch_comp(dataA, dataB, br_eq, br_lt, cmpop);
	parameter WID_DATA = 32;
	input [WID_DATA-1:0]dataA, dataB;
	input cmpop;
	output reg br_eq, br_lt;
	
	always@(dataA or dataB or cmpop)
	begin
		if (cmpop == 1'b1) // so sanh co dau
		begin
			if (dataA[WID_DATA-1] == dataB[WID_DATA-1]) // dataA va dataB cung bit dau
			begin 
				br_eq = (dataA == dataB); // br_eq = 1 neu A = B, br_eq = 0 neu A != B
				br_lt = (dataA < dataB); 
			end
			else // dataA != dataB
			begin
				br_eq = 1'b0; // br_eq = 1 neu A = B, br_eq = 0 neu A != B
				br_lt = (dataA[WID_DATA-1] == 1); // dataA = 1xxx..xxxx, dataB = 0xxx..xxxx 
			end
		end
		else // so sanh khong dau
		begin 
			br_eq = (dataA == dataB); 
			br_lt = (dataA < dataB);
		end
	end
endmodule
