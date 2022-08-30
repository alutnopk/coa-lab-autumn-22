`timescale 1ns/1ps

module RCA_16bit(
    input [15:0] a,
    input [15:0] b,
    input c_in,
    output [15:0] sum,
    output c_out
);

    wire carry;
    RCA_8bit rca1(a[7:0], b[7:0], c_in, sum[7:0], carry);
    RCA_8bit rca2(a[15:8], b[15:8], carry, sum[15:8], c_out);

endmodule