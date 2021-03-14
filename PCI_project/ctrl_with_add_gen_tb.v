`timescale 1ns / 1ps

module ctrl_with_add_gen_tb();


reg  [3:0] local_add;
wire [3:0]  add_2_mem;

//-------------ctrl unit ports	 
reg  frame,clk,rst;
reg  [31:0]ad;
reg  [3:0] cmd;
reg  address_valid ;
reg  TRDY,IRDY,Parity_check;
//---------output
wire stop;
wire DEVSEL;
wire EnableWrite;
wire signal_to_buf;





ctrl_with_add_gen uut (
.frame(frame),
.clk(clk),
.rst(rst),
.ad(ad),
.cmd(cmd),
.address_valid(address_valid),
.TRDY(TRDY),
.IRDY(IRDY),
.Parity_check(Parity_check),
.stop(stop), 
.DEVSEL(DEVSEL),
.EnableWrite(EnableWrite),
.signal_to_buf(signal_to_buf),
.local_add(local_add),
.add_2_mem(add_2_mem)
    );


	initial begin
		clk=1'b1;
		forever #10 clk=~clk;
	end
	initial begin
	   //----------read_memory
		rst=1'b0;
		#40
		
		rst=1'b1;
		frame=1'b1;
		ad=32'h00000000;
		cmd =4'b0111; //write
		//mode=2'b00;   //mode_increment
		address_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		local_add=4'b0000;
		#20
		
		
		rst=1'b1;
		frame=1'b0;
		ad=32'h00000400;
		cmd =4'b0111; //write
		//mode=2'b00;   //mode_increment
		address_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		local_add=4'b0000;
		#20
		
		rst=1'b1;
		frame=1'b0;
		ad=32'hff000800;
		cmd =4'b0111; //write
		//mode=2'b00;   //mode_increment
		address_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		local_add=4'b0000;
		//-------------------read_line
		rst=1'b0;
		#40
		rst=1'b1;
		frame=1'b0;
		ad=32'h00000400;
		cmd =4'b1110; //read_memory
		//mode=2'b00;   //mode_increment
		address_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		local_add=4'b0000;
		#20
		//---------------read_mul_line
		rst=1'b0;
		#40
		rst=1'b1;
		frame=1'b0;
		ad=32'h00000400;
		cmd =4'b1100; //read_memory
		//mode=2'b00;   //mode_increment
		address_valid=1'b1; //matched
		TRDY=1'b0;
      IRDY=1'b0;
		Parity_check=1'b1;
		local_add=4'b0000;
		
		
		
		
		
		
		
		
	end

endmodule
