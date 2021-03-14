`timescale 1ns / 1ps



module address_generator(rst,local_address, mode,cmd,en,clk,done,add_2_mem
);
input    [3:0]     local_address;
input    [3:0]     cmd;
input    [1:0]     mode;
input              en,clk,rst;
output   [3:0]     add_2_mem;
output             done;
reg      [3:0]     add_2_mem;
reg                done;
reg      [2:0]     count_line=3'b000;
reg      [1:0]     keep;
reg      [3:0]     count_w=4'b0000;
reg      [3:0]     count_k=4'b0000;
reg		[3:0]     count_mul_line=4'b0000; 
//defination command
localparam  [3:0]   READ_CMD      = 4'b0110,
						  WRITE_CMD     = 4'b0111,
						  READ_MUL_CMD  = 4'b1100,
						  READ_LINE_CMD = 4'b1110;
//defination mode
localparam 	[1:0]    INCREMENT = 2'b00,
							WRAP		 = 2'b10,
							RESERVED1 = 2'b01,
							RESERVED2 = 2'b11;
//operation

    always@(posedge clk ,negedge rst) begin
        //if (en == 1'b1)begin  //update addres from control
        if(rst==1'b0)begin
			count_w = 4'b0001;
			count_line=3'b000;
			count_k=4'b0000;
			count_mul_line=4'b0000;
			done <= 1'b1;    //active low 
			add_2_mem <=local_address;
		  end
		  else begin
			if (en == 1'b0) begin 
			  if (local_address==4'b1111)begin
					done <= 1'b0; 
				//add_2_mem <=local_address;
			  end
			  else begin
					case(cmd)
	//-------------------write_memory--------------------                    
						WRITE_CMD : begin
										if(mode == INCREMENT )begin
										   if(count_w <= 3'b001)begin
												add_2_mem <=local_address+count_w  ;
												count_w=count_w+3'b001;
												done <= 1'b1;
											end	
											else
												done <= 1'b0;
										end	
												
											/*if( count_w <= 3'b001)begin
												add_2_mem <=local_address+count_w  ;
												done <= 1'b1;
												count_w=count_w +3'b001;
											end
											else begin
											//add_2_mem <=local_address+count_w;
											done <= 1'b0;
											end
										end*/
									else begin
										//add_2_mem <=local_address;
										done <= 1'b0;
									end
									//done <= 1'b0;
												 
							 end 
											 
	//------------------read_memory----------------------                                
				  
						 READ_CMD: begin
										if(mode == INCREMENT )begin
											if(count_w <= 3'b001)begin
												add_2_mem <=local_address+count_w  ;
												count_w=count_w++3'b001;
												done <= 1'b1;
											end	
											else
												done <= 1'b0;
										end	
										else begin
										
										done <= 1'b0;
									   end
										
										
											/*if( count_w < 3'b010)begin
												add_2_mem <=local_address+count_w  ;
												done <= 1'b1;
												count_w=count_w +3'b001;
											end
											else 	done <= 1'b0;
										end
									else begin
										add_2_mem <=local_address;
										done <= 1'b0;
									end*/
									//done <= 1'b0;
												 
							 end 
							
	//----------------------read_line-------------------------
		
							READ_LINE_CMD: begin
						  if(count_line==3'b000)begin                               
							  //add_2_mem <= local_address;
									count_line ={1'b0,local_address[1:0]};
							  
							  //start from which word in line"00,01,10,11" 
						  end
							  else
								//add_2_mem = local_address;
								
									
					  //-------------increment_case
						  if(mode ==  INCREMENT || mode==RESERVED1|| mode==RESERVED1) begin
											//if(~(local_address[0]&local_address[1]))begin
							if(add_2_mem <= 4'b1111 && count_line <3'b100)begin //remove <=
 							   add_2_mem <= local_address+count_w;
							   done <= 1'b1;
							  count_w=count_w+1;
							   count_line = count_line+3'b001;                                                        
							end
							else begin
							   done <= 1'b0;
							   //count_line=3'b000;
							end 
													 
						 end  
					//--------------wrap_case                                 
						  else if(mode==WRAP)  begin
							if(~(local_address[0] || local_address[1]))begin
								 if(add_2_mem <= 4'b1111&& count_line < 3'b011)begin //remove 3'b100 
									 add_2_mem <= local_address+count_w;
									 count_w=count_w+1;
									 done <= 1'b1;
									 count_line=count_line+3'b001;                                                        
								 end
								 else begin
										done <= 1'b0;
													
										 //count_line=3'b000;
								  end 
							end
		
							else begin
							   if((add_2_mem <= 4'b1111)&& (count_line < 3'b011))begin //remove 3'b100
									add_2_mem <= local_address+count_w;
									done <= 1'b1;
									count_w=count_w+1;
									count_line=count_line+3'b001;                                                        
								end
								else begin
								   //if(local_address[1:0] > 2'b00)begin
									keep=local_address[1:0];
											  if(count_k < keep  ) begin
									add_2_mem <= local_address-{2'b00,keep}+count_k;
											  count_k=count_k+1;
											  done <= 1'b1;
											  end
											  else
												done <= 1'b0;
							   end
							
						 
						   end
					
								   
										
							end
			end
			
	//------------------read_mult_line----------------------------
							READ_MUL_CMD: begin
						  if(count_mul_line==4'b0000)begin                               
							  add_2_mem <= local_address;
									count_mul_line ={2'b00,local_address[1:0]};
							  
							  //start from which word in line"00,01,10,11" 
						  end
							  //else
								//add_2_mem = local_address;
								
									
					  //-------------increment_case
						  if(mode ==  INCREMENT || mode==RESERVED1|| mode==RESERVED1) begin
											//if(~(local_address[0]&local_address[1]))begin
							if(add_2_mem <= 4'b1111 && count_mul_line < 4'b1000)begin //<= 4'b1000 =>change last
							   add_2_mem <= local_address+count_w;
							   done <= 1'b1;
									 count_w=count_w+1;
							   count_mul_line = count_mul_line+4'b0001;                                                        
							end
							else begin
							   done <= 1'b0;
							   //count_line=3'b000;
							end 
													 
						 end  
					//--------------wrap_case                                 
						  else if(mode==WRAP)  begin
							if(~(local_address[0]|local_address[1]))begin
								 if(add_2_mem <= 4'b1111&& count_mul_line < 4'b0111)begin //<4'b1000 =>change last
									 add_2_mem <= local_address+count_w;
												count_w=count_w+1;
									 done <= 1'b1;
									 count_mul_line = count_mul_line+4'b0001;                                                        
								 end
								 else begin
										done <= 1'b0;
													
										 //count_line=3'b000;
								  end 
							end
		
							else begin
							   if(add_2_mem <= 4'b1111&& count_mul_line < 4'b0011)begin //<4'b0100 =>change last
									add_2_mem <= local_address+count_w;
									done <= 1'b1;
									count_w=count_w+1;
											  count_mul_line = count_mul_line+4'b0001;                                                       
								end
								else begin
								   //if(local_address[1:0] > 2'b00)begin
									keep=local_address[1:0];
											  if(count_k < keep  ) begin
									add_2_mem <= local_address-{2'b00,keep}+count_k;
											  count_k=count_k+1;
											  done <= 1'b1;
											  end
											  else
												  if(count_mul_line < 4'b0111)begin //<4'b1000 =>change last
													add_2_mem <= local_address+count_w;
													done <= 1'b1;
													count_w=count_w+1;
													count_mul_line = count_mul_line+4'b0001; 
														
												  end
												  else
													done <= 1'b0;
							   end
							
						 
						   end
					
								   
										
							end
						   
							
										

			 
	end
					default: add_2_mem <= local_address;
	//------------------------------------------------------------
		
	 endcase
					
					 
	  //---------------------------------------              
			  end 
			  end
			
			else 
			  add_2_mem <= add_2_mem;
			end   
		end	
		//else 
			//add_2_mem <=local_address;
	endmodule
