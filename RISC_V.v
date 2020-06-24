/*
edit 11:15PM 4/6/2020
ver 1.1: thay doi thu tu va ten mot so tin hieu wire
		 them khoi IP
*/
module RISC_V(clk);
input clk;
wire [31:0] inst, pc_plus4_out, pc_out, pc_in, imm,DataA ,DataB, outmux1, outmux2, aluout, wb, DataR;
wire pcmux_sel, regfilemux_sel, BrUn, ASel, BSel, MemRW, br_eq, br_lt; 
wire [2:0] immsel;
wire [3:0] ALUSel;
wire [1:0] WBsel;
wire [1:0]	Wsel;
wire [2:0]	Rsel;

PCmux PCMUX (pc_in, pcmux_sel, pc_plus4_out, aluout);
PC PC (pc_out, clk, pc_in);
PCPlus4 PC_Plus_4 (pc_plus4_out, pc_out);
IMEM IMEM (inst, pc_out);
RegFile REGfile (inst[19:15], inst[24:20], inst[11:7], wb, DataA, DataB, regfilemux_sel, clk);
immgen immgen (inst, immsel, imm);
branch_comp BranchComp (DataA, DataB, br_eq, br_lt, BrUn);
mux1 MUX1 (pc_out, DataA, ASel, outmux1);
mux2 MUX2 (imm, DataB, BSel, outmux2);
ALU Alu (outmux1, outmux2, ALUSel, aluout);
DMEM DMEM (DataR, DataB, aluout,Wsel , Rsel, MemRW, clk);// thieu
muxwb MuxWB (WBsel, DataR, wb, aluout, pc_plus4_out);
control CONTROL ({inst[30],inst[14:12],inst[6:2]}, pcmux_sel, immsel, regfilemux_sel, BrUn, br_eq, br_lt, BSel, ASel, ALUSel, MemRW, WBsel,Rsel,Wsel);

endmodule