`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:38:56 11/07/2022
// Design Name:   ADD
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC/adder_TB.v
// Project Name:  KGP-miniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ADD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adder_TB;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;

	// Outputs
	wire [31:0] sum;
	wire carry_from_sum;

	// Instantiate the Unit Under Test (UUT)
	ADD uut (
		.input1(input1), 
		.input2(input2), 
		.sum(sum), 
		.carry_from_sum(carry_from_sum)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		input1 = 'd32;
		input2 = 'd32;
		#100
		
		input1 = 'd45;
		input2 = 'd42;
        
		// Add stimulus here

	end
      
endmodule

