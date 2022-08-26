`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    FullAdder 
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
module RCA_8bit(input [7:0] a, input [7:0] b, input c_in, output[7:0] sum, output c_out);

    wire [6:0] carry; // this will be used for carry
    FullAdder fa1(a[0], b[0], c_in, sum[0], carry[0]);
    FullAdder fa2(a[1], b[1], carry[0], sum[1], carry[1]);
    FullAdder fa3(a[2], b[2], carry[1], sum[2], carry[2]);
    FullAdder fa4(a[3], b[3], carry[2], sum[3], carry[3]);
    FullAdder fa5(a[4], b[4], carry[3], sum[4], carry[4]);
    FullAdder fa6(a[5], b[5], carry[4], sum[5], carry[5]);
    FullAdder fa7(a[6], b[6], carry[5], sum[6], carry[6]);
    FullAdder fa8(a[7], b[7], carry[6], sum[7], c_out);

endmodule