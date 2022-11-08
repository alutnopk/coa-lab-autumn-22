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
module DataMemory(
	input clk,
	input enable,
	input write_enable,
	input [31:0] addr,
	input [31:0] din,
	output [31:0] dout
    );

DataMemory DM (
  .clka(clk), // input clka
  .ena(enable), // input ena
  .wea(write_enable), // input [0 : 0] wea
  .addra(addr[10:0]), // input [10 : 0] addra
  .dina(din), // input [31 : 0] dina
  .douta(dout) // output [31 : 0] douta
);

endmodule
