`timescale 1ns / 1ps
module memory #( parameter depth =16,parameter addr_w=4,parameter data_w=32)
(BE,ADDR_M, Mem_WE, IN_DATA_M, OUT_DATA_MM, clk);
input clk;
input  [3:0]             BE;
input  			          Mem_WE;
input  [addr_w-1:0]       ADDR_M;
input  [data_w-1:0]       IN_DATA_M;
output [data_w-1:0]       OUT_DATA_MM;
wire    [data_w-1:0]       OUT_DATA_M;
wire [31:0] mask;

assign mask = { {8{BE[3]}},{8{BE[2]}},{8{BE[1]}},{8{BE[0]}}};
reg [data_w-1:0] data_mem [depth-1:0];
assign OUT_DATA_MM = OUT_DATA_M;
assign OUT_DATA_M = data_mem[ADDR_M];
	 //assign #100 OUT_DATA_M = data_mem[ADDR_DATA_M];
	 always @(negedge clk)begin 
		if(Mem_WE==1'b1) begin //active_low
			data_mem[ADDR_M]= (~mask) & IN_DATA_M;
		end
	end 
endmodule
