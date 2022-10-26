`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:35 09/14/2022 
// Design Name: 
// Module Name:    DFF 
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
module DFF(d,clk,rstn,q,qbar); 
	input d, clk, rstn; 
	output reg q, qbar; 
	always @(posedge clk) 
	begin
		if(rstn== 1)begin
			q <= 0;
			qbar <= 1;
			end
		else begin
			q <= d; 
			qbar <= ~d;
end			
	end 
endmodule
