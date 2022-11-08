`timescale 1ns/1ps

module LCUnit(
    input[3:0] G,
    input [3:0] P,
    input c_in,
    output [4:1] C,
    output P_prop,
    output G_prop
);
/* Explaining the logic of Logic of LookaheadCarryUnit
C[0] = c_in
C[i+1] = G[i] | (P[i] & C[i]) for i = 0 to 3

We can expand this to get simplified equations 
C[1] = G[0] | (P[0] & C[0]) = G[0] | (P[0] & c_in)
C[2] = G[1] | (P[1] & C[1]) = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c_in)
C[3] = G[2] | (P[2] & C[2]) = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c_in)
C[4] = G[3] | (P[3] & C[3]) = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & c_in)

Now we calculate the block propoagate P_prop and generate G_prop
    P_prop = P[0] & P[1] & P[2] & P[3]
    G_prop = G[3] | (P[3] & C[3]) = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])

*/

	assign C[1] = G[0] | (P[0] & c_in);
	assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
	assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
	assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
    
    // calculating the block propogate and generate propogate
    assign P_prop = P[0] & P[1] & P[2] & P[3];
    assign G_prop = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])

endmodule