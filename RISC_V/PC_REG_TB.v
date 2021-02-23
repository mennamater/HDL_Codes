`timescale 1ns / 1ps


module PC_REG_TB;

	// Inputs
	reg [31:0] IN_PC;
	reg CLK;
	reg RST;

	// Outputs
	wire [31:0] OUT_PC;

	
	PC uut (
		.IN_PC(IN_PC), 
		.OUT_PC(OUT_PC), 
		.CLK(CLK), 
		.RST(RST)
	);

	initial begin
	 CLK = 1;
	 forever #10  CLK= ~ CLK;
	end
	initial begin
	RST=0;
	IN_PC=32'h0f;
	#10
	RST=1;
	IN_PC=32'h0f;
	
		
	end
      
endmodule

