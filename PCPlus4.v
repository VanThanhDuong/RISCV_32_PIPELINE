//version 1.1 11:15PM 4/6/2020
/*
module PCPlus4: lay ket qua pc va cong them 4
pc: ngo vao gia tri hien tai cua pc
pc_plus4: gia tri bang pc + 4
*/
module PCPlus4(pc_plus4, pc);
input [31:0] pc;
output wire [31:0] pc_plus4;

assign pc_plus4 = pc + 32'd4;
endmodule