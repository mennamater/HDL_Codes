`timescale 1ns / 1ps



module BRENCH_COMP_TB;

	// Inputs
	reg [31:0] IN_1;
	reg [31:0] IN_2;

	// Outputs
	wire EQUEL;

	// Instantiate the Unit Under Test (UUT)
	BRANCH_COMP uut (
		.IN_1(IN_1), 
		.IN_2(IN_2), 
		.EQUEL(EQUEL)
	);

	initial begin
		// Initialize Inputs
		IN_1 = 0;
		IN_2 = 0;

		#10
		IN_1 = 32'h 00001001;
		IN_2 = 32'h 00001001;
		#10
		IN_1 = 32'h 00001011;
		IN_2 = 32'h 00001001;
		

	end
      
endmodule

