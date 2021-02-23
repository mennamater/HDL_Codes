`timescale 1ns / 1ps

module RISCV_TOP(RST ,CLK);

input RST ,CLK;

//wires
wire 			CLK,RST;
wire [31:0] inst_2_control;
wire 			brEQ_2_control;
wire [3:0] 	alusel_2_DP;
wire [1:0] 	wb_sel_2_DP;
wire [1:0]  immsel_2_DP;
wire 			PCsel_2_DP,REGFILE_en_2_DP,Bsel_2_DP,Asel_2_DP,D_MEM_we_2_DP;



//instantance CONTROL UNIT

	CONTROL_UNIT  ctrl( 
	.INST_CTRL(inst_2_control), 
	.BrEq_CTRL (brEQ_2_control),
	.ALUsel_CTRL(alusel_2_DP), 
	.WBACK_sel_CTRL(wb_sel_2_DP),
	.PCsel_CTRL(PCsel_2_DP),
	.IMMsel_CTRL (immsel_2_DP),
	.REGFILE_en_CTRL (REGFILE_en_2_DP),
	.Bsel_CTRL(Bsel_2_DP),
	.Asel_CTRL (Asel_2_DP),
	.D_MEM_we_CTRL(D_MEM_we_2_DP)
	 );
//instantance DATA PATH 

	DATA_PATH_TOP data_path( 
	.CLK(CLK), 
	.RST(RST),
	.INST(inst_2_control),
	.BrEq(brEQ_2_control),
	.ALUsel(alusel_2_DP),
	.WBACK_sel(wb_sel_2_DP),
	.PCsel(PCsel_2_DP),
	.IMMsel(immsel_2_DP),
	.REGFILE_en(REGFILE_en_2_DP),
	.Bsel(Bsel_2_DP),
	.Asel(Asel_2_DP),
	.D_MEM_we(D_MEM_we_2_DP)
	);

endmodule
