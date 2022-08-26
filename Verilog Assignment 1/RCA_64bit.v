`timescale 1ns/1ps

module RCA_64bit(
    input [63:0] a,
    input [63:0] b,
    input c_in,
    output [63:0] sum,
    output c_out
);
    wire carry;
    RCA_32bit rca1(a[31:0], b[31:0], c_in, sum[31:0], carry);
    RCA_32bit rca2(a[63:32], b[63:32], carry, sum[63:32], c_out);
endmodule