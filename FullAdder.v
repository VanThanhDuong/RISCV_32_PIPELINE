module FullAdder(s,c,x,y,z);
	input x, y, z;
	output c, s;
	assign s = (x^y)^z;
	assign c = x*y+y*z+z*x;
endmodule
