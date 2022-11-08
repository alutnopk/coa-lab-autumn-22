`timescale 1ns/1ps

module CLA_16bit_Ripple(
    input [15:0] A,
    input [15:0] B,
    input c_in,
    output [15:0] S,
    output c_out
);

    wire[2:0] carry; // this will be used to store the carry bits from the 4bit adders

    CLA_4bit cla1(.A(A[3:0]), .B(B[3:0]), .c_in(c_in), .S(S[3:0]), .c_out(carry[0]));
    CLA_4bit cla2(.A(A[7:4]), .B(B[7:4]), .c_in(carry[0]), .S(S[7:4]), .c_out(carry[1]));
    CLA_4bit cla3(.A(A[11:8]), .B(B[11:8]), .c_in(carry[1]), .S(S[11:8]), .c_out(carry[2]));
    CLA_4bit cla4(.A(A[15:12]), .B(B[15:12]), .c_in(carry[2]), .S(S[15:12]), .c_out(c_out));

endmodule