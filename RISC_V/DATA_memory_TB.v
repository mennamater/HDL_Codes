`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module DATA_memory_TB;

	// Inputs
	reg [7:0] ADDR_DATA_M;
	reg Mem_WE;
	reg [31:0] IN_DATA_M;

	// Outputs
	wire [31:0] OUT_DATA_M;

	// Instantiate the Unit Under Test (UUT)
	DATA_memory uut (
		.ADDR_DATA_M(ADDR_DATA_M), 
		.Mem_WE(Mem_WE), 
		.IN_DATA_M(IN_DATA_M), 
		.OUT_DATA_M(OUT_DATA_M)
	);
	
	
	
	initial begin
		Mem_WE=1'b1;
		IN_DATA_M=32'h0000000f;
		ADDR_DATA_M=8'h00;
		#5
		Mem_WE=1'b1;
		IN_DATA_M=32'h00000001;
		ADDR_DATA_M=8'h01;
		#5
		Mem_WE=1'b0;
		ADDR_DATA_M=8'h01;
		
		

		
	end
      
endmodule

