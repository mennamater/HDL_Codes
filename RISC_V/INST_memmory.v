`timescale 1ns / 1ps

module INST_memmory( ADDR_INST_M,OUT_INST_M
    );
input  [7:0] ADDR_INST_M;
output [31:0] OUT_INST_M;

reg [31:0] rom [0:255];
	
	initial begin
		$readmemh ("machine_code.mem", rom );
	end 
	assign #0.1 OUT_INST_M =rom[ ADDR_INST_M ];

endmodule

/*memory ROM
width word 
depth 256 words
*/ 