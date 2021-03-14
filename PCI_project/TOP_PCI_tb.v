`timescale 1ns / 1ps

module TOP_PCI_tb(
    );
	 
	 
	 
	 reg rst, clk , TRDY, IRDY, Frame; 
	 reg [3: 0] BE; 
	 reg  [31:0] AD; 
	 reg  PAR;			/* wire because it is a bidirectional signal		*/ 
	 wire  STOP; 
	 wire DEVSEL; 
	 wire[31:0]AD_wire;
	 wire PAR_wire;
	
	assign AD_wire = AD;
	assign PAR_wire = PAR;
 TOP_PCI TOP_PCI_DUT( 
				.rst(rst), 
				.clk(clk), 
				.TRDY(TRDY), 
				.IRDY(IRDY), 
				.STOP(STOP), 
				.Frame(Frame), 
				.BE(BE), 
				.AD(AD_wire), 
				.PAR(PAR_wire), 
				.DEVSEL(DEVSEL)
    );
	 
	initial begin 
	 clk = 1'b1; 
	 forever #10 clk = ~clk;
	end
	
	initial begin 
		rst =1'b1;
		#40
		rst= 1'b0; 
		/*  frame is deasserted to 1	and system reset */
		#40 
		rst =1'b1; 
		Frame = 1'b1;
		TRDY =1'b1;
		IRDY= 1'b1;
		 BE =4'b0111;
		BE =4'b0000;
		AD = 32'h00000000;
	   PAR = 1'b0;
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
		#20		
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b0111;
		AD = 32'h00000400;
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b0111;
		
		AD = 32'h0000ffff;
	   PAR = 1'b1;
		
		/*  second data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//		AD = 32'h0000ffff;
//	   PAR = 1'b0;

//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//		AD = 32'h0000aaff;
//	   PAR = 1'b0;

		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE = 4'b0000;
		AD = 32'h00000001;
	   PAR = 1'b0;

		
		
		
		
		
		
		
		// READ Test
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
	   #20		
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b0110;
		AD = 32'h00000400;
		PAR = 1'b1; 
		
//		#20		
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE =4'b0110;
//		PAR = 1'b1; 
//		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0110;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/*  second data is recieved and should be written to memory  */
		#40
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE = 4'b0000;
	   PAR = 1'b0;

//	//--------------------------------------
//	//target_termination_read
//	// READ Test
//		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
//	   #20		
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE =4'b0110;
//		AD = 32'h00000400;
//		PAR = 1'b1; 
//		
////		#20		
////		Frame = 1'b0;
////		TRDY =1'b0;
////		IRDY= 1'b0;
////		BE =4'b0110;
////		PAR = 1'b1; 
////		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0110;
//		
//	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		
//		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		
//		
//		
//		
//		
//		/*  second data is recieved and should be written to memory  */
//		#40
//		Frame = 1'b1;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//	   PAR = 1'b0;
//

//Another write 
		
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
		#20		
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b0111;
		AD = 32'h00000408;  
		PAR = 1'b0; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		BE = 4'b0111;
		AD = 32'haaaaaaaa;
	   PAR = 1'b0;
//		
		/*  second data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//		AD = 32'haaaaaaaa;
//	   PAR = 1'b0;

//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//		AD = 32'hbbbbbbbb;
//	   PAR = 1'b0;

		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE = 4'b0000;
		AD = 32'hbbbbbbbb;
	   PAR = 1'b0;

		
	

//Another write 
		
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
		#20		
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b0111;
		AD = 32'h00000410;  
		PAR = 1'b0; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		BE = 4'b0111;
		AD = 32'h11112222;
	   PAR = 1'b0;
//		
		/*  second data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0111;
//		AD = 32'h11112222;
//	   PAR = 1'b0;

//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//		AD = 32'h12121212;
//	   PAR = 1'b0;

		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE = 4'b0000;
		AD = 32'h12121212;
	   PAR = 1'b0;
		
		
		
		
//Another write 
		
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
		#20		
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b0111;
		AD = 32'h00000418;  
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		BE = 4'b0111;
		AD = 32'h12345678;
	   PAR = 1'b1;
//		
		/*  second data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//		AD = 32'h12345678;
//	   PAR = 1'b0;
//
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		BE = 4'b0000;
//		AD = 32'habcdabcd;ss
//		AD = 32'habcdabcd;
//	   PAR = 1'b0;

		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE = 4'b0000;
		AD = 32'haaaabbbb;
	   PAR = 1'b0;
	//------------------------------------------------------------
		//READLINE wrap 
		
		// READ Test
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
	   #20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1110;
		AD = 32'h00000406;
		PAR = 1'b1; 
		
		#20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		AD = 32'hz;
		BE =4'b1110;
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b1110;
		AD = 32'hz;
		BE = 4'b0000;
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b1;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b1;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/*  second data is recieved and should be written to memory  */
		#20
		Frame = 1'b1;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE = 4'b0000;
	   PAR = 1'b0;
		
		
			//------------------------------------------------------------
		//READLINE INCREMENT 
		
		// READ Test
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
	   #20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1110;
		AD = 32'h00000408; 
		PAR = 1'b0; 
		
		#20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		AD = 32'hz;
		BE =4'b1110;
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b1110;
		AD = 32'hz;
		BE = 4'b0000;
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b1;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		
//		
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b1;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
////		#20
////		Frame = 1'b0;
////		TRDY =1'b0;
////		IRDY= 1'b1;
////		//BE =4'b0000;
////		AD = 32'hz;
////		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b1;
		TRDY =1'b1;
		IRDY= 1'b1;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		
			//------------------------------------------------------------
		//READLINE RESERVED 
		
		// READ Test
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
	   #20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1110;
		AD = 32'h00000409; 
		PAR = 1'b1; 
		
		#20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		AD = 32'hz;
		BE =4'b1110;
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE =4'b1110;
		AD = 32'hz;
		BE = 4'b0000;
	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b1;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
//		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b1;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		
		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		BE = 4'b0000;
	   PAR = 1'b0;
		
		
		/*  second data is recieved and should be written to memory  */
		#20
		Frame = 1'b1;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE = 4'b0000;
	   PAR = 1'b0;
		
		//---------------------------------
		
		// 
		
		// READ_multiple_wrap Test
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
	   #20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1100;
		AD = 32'h0000040a;
		PAR = 1'b1; 
		
		#20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1100;
		AD = 32'hz;
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b1;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		
		/*  second data is recieved and should be written to memory  */
		
		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
//		#20
//		Frame = 1'b1;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
		
	   PAR = 1'b1;
		#20
		Frame = 1'b1;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE = 4'b0000;
	   PAR = 1'b0;
		
		
		
		// READ_multiple_INCREMENT Test
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
	   #20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1100;
		AD = 32'h00000408;
		PAR = 1'b0; 
		
		#20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1100;
		AD = 32'hz;
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
//		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b1;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		
		/*  second data is recieved and should be written to memory  */
		
		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
//		#20
//		Frame = 1'b1;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
		
	   PAR = 1'b1;
		#20
		Frame = 1'b1;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE = 4'b0000;
	   PAR = 1'b0;
		
		
		
		// READ_multiple_reserved Test
		/*  frame is asserted to 0	and address is recieved TRDY and IRDY are set to 1 command is write */
	   #20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1100;
		AD = 32'h00000409;
		PAR = 1'b1; 
		
		#20		
		Frame = 1'b0;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE =4'b1100;
		AD = 32'hz;
		PAR = 1'b1; 
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
//		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
//		#20
//		Frame = 1'b0;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
//		
//	   PAR = 1'b1;
		
		/* data is recieved and should be written to memory  */
		#20
		Frame = 1'b0;
		TRDY =1'b0;
		IRDY= 1'b1;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
	   PAR = 1'b1;
		/* data is recieved and should be written to memory  */
		
		/*  second data is recieved and should be written to memory  */
		
		#20
		Frame = 1'b1;
		TRDY =1'b0;
		IRDY= 1'b0;
		//BE =4'b0000;
		AD = 32'hz;
		BE = 4'b0000;
		
//		#20
//		Frame = 1'b1;
//		TRDY =1'b0;
//		IRDY= 1'b0;
//		//BE =4'b0000;
//		AD = 32'hz;
//		BE = 4'b0000;
		
	   PAR = 1'b1;
		#20
		Frame = 1'b1;
		TRDY =1'b1;
		IRDY= 1'b1;
		BE = 4'b0000;
	   PAR = 1'b0;
	end




endmodule