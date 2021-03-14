`timescale 1ns / 1ps

module address_generator_tb( );
reg [3:0]     local_address;
reg [3:0]     cmd;
reg [1:0]     mode;
reg           en,clk,rst;
wire [3:0]    add_2_mem;
wire          done;

address_generator uut(.rst(rst),
.local_address(local_address),
 .mode(mode),
 .cmd(cmd),.en(en),
 .clk(clk),
 .done(done),
 .add_2_mem(add_2_mem)
);
    initial begin
        clk=1'b1;
        forever #10 clk=~clk;
    end
    initial begin
      /*  rst =1'b0;
        #30
  //--------------READ_CMD = 4'b0110--------------------      
		  en=1'b0;
		  rst =1'b1;
        cmd=4'b0110;
        local_address=4'b0000;
        mode=2'b00;
		  #20
		   en=1'b1;
			#20
			 en=1'b0;
        
		  #240
        rst =1'b0;
		  #50
		  rst =1'b1;
        cmd=4'b0110;
        local_address=4'b0000;
        mode=2'b01;
		  #240
		  */
 //-----------------READ_LINE_CMD = 4'b1110----------------------      
		 rst =1'b0;
        #30     
		  en=1'b0;
		  rst =1'b1;
		//test_increment at "read_line_cmd"
		
        cmd=4'b1110;   //read_line_cmd
        local_address=4'b0001;
        mode=2'b01; //increment mode
		   #20
		   en=1'b1;
			#20
			 en=1'b0;
/*		  
		  #120
		  rst =1'b0;
		  #50
       
		  
		  //test wrab_at "read_line_cmd"
		   rst =1'b1;
        cmd=4'b1110;   //read_line_cmd
        local_address=4'b0011;
        mode=2'b10; //wrab mode
        #240
//------------------------READ_MUL_CMD = 4'b1100
	     rst =1'b0;
		  #50
		  //test increment_at "read__mul_line_cmd"
		   rst =1'b1;
        cmd=4'b1100;   //read_line_cmd
        local_address=4'b0010;
        mode=2'b00; //wrab mode
        #240
		  //----------------
		  rst =1'b0;
		  #50
		  //test wrab_at "read__mul_line_cmd"
		   rst =1'b1;
        cmd=4'b1100;   //read_line_cmd
        local_address=4'b0010;
        mode=2'b10; //wrab mode
		  #240
		  //-----------
		  rst =1'b0;
		  #50
		  //test wrab_at "read__mul_line_cmd"
		   rst =1'b1;
        cmd=4'b1100;   //read_line_cmd
        local_address=4'b0000;
        mode=2'b10; //wrab mode
        
		  
      */  
    end
endmodule
