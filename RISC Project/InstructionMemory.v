`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:13:51 11/08/2022 
// Design Name: 
// Module Name:    InstructionMemory 
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
module Instruction(
	input clka,
	input[10:0] addra,
	output[31:0] douta
    );

InstructionMemory IM (
  .clka(clka), // input clka
  .addra(addra), // input [10 : 0] addra
  .douta(douta) // output [31 : 0] douta
);

endmodule
