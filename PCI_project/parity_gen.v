`timescale 1ns / 1ps

module parity_gen(
    input [31:0] Data,
    output parity_gen_bit
    );

assign parity_gen_bit = ^Data;

endmodule
