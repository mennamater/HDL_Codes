`timescale 1ns / 1ps

module MUX_2(	IN2MUX_1,IN2MUX_2,OUT2MUX,S_MUX
    );
input  [31:0] IN2MUX_1,IN2MUX_2;
input  S_MUX;
output [31:0] OUT2MUX;
reg    [31:0] OUT2MUX;
always @(S_MUX) begin
	case (S_MUX)
		1'b0: begin #0.01 OUT2MUX=IN2MUX_1; end
		1'b1: begin #0.01 OUT2MUX=IN2MUX_2; end
	endcase	
end 

endmodule
// S_MUX is not a constant => so should be in always block