module cong_32bit(s,cout,x,y,cin);
	parameter WID_DATA=32;
	input [WID_DATA-1:0]x, y;
	input cin;
	output [WID_DATA-1:0]s;
	output cout;
	wire net[0:WID_DATA-1];
	genvar i;
	FullAdder FA0(.s(s[0]), .c(net[0]), .x(x[0]), .y(y[0]), .z(cin));
	generate
		for (i=1; i<31; i=i+1)
			FullAdder FA(.s(s[i]), .c(net[i]), .x(x[i]), .y(y[i]), .z(net[i-1]));
	endgenerate
	FullAdder FA31(.s(s[31]), .c(cout), .x(x[31]), .y(y[31]), .z(net[30]));
endmodule

