`timescale 1ns / 1ps



module ALU_TB;

	// Inputs
	reg [31:0] ALU_IN1;
	reg [31:0] ALU_IN2;
	reg [3:0] SEL_ALU;

	// Outputs
	wire [31:0] ALU_OUT;

	// Instantiate the Unit Under Test (UUT)
	ALU_RSIC uut (
		.ALU_IN1(ALU_IN1), 
		.ALU_IN2(ALU_IN2), 
		.ALU_OUT(ALU_OUT), 
		.SEL_ALU(SEL_ALU)
	);

	initial begin
		ALU_IN1=32'h01;
		ALU_IN2=32'h01;
		SEL_ALU=4'b0000;
		#10
		ALU_IN1=32'h01;
		ALU_IN2=32'h01;
		SEL_ALU=4'b1000;
		#10
		ALU_IN1=32'h01;
		ALU_IN2=32'h01;
		SEL_ALU=4'b0110;
		#10
		ALU_IN1=32'h0f;
		ALU_IN2=32'h01;
		SEL_ALU=4'b0111;
		


	end
      
endmodule

