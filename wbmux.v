module muxwb(WBsel, mem, wb, alu, pc4);	
parameter length=32;	
input [length-1:0] mem, alu, pc4;	
input[1:0] WBsel;	
output [length-1:0] wb;	
assign wb = (WBsel==2'b00)? mem:	
	    (WBsel==2'b01)? alu:
	    (WBsel==2'b10)? pc4:
		pc4;
endmodule	
	
	
	

