`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:16:31 02/15/2021
// Design Name:   parity_checker
// Module Name:   C:/Users/Aya/PCI/par_check_tb.v
// Project Name:  PCI
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: parity_checker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module par_check_tb;

	// Inputs
	reg [31:0] AD;
	reg PAR;

	// Outputs
	wire Parity_check;

	// Instantiate the Unit Under Test (UUT)
	parity_checker uut (
		.AD(AD), 
		.PAR(PAR), 
		.Parity_check(Parity_check)
	);

	initial begin
		// Initialize Inputs
		AD = 5;
		PAR = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

