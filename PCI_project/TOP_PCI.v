`timescale 1ns / 1ps

module TOP_PCI( rst , clk, TRDY, IRDY, STOP, Frame, BE, AD, PAR, DEVSEL
    );
	 
	 input rst, clk , TRDY, IRDY, Frame; 
	 input [3:0] BE; 
	 inout [31:0 ]AD; 
	 inout PAR; 
	 output STOP; 
	 output DEVSEL; 
	 
	 
	 wire address_valid;     		/* output from the address decoder to the control unit 	*/ 
	 wire [3:0] local_add; 			/* output from address decoder to address gernerator 		*/	
	 wire [1:0] mode_2_gen;    	/* output from the control to the address generator 		*/
	 wire [3:0] cmd_2_gen;			/* output from the control to the address generator 		*/
	 wire EnableWrite;				/* output from the control to the memory 						*/
	 wire update_gen;					/* output from the control to the address generator 		*/
	 wire [3:0] add_2_mem;			/* output from the address generator to the memory 		*/
	 wire [31:0] MEM_2_Tri_buf;	/* ouput from memory to tri-state buffer						*/ 
	 wire done_2_ctrl; 				/* output from the address generator to control unit 		*/
	 wire rst_2_add_gen; 			/* output from control to the address generator 			*/
	 wire Parity_check_2_CTRL; 	/* output from parity generator to control unit 			*/
	 wire parity_gen_2_tri; 		/* ouptut form parity genertor to tri-state buffer			*/
	 wire Tri_State_Ctrl;
	 TRI_STATE #(1) TRI_STATE_generator2parity( 
				.in(parity_gen_2_tri), 
				.out(PAR), 
				.control(Tri_State_Ctrl));
				
		TRI_STATE #(32) TRI_STATE_mem2bus( 
				.in(MEM_2_Tri_buf), 
				.out(AD), 
				.control(Tri_State_Ctrl)
				);		
		

		 Address_decoder Address_decoder_Ins(
			  .clk(clk),
			  .rst (rst),
			 .AD(AD),
			 .ADDRESS_valid(address_valid),
			.local_add(local_add)
			);



 address_generator address_generator_Ins(
	 .rst(rst_2_add_gen),
	 .local_address (local_add), 
	 .mode(mode_2_gen),
	 .cmd(cmd_2_gen),
	 .en(update_gen),
	 .clk(clk),
	 .done(done_2_ctrl),
	 .add_2_mem(add_2_mem)
	);	
	
	memory memory_Ins(
						.clk(clk),
						.BE(BE),
						.ADDR_M(add_2_mem), 
						.Mem_WE(EnableWrite), 
						.IN_DATA_M(AD), 
						.OUT_DATA_MM(MEM_2_Tri_buf)
						);


	CTRL_gen  CTRL_gen_Ins(
				.frame(Frame),
				.clk(clk),
				.rst(rst),
				.AD(AD),
				//inout PAR,
				.Done(done_2_ctrl),
				.CMD(BE),
				.ADDRESS_valid(address_valid), 	/* 	used when the address is valid 		*/
				.TRDY(TRDY),
				.IRDY(IRDY),
				.Parity_check(Parity_check_2_CTRL),
				.Stop(STOP),
				.DEVSEL(DEVSEL),			/* used when the slave is selected 			*/
				//output reg memoryWRITE,
				.EnableWrite(EnableWrite),
				//.ADDRESS_FF(ADDRESS_FF),
			//output reg memoryReadLINE,
			//output reg memoryReadMUL,
			//output reg [31:0] ADDRESS_FF,
			//output reg read_address_cmd,
		   .update_add_gen(update_gen),
			.rst_gen(rst_2_add_gen),
			.mode(mode_2_gen),
			.CMD_out(cmd_2_gen),
			.write_on_bus_ctrl(Tri_State_Ctrl)
         );



	parity_checker parity_checker_Ins(
		.AD(AD),
		.PAR(PAR),
		.Parity_check(Parity_check_2_CTRL)
    );

	parity_gen parity_gen_Ins (
		.Data(MEM_2_Tri_buf),
		.parity_gen_bit(parity_gen_2_tri)
    );
endmodule
