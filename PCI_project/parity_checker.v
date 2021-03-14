`timescale 1ns / 1ps

module parity_checker(
    input [31:0] AD,
    input PAR,
    output Parity_check
    );
	wire par_bit;
	assign  par_bit = ^AD;
	assign Parity_check = (par_bit == PAR) ? 1'b1 : 1'b0;

endmodule
