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
module InstructionMemory(
	input clk,
	input[10:0] addr,
	output[31:0] dout
    );

InstructionMemory IM (
  .clka(clk), // input clka
  .addra(addr), // input [10 : 0] addra
  .douta(dout) // output [31 : 0] douta
);

endmodule
