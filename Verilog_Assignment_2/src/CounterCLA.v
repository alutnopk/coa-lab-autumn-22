`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:38 09/14/2022 
// Design Name: 
// Module Name:    CounterCLA 
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
module CounterCLA(
input clk,
input rstn,
output [3:0] count
    );
	 
	wire newclk;
	wire [3:0] Q, Qbar, temp_out;
	
	//always @ (posedge clk) begin
	ClockDivider cd(.clk(clk), .newclk(newclk));
	// for asynchronous reset, we add rstn in always condition
	//end
	DFF dff1(.d(temp_out[0]), .clk(newclk), .rstn(rstn), .q(Q[0]), .qbar(Qbar[0]));
	DFF dff2(.d(temp_out[1]), .clk(newclk), .rstn(rstn), .q(Q[1]), .qbar(Qbar[1]));
	DFF dff3(.d(temp_out[2]), .clk(newclk), .rstn(rstn), .q(Q[2]), .qbar(Qbar[2]));
	DFF dff4(.d(temp_out[3]), .clk(newclk), .rstn(rstn), .q(Q[3]), .qbar(Qbar[3]));

	assign count = Q;
	AddbyOne ad1(count,temp_out);
	 
endmodule