`timescale 1ns / 1ps

//
//////////////////////////////////////////////////////////////////////////////////
module REG_FILE( ADD_A,ADD_B,ADD_D,REG_A,REG_B,REG_D,WE,CLK
    );

input  CLK,WE;
input  [4:0] ADD_A,ADD_B,ADD_D;
input  [31:0] REG_D;
output [31:0] REG_A,REG_B; 
reg    [31:0] reg_file [31:0];
assign  #0.05 REG_A= (ADD_A==5'b00000)?  32'h00000000:reg_file [ADD_A] ; //assign only to net"wire"
assign  #0.05 REG_B= (ADD_B==5'b00000)?  32'h00000000:reg_file [ADD_B] ;
always @(posedge CLK ) begin  
	if (WE==1'b1) 
		reg_file[ADD_D]<=REG_D; 
		
		
		
end
endmodule
