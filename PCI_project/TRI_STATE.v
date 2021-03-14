`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:36:47 02/19/2021 
// Design Name: 
// Module Name:    TRI_STATE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TRI_STATE #( parameter WIDTH = 32 )( in, out, control);

input[WIDTH -1:0] in ;
input control;
output reg [WIDTH -1:0] out ;


always @(*) begin 
	if (control == 1'b0)begin 
		out = in ; 
	end
	else begin 
		out ={WIDTH{1'bz}};
	end

end
endmodule
