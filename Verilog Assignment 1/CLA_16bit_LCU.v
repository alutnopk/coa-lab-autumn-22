`timescale 1ns/1ps

module CLA_16bit_LCU(
    input [15:0] A,
    input [15:0] B,
    input c_in,
    output [15:0] S,
    output c_out,
    output P_out,
    output G_out
);
    wire [4:1] C; // wires for feeding carry to the respective augmented CLAs
    wire[3:0] G_prop, P_prop; // wires for inputting carry generate and propogate to Lookahead Carry Unit

    CLA_4bit_Augmented cla1(.A(A[3:0]), .B(B[3:0]), .c_in(c_in), .S(S[3:0]), .P_prop(P_prop[0]), .G_prop(G_prop[0]));
    CLA_4bit_Augmented cla2(.A(A[7:4]), .B(B[7:4]), .c_in(C[1]), .S(S[7:4]), .P_prop(P_prop[1]), .G_prop(G_prop[1]));
    CLA_4bit_Augmented cla3(.A(A[11:8]), .B(B[11:8]), .c_in(C[2]), .S(S[11:8]), .P_prop(P_prop[2]), .G_prop(G_prop[2]));
    CLA_4bit_Augmented cla4(.A(A[15:12]), .B(B[15:12]), .c_in(C[3]), .S(S[15:12]), .P_prop(P_prop[3]), .G_prop(G_prop[3]));

    LCUnit(.G(G_prop), .P(P_prop), .c_in(c_in), .C(C), .P_prop(P_out), .G_prop(G_out));
    assign c_out = C[4];

endmodule