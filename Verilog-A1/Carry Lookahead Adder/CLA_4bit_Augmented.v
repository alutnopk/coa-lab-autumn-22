`timescale 1ns/1ps

module CLA_4bit_Augmented(
    input [3:0] A,
    input [3:0] B,
    input c_in,
    output [3:0] S,
    output P_prop,
    output G_prop,
);

/* Explaining the logic of Augmented Carry Look Ahead Adder
We define two variables G[3:0] (carry generate) and P[3:0] (carry propagate)

G[i] = A[i] & B[i] for i = 0 to 3
P[i] = A[i] ^ B[i] for i = 0 to 3

The output sum S[3:0] and carry output C[3:0] is defined as
C[0] = c_in
C[i+1] = G[i] | (P[i] & C[i]) for i = 0 to 2
S[i] = P[i] ^ C[i] for i = 0 to 3

We can expand this to get simplified equations 
C[0] = c_in
C[1] = G[0] | (P[0] & C[0]) = G[0] | (P[0] & c_in)
C[2] = G[1] | (P[1] & C[1]) = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c_in)
C[3] = G[2] | (P[2] & C[2]) = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c_in)

Now we calculate the block propoagate P_prop and generate G_prop
    P_prop = P[0] & P[1] & P[2] & P[3]
    G_prop = G[3] | (P[3] & C[3]) = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])

*/

    wire[3:0] G, P, C;

    //calculating G and P
    assign G = A & B;
    assign P = A ^ B;

    // calculating values of carry
    assign C[0] = c_in;
	assign C[1] = G[0] | (P[0] & C[0]);
	assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
	assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
	
    // finally calculating sum
    assign S = P ^ C;

    // calculating the block propogate and generate propogate
    assign P_prop = P[0] & P[1] & P[2] & P[3];
    assign G_prop = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
endmodule
