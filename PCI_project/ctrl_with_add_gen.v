`timescale 1ns / 1ps

module ctrl_with_add_gen(
frame,
clk,
rst,
ad,
cmd,
address_valid,
TRDY,IRDY,
Parity_check,
stop, 
DEVSEL,
EnableWrite,
signal_to_buf,
local_add,
add_2_mem
    );
//add_gen ports
input  [3:0] local_add;
output [3:0]  add_2_mem;

//-------------ctrl unit ports	 
input frame,clk,rst;
input [31:0]ad;
input [3:0] cmd;

input address_valid ;
input TRDY,IRDY,Parity_check;
//---------output
output stop;
output DEVSEL;
output EnableWrite;
output signal_to_buf;

//------------------------------
//wires

wire  rst_2_add_gen,update_gen,done_2_ctrl;
wire  [1:0] mode_2_gen;
wire  [3:0] cmd_2_gen;


 address_generator top_add_gen (
 .rst(rst_2_add_gen),
 .local_address (local_add), 
 .mode(mode_2_gen),
 .cmd(cmd_2_gen),
 .en(update_gen),
 .clk(clk),
 .done(done_2_ctrl),
 .add_2_mem(add_2_mem)
);


CTRL_gen  control(
			.frame(frame),
			.clk(clk),
			 .rst(rst),
			 .AD(ad),
			//inout PAR,
			 .Done(done_2_ctrl),
			 .CMD(cmd),
		   .ADDRESS_valid(address_valid), 	/* 	used when the address is valid 		*/
			. TRDY(TRDY),
			 .IRDY(IRDY),
			.Parity_check(Parity_check),
			 .Stop(stop),
			 .DEVSEL(DEVSEL),			/* used when the slave is selected 			*/
			//output reg memoryWRITE,
			. EnableWrite(EnableWrite),
			//output reg memoryReadLINE,
			//output reg memoryReadMUL,
			//output reg [31:0] ADDRESS_FF,
			//output reg read_address_cmd,
		   .update_add_gen(update_gen),
			.rst_gen(rst_2_add_gen),
			.mode(mode_2_gen),
			.CMD_out(cmd_2_gen),
			.write_on_bus_ctrl(signal_to_buf)
         );





endmodule
