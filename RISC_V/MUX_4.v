`timescale 1ns / 1ps

module MUX_4(	IN4MUX_1,IN4MUX_2,IN4MUX_3,OUT4MUX,S_MUX
    );
input  [31:0] IN4MUX_1,IN4MUX_2,IN4MUX_3;
input  [1:0] S_MUX;
output [31:0] OUT4MUX;
reg    [31:0] OUT4MUX;
always @(S_MUX) begin
	case (S_MUX)
		2'b00: begin #0.01 OUT4MUX=IN4MUX_1; end
		2'b01: begin #0.01 OUT4MUX=IN4MUX_2; end
		2'b10: begin #0.01 OUT4MUX=IN4MUX_3; end
		default:OUT4MUX =32'hxxxxxxxx;
	endcase	
end 

endmodule
