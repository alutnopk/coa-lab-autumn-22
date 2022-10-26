`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:15 09/14/2022 
// Design Name: 
// Module Name:    bitCounter 
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
module bitCounter(
input clk,
input rstn,
output reg [3:0] count
    );
	 wire newclk;
	 initial count = 0;
	 
	 //always @ (posedge clk) begin
	ClockDivider cd(.clk(clk), .newclk(newclk));
	 //nd
	  // for asynchronous reset, we add rstn in always condition
	  // reset is linked to p108
	 always@ (posedge(newclk), posedge(rstn))
		begin
		 if (rstn) count <= 4'b0000;
		 else if (count == 4'b1111) count <= 4'b0000;
		 else count <= count + 1;
		end
endmodule
