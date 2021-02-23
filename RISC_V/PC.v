`timescale 1ns / 1ps

module PC(IN_PC,OUT_PC,CLK,RST
    );
input       CLK,RST;
input  [31:0]   IN_PC;
output [31:0]   OUT_PC;
reg    [31:0]   OUT_PC;

	always @(posedge CLK , negedge RST) begin
		if (RST==1'b0)
			#0.01 OUT_PC <= 32 'h0;
		else
			#0.01 OUT_PC <= IN_PC;
			
	end

endmodule
