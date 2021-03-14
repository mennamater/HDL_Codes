`timescale 1ns / 1ps

module Address_decoder(
	 input clk,
	 input rst,
    input [31:0] AD,
    output reg ADDRESS_valid,
    output  [3:0] local_add
    );
	/*				The base address of the slave PCI				*/
	localparam ADDRESS = 32'h00000400;
	reg [3:0] localAddress , local_add_FF;

	always @(*)begin 
		if(AD[31:6] == ADDRESS[31:6])begin 
			ADDRESS_valid = 1'b1; 
		end 
		else begin 
			ADDRESS_valid = 1'b0 ; 
		end
	end 
	
	always @(*)begin 
		if (ADDRESS_valid == 1'b1 )begin 
			localAddress = AD[5:2];
		end
		else begin 
			localAddress = 8'h00;
		end
	end
	
	
	always @ (posedge clk, negedge rst) begin
		if (rst == 1'b0) begin 
			local_add_FF <= 4'b0000;
		end
		else begin
			if (ADDRESS_valid) begin
				local_add_FF <= localAddress;
			end
			else begin
				local_add_FF <= local_add_FF;
			end
		end
	end
	
	
	assign local_add = (ADDRESS_valid)? localAddress : local_add_FF;
endmodule
