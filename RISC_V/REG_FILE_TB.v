`timescale 1ns / 1ps

module REG_FILE_TB;

	// Inputs
	reg [4:0] ADD_A;
	reg [4:0] ADD_B;
	reg [4:0] ADD_D;
	reg [31:0] REG_D;
	reg WE;
	reg CLK;

	// Outputs
	wire [31:0] REG_A;
	wire [31:0] REG_B;

	// Instantiate the Unit Under Test (UUT)
	REG_FILE uut (
		.ADD_A(ADD_A), 
		.ADD_B(ADD_B), 
		.ADD_D(ADD_D), 
		.REG_A(REG_A), 
		.REG_B(REG_B), 
		.REG_D(REG_D), 
		.WE(WE), 
		.CLK(CLK)
	);

	initial begin
	 CLK = 1;
	 forever #10  CLK= ~ CLK;
	end
	initial begin
		WE=1;
		ADD_D=32'h01;
		REG_D=32'h01;
		#10
		WE=1;
		ADD_D=32'h02;
		REG_D=32'h02;
		#10;
		ADD_A=32'h01;
		#10;
		ADD_B=32'h02;
		
        
		// Add stimulus here

	end
      
endmodule

