module test_bench;
reg clk;

Datapath datapath(.clk(clk));

initial 
  	begin
		clk = 0;
  	
#300000 $finish;
end
always
  	begin
   		#10 clk = ~clk;
  	end
endmodule
