module RegFile (rs1, rs2, rd, datain, rs1_out, rs2_out, regfilemux_sel, clk);
	parameter WID_DATA = 32;
	parameter WID_ADD = 5;
	parameter ADD = 32;
	
	input clk, regfilemux_sel;
	input [WID_ADD-1:0] rs1, rs2, rd;
	input [WID_DATA-1:0] datain;
	output [WID_DATA-1:0] rs1_out, rs2_out;
	reg [WID_DATA-1:0] register [ADD-1:0];
	integer i;
	
	initial
	begin
		for (i=0; i<32; i= i+1)
		begin
			register[i]  <= 32'd0;
		end
	end

	always @(posedge clk)
	begin
		if (regfilemux_sel == 1'b1)
		begin
			register[rd] <= datain;
			register[0] <= 32'd0;
		end
	end 
	assign rs1_out = register[rs1];
	assign rs2_out = register[rs2];
endmodule
