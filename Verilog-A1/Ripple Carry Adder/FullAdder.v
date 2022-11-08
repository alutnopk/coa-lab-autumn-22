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
module FullAdder(input a,input b,input c_in,output sum,output c_out);
    wire g2_out,g3_out,g4_out;
    xor g1(sum,a,b,c_in);
    and g2(g2_out,a,b);
    xor g3(g3_out,a,b);
    and g4(g4_out,g3_out,c_in);
    or  g5(c_out,g2_out,g4_out);
endmodule