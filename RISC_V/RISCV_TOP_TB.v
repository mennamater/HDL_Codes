`timescale 1ns / 1ps


	

module RISCV_TOP_TB;

	// Inputs
	reg RST;
	reg CLK;

	// Instantiate the Unit Under Test (UUT)
	RISCV_TOP uut (
		.RST(RST), 
		.CLK(CLK)
	);

	initial begin
		
		CLK = 1'b1;
		
      forever #0.5 CLK=~CLK; //clk=1ns
		  
		

	end
	initial begin
		
		RST = 1'b0;
		
       #100;
		 
        RST=1'b1;
		  
		

	end
      
endmodule

