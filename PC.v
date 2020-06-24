//Version 1.2 11:15PM 4/6/2020
/*PC register
	clk: tin hieu xung clock vao cpu.
	pc_in: tin hieu 32 bits tu mux.
	pc: gia tri hien tai cua PC.
	gia tri khoi tao: PC = 0x0000_0000.
	
	muc dich: PC dung de chua dia chi cua lenh tiep theo can thuc hien.
	mo ta: khi co xung clock canh len thi pc = pc_in.
*/

module PC(pc_out, clk, pc_in);
input clk;
input [31:0] pc_in;
output [31:0] pc_out;
reg [31:0] pc_1; reg [31:0] pc_mid;

initial 
begin
pc_mid <= 32'h00_00_00_00;
end
always@(posedge clk)
begin
pc_1 <= pc_mid;
end
always@(negedge clk)
begin
	if (pc_in > 32'h00_00_00_00)
	begin
	pc_mid <= pc_in;
	end
end
assign pc_out = pc_1;
endmodule