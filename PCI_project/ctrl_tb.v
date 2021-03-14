`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:56:48 02/25/2021
// Design Name:   CTRL_gen
// Module Name:   C:/Users/Aya/PCI_files/ctrl_tb.v
// Project Name:  PCI_files
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CTRL_gen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ctrl_tb;

	// Inputs
	reg frame;
	reg clk;
	reg rst;
	reg [31:0] AD;
	reg Done;
	reg [3:0] CMD;
	reg ADDRESS_valid;
	reg TRDY;
	reg IRDY;
	reg Parity_check;

	// Outputs
	wire Stop;
	wire DEVSEL;
	wire EnableWrite;
	wire [31:0] ADDRESS_FF;
	wire read_address_cmd;
	wire update_add_gen;
	wire rst_gen;
	wire [1:0] mode;
	wire [3:0] CMD_out;
	wire write_on_bus_ctrl;

	// Instantiate the Unit Under Test (UUT)
	CTRL_gen uut (
		.frame(frame), 
		.clk(clk), 
		.rst(rst), 
		.AD(AD), 
		.Done(Done), 
		.CMD(CMD), 
		.ADDRESS_valid(ADDRESS_valid), 
		.TRDY(TRDY), 
		.IRDY(IRDY), 
		.Parity_check(Parity_check), 
		.Stop(Stop), 
		.DEVSEL(DEVSEL), 
		.EnableWrite(EnableWrite), 
		.ADDRESS_FF(ADDRESS_FF), 
		.read_address_cmd(read_address_cmd), 
		.update_add_gen(update_add_gen), 
		.rst_gen(rst_gen), 
		.mode(mode), 
		.CMD_out(CMD_out), 
		.write_on_bus_ctrl(write_on_bus_ctrl)
	);
	initial begin
		clk=1'b1;
		forever #10 clk=~clk;
	end
	initial begin
		// Initialize Inputs
		

		// Wait 100 ns for global reset to finish
	rst=1'b0;
		#40
		
		rst=1'b1;
		frame=1'b1;
		AD=32'h00000000;
		CMD =4'b0111; //write
		//mode=2'b00;   //mode_increment
		ADDRESS_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		Done = 1'b1;
		//local_add=4'b0000;
		#20
		
		
		rst=1'b1;
		frame=1'b0;
		AD=32'h00000400;
		CMD=4'b0111; //write
		//mode=2'b00;   //mode_increment
		ADDRESS_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		Done = 1'b1;
		//local_add=4'b0000;
		#20
		
		rst=1'b1;
		frame=1'b0;
		AD=32'hff000800;
		CMD =4'b0111; //write
		//mode=2'b00;   //mode_increment
		ADDRESS_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		Done = 1'b1;
		//local_add=4'b0000;
		
        
		// Add stimulus here

	end
      
endmodule

