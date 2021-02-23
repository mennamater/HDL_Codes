`timescale 1ns / 1ps

module CONTROL_UNIT_TB;

	// Inputs
	reg [31:0] INST_CTRL;
	reg BrEq_CTRL;

	// Outputs
	wire [3:0] ALUsel_CTRL;
	wire [1:0] WBACK_sel_CTRL;

	wire PCsel_CTRL;
	wire [1:0] IMMsel_CTRL;
	wire REGFILE_en_CTRL;
	wire Bsel_CTRL;
	wire Asel_CTRL;
	wire D_MEM_we_CTRL;

	// Instantiate the Unit Under Test (UUT)
	CONTROL_UNIT uut (
		.INST_CTRL(INST_CTRL), 
		.BrEq_CTRL(BrEq_CTRL), 
		.ALUsel_CTRL(ALUsel_CTRL), 
		.WBACK_sel_CTRL(WBACK_sel_CTRL), 
		.PCsel_CTRL(PCsel_CTRL), 
		.IMMsel_CTRL(IMMsel_CTRL), 
		.REGFILE_en_CTRL(REGFILE_en_CTRL), 
		.Bsel_CTRL(Bsel_CTRL), 
		.Asel_CTRL(Asel_CTRL), 
		.D_MEM_we_CTRL(D_MEM_we_CTRL)
	);

	initial begin
		INST_CTRL = 0;
		BrEq_CTRL = 0;
		#10
      INST_CTRL=32'h000002B3;
		#10
      INST_CTRL=32'h00100313;


	end
      
endmodule

