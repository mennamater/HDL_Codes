`timescale 1ns / 1ps

module IMM_GENRATOR(INSTR,IMM_OUT,IMM_SEL
    );
input  [31:0] INSTR;
input  [1:0]  IMM_SEL;
output [31:0] IMM_OUT;
reg    [31:0] IMM_OUT;
	always @(*) begin
		case(IMM_SEL)
			//00
			 2'b00: begin #0.01 IMM_OUT= {{11{INSTR[31]}},INSTR[19:12],INSTR[20],INSTR[30:21],1'b0}; end /*J_type"JAL" 
																															 save pc+4  	*/
			 2'b01: begin #0.01 IMM_OUT= {{21{INSTR[31]}},INSTR[30:20]};                             end  //I_type "11bits"
			 
			 2'b10: begin #0.01 IMM_OUT= {{20{INSTR[31]}},INSTR[7],INSTR[30:25],INSTR[11:8],1'b0};   end  //B_type "shift by 1 of S_type"
			 
			 2'b11:begin  #0.01 IMM_OUT= {{21{INSTR[31]}},INSTR[30:25],INSTR[11:7]};                 end  //S_type "11bits"
		endcase
	end

endmodule
