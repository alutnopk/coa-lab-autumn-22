`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:46 09/14/2022 
// Design Name: 
// Module Name:    AddbyOne 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AddbyOne(
	input [3:0] count, output [3:0] out
    );
	 
	 wire [3:0] P;
	 wire [3:0] C;
	 // we use the CLA in previous assigment but with fixed value of 2nd operand as 4'b0000
	 // we input the value of c_in as 1
	 assign P = count;
	 assign C[0] = 1'b1;
	 // G in CLA is assigned value A & B but since B == 0, G = 0
	 // so the updated values of C are as follows
	 assign C[1] = P[0];
	 assign C[2] = P[1] & P[0] & C[0];
	 assign C[3] = P[2] & P[1] & P[0] & C[0];
	 // assign c_out = P[3] & P[2] & P[1] & P[0] & C[0];
	 
	 assign out = P^C;
endmodule
