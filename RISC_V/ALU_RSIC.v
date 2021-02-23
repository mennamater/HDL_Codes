`timescale 1ns / 1ps

module ALU_RSIC(ALU_IN1,ALU_IN2,ALU_OUT,SEL_ALU
    );
	 
input  [31:0] ALU_IN1,ALU_IN2;
input  [3:0]  SEL_ALU; //[2:0] to select the operation , [3] to detected sub or not
output [31:0] ALU_OUT;
reg    [31:0] ALU_OUT; 
wire   [31:0] ALU_IN_COMP;  
//assign only to wire ?? yes 
//1's complement of ALU_IN2
assign ALU_IN_COMP = (SEL_ALU[3]== 1'b1)? ~ALU_IN2:ALU_IN2;

always @(*) begin 
	case (SEL_ALU[2:0])  
	
		3'b000:begin #0.05  ALU_OUT= ALU_IN1 + ALU_IN_COMP + SEL_ALU[3]; end
		3'b110:begin #0.05  ALU_OUT= ALU_IN1 | ALU_IN2;                  end
		3'b111:begin #0.05  ALU_OUT= ALU_IN1 & ALU_IN2;                  end
		default:     #0.05  ALU_OUT =32'hx;
		
	
	endcase	

	
end

endmodule
