`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:03:28 11/08/2022 
// Design Name: 
// Module Name:    DataMemory 
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
module Data(
	input clka,
	input ena,
	input wea,
	input [10:0] addra,
	input [31:0] dina,
	output [31:0] douta
    );

DataMemory DM (
  .clka(~clka), // input clka
  .ena(ena), // input ena
  .wea(wea), // input [0 : 0] wea
  .addra(addra), // input [10 : 0] addra
  .dina(dina), // input [31 : 0] dina
  .douta(douta) // output [31 : 0] douta
);

endmodule
