`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:14:50 02/15/2021
// Design Name:   Address_decoder
// Module Name:   F:/ITI/ISE/Verilog_pci_memoru_decoder/Address_Decoder_tb.v
// Project Name:  Verilog_pci_memoru_decoder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Address_decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Address_Decoder_tb;

	// Inputs
	reg [31:0] AD;

	// Outputs
	wire ADDRESS_valid;
	wire [4:0] localAddress;

	// Instantiate the Unit Under Test (UUT)
	Address_decoder uut (
		.AD(AD), 
		.ADDRESS_valid(ADDRESS_valid), 
		.localAddress(localAddress)
	);

	initial begin
		// Initialize Inputs
	AD = 32'h00000000;
	#100
	AD = 32'h00000000;
	
	#100
	AD = 32'h00000400;
	
	#100
	AD = 32'h00000401;

	#100
	AD = 32'h00000402;
	#100
	AD = 32'h00000405;

	
	#100
	AD = 32'h00000406;

	#100
	AD = 32'h00000407;
	#100
	AD = 32'h00000408;
		
	#100
	AD = 32'h00000409;

	#100
	AD = 32'h0000040A;
	#100
	AD = 32'h0000040B;

	end
      
endmodule

