`timescale 1ns / 1ps

module DATA_PATH_TOP( CLK ,RST,INST,PCsel,IMMsel,REGFILE_en,Bsel,Asel,ALUsel,D_MEM_we,WBACK_sel,BrEq
    );
output [31:0] INST;
output        BrEq;
input [3:0]  ALUsel;
input	[1:0]  WBACK_sel;
input [1:0]  IMMsel;
input 		 CLK ,RST;
input			 PCsel,REGFILE_en,Bsel,Asel,D_MEM_we;

//defination wire ".pin of in instanted module(wire)"
wire [31:0] pc_plus4,out_muxpc;     //mux_pc
wire [31:0] out_pc;                 //pc_DP
wire [31:0]	instr;                  // instruction memory
wire [31:0] immdata;                //IMM_generator
wire [31:0] data_a,data_b,data_d;   //register file
wire [31:0] in1_alu,in2_alu;        //mux_a,mux_b
wire [31:0] out_alu;                //alu 
wire [31:0] data_mem_out;           //data_memory

//instantiation mux for select alu or pc+4 according to PCsel
	MUX_2 mux_pc (
	.IN2MUX_1(pc_plus4),
	.IN2MUX_2(out_alu),
	.S_MUX(PCsel),
	.OUT2MUX(out_muxpc)
	);

//instantiation pc
	PC pc_DP(
	.IN_PC(out_muxpc),
	.OUT_PC(out_pc),
	.CLK(CLK),
	.RST(RST)
	);

//instantiation ADD_4 "pc=pc+4"
	 ADDER_4 adder_DP(
	 .IN(out_pc),
	 .OUT(pc_plus4)
	  );

//instantiation INST_memmory	  
	INST_memmory inst_mem_DP( 
	.ADDR_INST_M(out_pc[9:2]),
	.OUT_INST_M(instr)
    );

//instantiation IMM_generator
	IMM_GENRATOR  imm_DP(
	.INSTR(instr),
	.IMM_OUT(immdata),
	.IMM_SEL(IMMsel)
	 );
	 
//instantiation register file
	REG_FILE  regfile_DP( 
	.ADD_A(instr[19:15]),
	.ADD_B(instr[24:20]),
	.ADD_D(instr[11:7]),
	.REG_A(data_a),
	.REG_B(data_b),
	.REG_D(data_d),
	.WE(REGFILE_en),
	.CLK (CLK)
    );
	 
// instantiation branch comparsion
		BRANCH_COMP branch_cmp_DP(
		.IN_1(data_a),
		.IN_2(data_b),
		.EQUEL(BrEq)
    );

//	instantiation mux_2  select between data_a,pc_out according Asel
	MUX_2 mux_a (
	.IN2MUX_1(data_a),
	.IN2MUX_2(out_pc),
	.S_MUX(Asel),
	.OUT2MUX(in1_alu)
	);

// instantiation mux_2  select between data_b,imm_out according Bsel
	MUX_2 mux_b (
	.IN2MUX_1(data_b),
	.IN2MUX_2(immdata),
	.S_MUX(Bsel),
	.OUT2MUX(in2_alu)
	);

//	instantiation alu
	ALU_RSIC alu(
	.ALU_IN1(in1_alu),
	.ALU_IN2(in2_alu),
	.ALU_OUT(out_alu),
	.SEL_ALU(ALUsel)
    );

//instantiation data_memory
	DATA_memory data_mem(
	.ADDR_DATA_M(out_alu[7:0]),
	.Mem_WE(D_MEM_we),
	.IN_DATA_M(data_b),
	.OUT_DATA_M(data_mem_out)
   );

//instantiation mux_4 select between data_mem_out,out_alu,pc_plus4 according WBACK_sel
	MUX_4 mux_4_inst (
	.IN4MUX_1(data_mem_out),
	.IN4MUX_2(out_alu),
	.IN4MUX_3(pc_plus4),
	.OUT4MUX(data_d),
	.S_MUX(WBACK_sel)
    );

// out of the top module
assign  INST= instr;
endmodule
