module Datapath(clk);
parameter DATA_WIDTH = 32;
parameter datawidth = 32;parameter regindex = 5;
input clk;
wire [31:0] pc_in;
wire [DATA_WIDTH - 1 : 0]pc_out;
wire [DATA_WIDTH - 1 : 0]inst;
wire [DATA_WIDTH - 1 : 0]pc_plus_4;
//IF_ID
wire [DATA_WIDTH - 1 : 0]instd_out,pcd_out;
wire [DATA_WIDTH - 1 : 0]imm;
wire [DATA_WIDTH - 1 : 0]rs1_out,rs2_out;
wire [DATA_WIDTH - 1 : 0]Adder_out;
//mux
wire [1:0] Wbsel_out;
wire MemRw_out;
wire [3:0]  ALUsel_out;
wire Asel_out;
wire Bsel_out;
wire [2:0] Rsel_out;
wire [1:0] Wsel_out;
//detection
wire IF_ID_Regwrite_out;
wire PCWrite;
wire ID_EX_CtrlFlush;
wire IF_ID_Flush;
wire IF_ID_Hold;
//branch
wire br_eq,br_lt;
//control
wire [2:0] ImmSel;
wire [1:0] WBSel;
wire [3:0] ALUSel;
wire [2:0] Rsel;
wire [1:0] Wsel;
wire PCSel, RegWEn, BrUn, BSel, ASel, MemRW ;
wire [31:0]DataA;
wire [31:0]DataB;
//ID_EX
wire [datawidth - 1:0] immdata_out;
wire [regindex - 1 : 0] ID_EX_Rs;
wire [regindex - 1 : 0] ID_EX_Rt;
wire [regindex - 1 : 0] ID_EX_Rd;
wire [datawidth - 1 : 0] ID_EX_DataA;
wire [datawidth - 1 : 0] ID_EX_DataB;
wire [datawidth - 1 : 0] ID_EX_PC;
wire [31:0] ID_EX_imm;

wire [31:0] PCorMUX_out;
wire [31:0] ImmorMUX_out;
//control signal
wire [1:0] ID_EX_WBsel;
wire ID_EX_MEMRead;
wire [3:0] ID_EX_ALUsel;
wire ID_EX_Asel;
wire ID_EX_Bsel;
wire [2:0] ID_EX_Rsel;
wire [1:0] ID_EX_Wsel;
wire ID_EX_RegWrite;
wire [DATA_WIDTH - 1 : 0]MUX4_out1,MUX4_out2;
wire [DATA_WIDTH - 1 : 0]ALU_out;
//Forwardinig
wire [1:0] ForwardA;
wire [1:0] ForwardB;
//EX/MEM
wire [datawidth - 1 : 0] EX_MEM_ALU;
wire [datawidth - 1 : 0] EX_MEM_PC;
wire [datawidth - 1 : 0] EX_MEM_MUX2out;
wire [regindex - 1 : 0] EX_MEM_Rd;
wire [1:0] EX_MEM_WBsel;
wire EX_MEM_MemRW;
wire [2:0] EX_MEM_Rsel;
wire [1:0] EX_MEM_Wsel;
wire EX_MEM_RegWrite;
//DMEM
wire [DATA_WIDTH - 1 : 0]DataR;
//MEM/WB
wire [datawidth - 1 : 0] MEM_WB_DataR;
wire [datawidth - 1 : 0] MEM_WB_ALU;
wire [regindex - 1 : 0] MEM_WB_Rd;
wire [1:0] MEM_WB_WBsel;
wire MEM_WB_RegWrite;
wire [31:0]wb;
wire [31:0] MEM_WB_PC;
PCmux pcmux(.pc_in(pc_in), .PCSel(PCSel), .pc_plus4(pc_plus_4), .alu(Adder_out));
PC PC(.pc_out(pc_out), .clk(clk), .pc_in(pc_in),.rst(1'b0),.en(PCWrite));
PCPlus4 pc4(.pc_plus4(pc_plus_4), .pc(pc_out));
IMEM imem(.inst(inst),.PC(pc_out));
IDIFstage IFID(.rst(IF_ID_Flush),.en(IF_ID_Hold),.clk(clk),.instd_in(inst),.pcd_in(pc_out),.pcd_out(pcd_out),.instd_out(instd_out));
hazardDetectionUnit_r0 harzard({instd_out[14:12],instd_out[6:2]},instd_out[19:15],instd_out[24:20],ID_EX_MEMRead,ID_EX_Rt,br_eq,br_lt,ID_EX_Rd,EX_MEM_Rd,ID_EX_RegWrite,EX_MEM_RegWrite,PCWrite,ID_EX_CtrlFlush,IF_ID_Flush,IF_ID_Hold);
control control(.addr({instd_out[31],instd_out[14:12],instd_out[6:2]}), .PCSel(PCSel), .ImmSel(ImmSel), .RegWEn(RegWEn), .BrUn(BrUn), .BrEq(br_eq), .BrLT(br_lt), .BSel(BSel), .ASel(ASel), .ALUSel(ALUSel), .MemRW(MemRW), .WBSel(WBSel),.Rsel(Rsel),.Wsel(Wsel));
cong_32bit cong32bit(.s(Adder_out),.cout(),.x(pcd_out),.y(imm),.cin(1'b0));
RegFile REGfile (instd_out[19:15], instd_out[24:20], MEM_WB_Rd, wb, DataA, DataB, MEM_WB_RegWrite, clk);
immgen immgen1(.inst(instd_out),.immsel(ImmSel),.imm(imm));
mux2_control mux2(.muxsel(ID_EX_CtrlFlush),.zero(1'b0),.Wbsel_in(WBSel),.Wbsel_out(Wbsel_out),
	.MemRw_in(MemRW),.MemRw_out(MemRW_out),.ALUsel_in(ALUSel),.ALUsel_out(ALUsel_out),
	.Asel_in(ASel),.Asel_out(Asel_out),.Bsel_in(BSel),.Bsel_out(Bsel_out),.Rsel_in(Rsel),.Rsel_out(Rsel_out),
	.Wsel_in(Wsel),.Wsel_out(Wsel_out),.IF_ID_Regwrite_in(RegWEn),.IF_ID_Regwrite_out(IF_ID_Regwrite_out));

branch_comp cmp(.dataA(DataA), .dataB(DataB), .br_eq(br_eq), .br_lt(br_lt), .cmpop(BrUn));
IDEXstage IDEX ( .clk(clk),.rst(1'b0), .en(1'b1),
.IFIDreg1_in(instd_out[19:15]),
.IFIDreg1_out(ID_EX_Rs),
.IFIDreg2_in(instd_out[24:20]),
.IFIDreg2_out(ID_EX_Rt),
.IFIDregd_in(instd_out[11:7]),
.IFIDregd_out(ID_EX_Rd),
.datareg1_in(DataA),
.datareg1_out(ID_EX_DataA),
.datareg2_in(DataB),
.datareg2_out(ID_EX_DataB),
.pcx_in(pcd_out),
.pcx_out(ID_EX_PC),
//control signal
.Wbsel_in(Wbsel_out),
.Wbsel_out(ID_EX_WBsel),
.MemRw_in(MemRW_out),
.MemRw_out(ID_EX_MEMRead),
.ALUsel_in(ALUsel_out),
.ALUsel_out(ID_EX_ALUsel),
.Asel_in(Asel_out),
.Asel_out(ID_EX_Asel),
.Bsel_in(Bsel_out),
.Bsel_out(ID_EX_Bsel),
.Rsel_in(Rsel_out),
.Rsel_out(ID_EX_Rsel),
.Wsel_in(Wsel_out),
.Wsel_out(ID_EX_Wsel),
.imm_in(imm),
.imm_out(ID_EX_imm),
.IF_ID_Regwrite_in(IF_ID_Regwrite_out),
.IF_ID_Regwrite_out(ID_EX_RegWrite)
);
mux4_1 mux41(.muxsel(ForwardA),
.datareg1(ID_EX_DataA),
.dataALU(EX_MEM_ALU),
.dataWB(wb),
.MUX_out(MUX4_out1));
PCorMUX41 pcormux1 (
	.muxsel(ID_EX_Asel),
	.MUX41(MUX4_out1),
	.PC(ID_EX_PC),
	.Out(PCorMUX_out));
mux4_2 mux42(
.muxsel(ForwardB),
.datareg2(ID_EX_DataB),
.dataALU(EX_MEM_ALU),
.dataWB(wb),
.MUX_out(MUX4_out2) );
ImmOrMUX42 immormux(.muxsel(ID_EX_Bsel),
	.MUX42_out(MUX4_out2),
	.ID_EX_Imm(ID_EX_imm),
	.Out(ImmorMUX_out));

ALU ALU( .outmux1(PCorMUX_out),.outmux2(ImmorMUX_out), .ALUSel(ID_EX_ALUsel), .ALUout(ALU_out));
forwardingUnit  fordward(
	.ID_EX_Rs(ID_EX_Rs),
	.ID_EX_Rt(ID_EX_Rt),
	.EX_MEM_Rd(EX_MEM_Rd),
	.MEM_WB_Rd(MEM_WB_Rd),
	.EX_MEM_RegWrite(EX_MEM_RegWrite),
	.MEM_WB_RegWrite(MEM_WB_RegWrite),
	.ForwardA(ForwardA),
	.ForwardB(ForwardB)
);
EXMEMstage EXMEM(.rst(1'b0),.clk(clk),.en(1'b1),
.ALU_in(ALU_out),
.ALU_out(EX_MEM_ALU),
.pcm_in(ID_EX_PC),
.pcm_out(EX_MEM_PC),
.datareg_in(MUX4_out2),
.datareg_out(EX_MEM_MUX2out),
.regdindex_in(ID_EX_Rd),
.regdindex_out(EX_MEM_Rd),
.WBsel_in(ID_EX_WBsel),
.WBsel_out(EX_MEM_WBsel),
.MEMRw_in(ID_EX_MEMRead),
.MEMRw_out(EX_MEM_MemRW),
.Rsel_in(ID_EX_Rsel),
.Rsel_out(EX_MEM_Rsel),
.Wsel_in(ID_EX_Wsel),
.Wsel_out(EX_MEM_Wsel),
.ID_EX_Regwrite_in(ID_EX_RegWrite),
.ID_EX_Regwrite_out(EX_MEM_RegWrite)
);
DMEM DMEM(.DataR(DataR),.DataW(EX_MEM_MUX2out),.Addr(EX_MEM_ALU),.WSel(EX_MEM_Wsel),
	.RSel(EX_MEM_Rsel),.MemRW(EX_MEM_MemRW),.clk(clk));
MEMWBstage MEM(.rst(1'b0),.clk(clk),.en(1'b1),
.DataMEM_in(DataR),
.DataMEM_out(MEM_WB_DataR),
.DataALU_in(EX_MEM_ALU),
.DataALU_out(MEM_WB_ALU),
.regdindex_in(EX_MEM_Rd),
.regdindex_out(MEM_WB_Rd),
.WBsel_in(EX_MEM_WBsel),
.WBsel_out(MEM_WB_WBsel),
.EX_MEM_Regwrite_in(EX_MEM_RegWrite),
.EX_MEM_Regwrite_out(MEM_WB_RegWrite),
.MEM_WB_PC_in(EX_MEM_PC),
.MEM_WB_PC_out(MEM_WB_PC)
);
muxwb muxwbb(.WBsel(MEM_WB_WBsel),.mem(MEM_WB_DataR),.wb(wb),.alu(MEM_WB_ALU),.pc4(MEM_WB_PC));
endmodule