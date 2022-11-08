`timescale 1ns/1ps
module RCA_32bit(
    input [31:0] a,
    input [31:0] b,
    input c_in,
    output [31:0] sum,
    output c_out
);
    wire carry;
    RCA_16bit rca1(a[15:0], b[15:0], c_in, sum[15:0], carry);
    RCA_16bit rca2(a[31:16], b[31:16], carry, sum[31:16], c_out);
endmodule