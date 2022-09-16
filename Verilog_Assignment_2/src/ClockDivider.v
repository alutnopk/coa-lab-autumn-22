`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:07 09/14/2022 
// Design Name: 
// Module Name:    ClockDivider 
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
module ClockDivider(
	input clk,
	output reg newclk
	);
	// dividing frequency 4MHz with 20Hz and taking log
	reg [20:0] temp_counter =21'b0;
	always @(posedge clk) begin
		temp_counter <= temp_counter + 20'd1;
		newclk = temp_counter[19];
	end
endmodule
