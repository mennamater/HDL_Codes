`timescale 1ns / 1ps

module CTRL_gen(
			input frame,
			input clk,
			input rst,
			input [31:0]AD,
			//inout PAR,
			input Done,
			input[3:0] CMD,
			input ADDRESS_valid, 	/* 	used when the address is valid 		*/
			input TRDY,
			input IRDY,
			input Parity_check,
			output reg Stop,
			output reg DEVSEL,			/* used when the slave is selected 			*/
			//output reg memoryWRITE,
			output reg EnableWrite,
			//output reg memoryReadLINE,
			//output reg memoryReadMUL,
			output reg [31:0] ADDRESS_FF,
			output reg read_address_cmd,
			output reg update_add_gen,
			output reg rst_gen,
			output wire [1:0] mode,
			output reg [3:0] CMD_out,
			output reg write_on_bus_ctrl
         );



    /* Command parameters as in the specification of PCI */
	localparam  [3:0] READ_CMD = 4'b0110,
					WRITE_CMD = 4'b0111,
					READ_MUL_CMD = 4'b1100,
					READ_LINE_CMD = 4'b1110;
					

	localparam 	[1:0] INCREMENT = 2'b00,
							WRAP		= 2'b10,
							RESERVED1 = 2'b01,
							RESERVED2 = 2'b11;

	localparam	[2:0]IDLE = 3'b000,
               WAIT_STATE = 3'b001,
               WRITE_STATE = 3'b010,
					READ_STATE = 3'b011,
					READ_MUL_STATE	= 3'b100,
					READ_LINE_STATE =3'b101,
					Write_terminate = 3'b110;


   reg [2 :0] currentStat; 		/* current state of the fsm */
   reg [2 :0] nextState;		/* next state of the fsm	*/
	reg [3 :0] CMD_FF;
	//reg [31:0] ADDRESS_FF; 			/* address  flip flop  for storing the addresss (for addre generator)*/
	//reg CommandREAD_WRITE;			/*	0 for read 1 for write	*/
	assign  mode  = ADDRESS_FF[1:0];
	//assign  CMD_out  = CMD_FF;
	/* 		update the state			*/
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			currentStat <= IDLE;
		end
		else begin
			currentStat <= nextState;
		end
	end


    always @(*)begin
		write_on_bus_ctrl =1'b1;
		Stop = 1'b1;
		read_address_cmd = 1'b0;
		EnableWrite = 1'b0;
		update_add_gen = 1'b1;				/* By default the generator is off */
		rst_gen = 1'b1;
		DEVSEL = 1'b1;
		CMD_out = CMD_FF;
		case(currentStat)
			/* idle state checks if the FRAME is 0 and Get the command to determint the next state */
			IDLE: begin
				/*DEVSEL = 1'b1;*/
				CMD_out = CMD;
				DEVSEL = 1'b1;
				rst_gen = 1'b0;
				read_address_cmd = 1'b1;
				update_add_gen = 1'b1;
				Stop = 1'b1;				/* deassert the value of Stop to 1 in case of slave termination. (Active low)*/
			/* check if the frame is 1 then the state stays the same		*/
				if(frame == 1'b1)begin
					nextState = IDLE;
				end
			/*	if the frame is 0 then we look into the command the address	*/
				else begin
			/* if the Address is Valid then we should Read the command to determine the operation	*/
					if((ADDRESS_valid == 1'b1) && (Parity_check == 1'b1)) begin
						//read_address_cmd = 1'b1;
			/* if it is a read commmand then we must go to a wait state 							*/
						if(CMD == READ_CMD) begin
							nextState = WAIT_STATE;
							EnableWrite = 1'b0;					 /*  read command (active low)		*/
							//DEVSEL = 1'b0;
							/*  CommandREAD_WRITE  = 1'b0;	*/
							end
						else if(CMD == READ_MUL_CMD)begin
							nextState = WAIT_STATE;
							//DEVSEL = 1'b0;

						end
						else if (CMD == READ_LINE_CMD) begin
							nextState = WAIT_STATE;
							//update_add_gen = 1'b0;
							//DEVSEL = 1'b0;
						end
						else if(CMD == WRITE_CMD) begin
							nextState = WRITE_STATE;
							//memoryWRITE = 1'b1;
							//DEVSEL = 1'b0;
							/*		CommandREAD_WRITE  = 1'b1;   	*/
						end
						else begin
						nextState = IDLE;
						end
					end
					else begin
						nextState = IDLE;
					end
				end
			end
			WRITE_STATE: begin
				/* Yousif and Menna :Aya Why did you make update_add_gen = 1'b1; */ /*  --------------------->*/
			  update_add_gen = 1'b1;  //(active low)
			  DEVSEL = 1'b0 ;
				rst_gen = 1'b1;
			/* to never update the value of the stored ADRESS anc command for more details  STORE ADDRESS  always block. */
			  read_address_cmd = 1'b0;
			  EnableWrite = 1'b0;
			  /* check the frame */
			  if( (frame == 1'b0) ) begin
			  /*     write once check on TRDY IRDY				*/
			    if ((Done == 1'b1))begin
			      if((IRDY == 1'b0) )  begin
			        EnableWrite = 1'b1;
			        nextState = WRITE_STATE;
			        if ((TRDY == 1'b0)) begin
			          update_add_gen = 1'b0;
			        end
			        else begin
			        update_add_gen = 1'b1;
			        end
			        end
			      else begin
			          nextState = WRITE_STATE;
			      end
			    end
			    else begin
			      nextState = IDLE;
					EnableWrite = 1'b1;
			      Stop = 1'b0;
			    end
			  end
			  //frame = 1
			  else begin
			  /*     write once check on TRDY IRDY				*/
			    
			      if((IRDY == 1'b0) && (TRDY == 1'b0))  begin  //IRDY must be deasserted when frame = 1 indicating the last data phase.
						EnableWrite = 1'b1;
			          nextState = Write_terminate;
			      end
			      else begin
			        nextState = WRITE_STATE;
					  EnableWrite = 1'b0;    //changed saturday
			      end
			    end
			
			end
			
			Write_terminate: begin
				if (CMD_FF == 3'b0111) begin
					nextState = IDLE;
					EnableWrite = 1'b1;
				end
				else begin
					nextState = IDLE;
					write_on_bus_ctrl = 1'b0;
				end
			end
			
			WAIT_STATE: begin
			
				read_address_cmd = 1'b0;
				rst_gen = 1'b1;
				DEVSEL = 1'b1;
				if(CMD_FF == READ_LINE_CMD)begin
					nextState = READ_LINE_STATE;
					update_add_gen = 1'b0;
				end
				else if (CMD_FF == READ_CMD)begin
					nextState = READ_STATE;
				end
				else if  (CMD_FF == READ_MUL_CMD) begin
					nextState = READ_MUL_STATE;
				end
				else   begin
					nextState = IDLE;
				end
			end
			READ_STATE: begin
				rst_gen = 1'b1;
			  write_on_bus_ctrl = 1'b1; //active low
			  update_add_gen = 1'b1;      //(active low)
			  DEVSEL = 1'b0 ;
			/* to never update the value of the stored ADRESS anc command for more details  STORE ADDRESS  always block. */
			  read_address_cmd = 1'b0;
			  /* check the frame */
			  if( (frame == 1'b0) ) begin
			  /*     write once check on TRDY IRDY				*/
			    if ((Done == 1'b1))begin
			      if((TRDY == 1'b0) )  begin
			        //read_enable = 1'b0;    //read_enable for memory
			        EnableWrite = 1'b0;
			        write_on_bus_ctrl = 1'b0;
			        nextState = READ_STATE;
			        if ((IRDY == 1'b0)) begin
			          update_add_gen = 1'b0;
			        end
			        else begin
			        update_add_gen = 1'b1;
			        end
			        end
			      else begin
			          nextState = READ_STATE;
			      end
			    end
			    else begin
			      nextState = IDLE;
			      Stop = 1'b0;
			    end
			  end
			  //frame = 1
			  else begin
			  /*     write once check on TRDY IRDY				*/
			    if (Done == 1'b1)begin
			      if((IRDY == 1'b0) && (TRDY == 1'b0))  begin
			        EnableWrite = 1'b0;
			        //write_on_bus_ctrl = 1'b0;
			       // memoryWRITE = 1'b1;					/* 		we forgot what it is */
			        nextState = Write_terminate;
			      end
			      else begin
			        nextState = READ_STATE;
			      end
			    end
			    else begin
			    Stop = 1'b0;
			    nextState = IDLE;
			    end
			end
			end
			READ_MUL_STATE:begin
			rst_gen = 1'b1;
			write_on_bus_ctrl = 1'b1; //active low
			update_add_gen = 1'b1;      //(active low)
			DEVSEL = 1'b0 ;
		/* to never update the value of the stored ADRESS anc command for more details  STORE ADDRESS  always block. */
			read_address_cmd = 1'b0;
			/* check the frame */
			if( (frame == 1'b0) ) begin
			/*     write once check on TRDY IRDY				*/
				if ((Done == 1'b1))begin
					if((TRDY == 1'b0) )  begin
						//read_enable = 1'b0;    //read_enable for memory
						EnableWrite = 1'b0;
						write_on_bus_ctrl = 1'b0;
						nextState = READ_MUL_STATE;
						if ((IRDY == 1'b0)) begin
							update_add_gen = 1'b0;
						end
						else begin
						update_add_gen = 1'b1;
						end
						end
					else begin
							nextState = READ_MUL_STATE;
					end
				end
				else begin
					nextState = IDLE;
					Stop = 1'b0;
				end
			end
			//frame = 1
			else begin
			/*     write once check on TRDY IRDY				*/
				if (Done == 1'b1)begin
					if((IRDY == 1'b0) && (TRDY == 1'b0))  begin
						EnableWrite = 1'b0;
						//write_on_bus_ctrl = 1'b0;			
						nextState = Write_terminate;
					end
					else begin
						nextState = READ_MUL_STATE;
					end
				end
				else begin
				Stop = 1'b0;
				nextState = IDLE;
				end
			end
			end
			READ_LINE_STATE:begin
			rst_gen = 1'b1;
			write_on_bus_ctrl = 1'b1; //active low
			update_add_gen = 1'b1;      //(active low)
			DEVSEL = 1'b0 ;
		/* to never update the value of the stored ADRESS anc command for more details  STORE ADDRESS  always block. */
			read_address_cmd = 1'b0;
			/* check the frame */
			if( (frame == 1'b0) ) begin
			/*     write once check on TRDY IRDY				*/
				if ((Done == 1'b1))begin
					if((TRDY == 1'b0) )  begin
						//read_enable = 1'b0;    //read_enable for memory
						EnableWrite = 1'b0;
						write_on_bus_ctrl = 1'b0;
						nextState = READ_LINE_STATE;
						if ((IRDY == 1'b0)) begin
							update_add_gen = 1'b0;
						end
						else begin
						update_add_gen = 1'b1;
						end
						end
					else begin
							nextState = READ_LINE_STATE;
					end
				end
				else begin
					nextState = IDLE;
					Stop = 1'b0;
				end
			end
			//frame = 1
			else begin
			/*     write once check on TRDY IRDY				*/
				if (Done == 1'b1)begin
					if((IRDY == 1'b0) && (TRDY == 1'b0))  begin
						EnableWrite = 1'b0;
						//write_on_bus_ctrl = 1'b0;
						
						nextState = Write_terminate;
					end
					else begin
						nextState = READ_LINE_STATE;
					end
				end
				else begin
				Stop = 1'b0;
				nextState = IDLE;
				end
			end
			end
			default: begin
				nextState = IDLE;
			end
		
		endcase
	end				/*		End of always block		*/



/*  STORE ADDRESS Always block		*/
	always @(posedge clk or negedge rst) begin
		if (rst  == 1'b0) begin
			ADDRESS_FF <= {32{1'b0}};
			CMD_FF <= {4{1'b0}};
		end
			else begin
				if(read_address_cmd == 1'b1)begin
				ADDRESS_FF <= AD;
				  CMD_FF <= CMD;
				end
			else begin
				ADDRESS_FF <= ADDRESS_FF;
				CMD_FF <= CMD_FF;

			end
		end
	end
endmodule
