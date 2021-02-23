`timescale 1ns / 1ps

module ADDER_4(IN,OUT
    );
input  [31:0] IN;
output [31:0] OUT;
//reg    [31:0] OUT;

	
		assign #0.01 OUT = IN +3'b100;

	endmodule
