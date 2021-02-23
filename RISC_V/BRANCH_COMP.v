`timescale 1ns / 1ps

module BRANCH_COMP(IN_1,IN_2,EQUEL
    );
	input  [31:0] IN_1;
	input  [31:0] IN_2;
	output reg EQUEL;
		
		always @(*) begin
			if (IN_1== IN_2)
				#0.01 EQUEL=1'b1;
			else  
				#0.01 EQUEL=1'b0;
		
		end
	
	endmodule
//assign ,= out always block
//if should in always block 