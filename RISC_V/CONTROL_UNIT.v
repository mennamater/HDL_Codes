`timescale 1ns / 1ps

module CONTROL_UNIT( INST_CTRL,  BrEq_CTRL ,ALUsel_CTRL 
,WBACK_sel_CTRL,PCsel_CTRL,IMMsel_CTRL ,REGFILE_en_CTRL ,Bsel_CTRL,Asel_CTRL ,D_MEM_we_CTRL
    );
input [31:0]  INST_CTRL;
input         BrEq_CTRL;
output [3:0]  ALUsel_CTRL;
output [1:0]  WBACK_sel_CTRL,IMMsel_CTRL;
output        PCsel_CTRL,REGFILE_en_CTRL,Bsel_CTRL,Asel_CTRL,D_MEM_we_CTRL;
reg 	[3:0]   ALUsel_CTRL;
reg 	[1:0]   WBACK_sel_CTRL,IMMsel_CTRL;
reg        	 PCsel_CTRL,REGFILE_en_CTRL,Bsel_CTRL,Asel_CTRL,D_MEM_we_CTRL;

always @(*)begin 
    case(INST_CTRL[6:0])
		7'b1101111: begin					//		JAL			
				IMMsel_CTRL = 2'b00; ALUsel_CTRL = {4{1'bx}};
				WBACK_sel_CTRL = 2'bxx; REGFILE_en_CTRL = 1'b1;
				Asel_CTRL = 1'b1; Bsel_CTRL = 1'b1;
				D_MEM_we_CTRL= 1'b1;
		end
		7'b1100111: begin					//		JALR		
				IMMsel_CTRL = 2'b01; ALUsel_CTRL = {0,INST_CTRL[14:12]};
				WBACK_sel_CTRL = 2'b10; REGFILE_en_CTRL = 1'b0;
				Asel_CTRL = 1'b1; Bsel_CTRL = 1'b1;
				D_MEM_we_CTRL= 1'b1;

		end
		7'b1100011: begin					//		BEQ BNQ			
				IMMsel_CTRL = 2'b10; ALUsel_CTRL = {0,INST_CTRL[14:12]};
				WBACK_sel_CTRL= 2'b10; REGFILE_en_CTRL = 1'b1;
				Asel_CTRL = 1'b1; Bsel_CTRL= 1'b1;
			   D_MEM_we_CTRL= 1'b1;

		end
		7'b0000011: begin					//			LW			
		   	IMMsel_CTRL = 2'b11; ALUsel_CTRL = {0,INST_CTRL[14:12]};
				WBACK_sel_CTRL = 2'b10; REGFILE_en_CTRL = 1'b0;
				Asel_CTRL = 1'b0; Bsel_CTRL = 1'b1;
				D_MEM_we_CTRL= 1'b1;

		end
/*		7'b0100011: begin					//		SW			
				IMMsel_CTRL = 3'b100; ALUsel_CTRL= {0,INST_CTRL[14:12]};
				WBACK_sel_CTRL = 2'bxx; REGFILE_en_CTRL = 1'b1;
				Asel_CTRL = 1'b1;  Bsel_CTRL= 1'b1;
				D_MEM_we_CTRL = 1'b0;
	 
		end
	*/	7'b0010011:	begin					//	ANDI XORI ORI ADDI 
				IMMsel_CTRL = 2'b01; ALUsel_CTRL = {0,INST_CTRL[14:12]};
				WBACK_sel_CTRL = 2'b01; REGFILE_en_CTRL = 1'b0;
				Asel_CTRL = 1'b0;  Bsel_CTRL = 1'b1;
				D_MEM_we_CTRL = 1'b1;
 
		end
		7'b0110011: begin						//	AND  XOR  OR  ADD  	
				IMMsel_CTRL = 2'bxx;  ALUsel_CTRL = {INST_CTRL[30],INST_CTRL[14:12]};
				WBACK_sel_CTRL = 2'b01; REGFILE_en_CTRL= 1'b0;
				Asel_CTRL= 1'b0; Bsel_CTRL = 1'b0;
				D_MEM_we_CTRL = 1'b1;

		end
		default :begin
				IMMsel_CTRL = 2'bxx;  ALUsel_CTRL =  {4{1'bx}};
				WBACK_sel_CTRL = 2'b00;  REGFILE_en_CTRL= 1'bx;
				Asel_CTRL = 1'b1; Bsel_CTRL = 1'b1;
				D_MEM_we_CTRL = 1'b1;
		 end
		endcase
    end
assign PCsel= BrEq_CTRL;
endmodule

