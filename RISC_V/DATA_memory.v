`timescale 1ns / 1ps

module DATA_memory(ADDR_DATA_M,Mem_WE,IN_DATA_M,OUT_DATA_M
    );
input  			Mem_WE;
input  [7:0]   ADDR_DATA_M;
input  [31:0]  IN_DATA_M;
output [31:0]  OUT_DATA_M;
reg 	 [31:0]  OUT_DATA_M;

reg [31:0] data_mem [255:0];
	 //assign #100 OUT_DATA_M = data_mem[ADDR_DATA_M];
	 always @(Mem_WE)begin 
		if(Mem_WE==1'b1)
		 #0.1 data_mem[ADDR_DATA_M]=IN_DATA_M; //100ps
		else
		 #0.1 OUT_DATA_M = data_mem[ADDR_DATA_M];
	 end
 
endmodule
