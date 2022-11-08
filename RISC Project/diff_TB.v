`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:31:49 11/07/2022
// Design Name:   DIFF
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC/diff_TB.v
// Project Name:  KGP-miniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DIFF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module diff_TB;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	DIFF uut (
		.A(A), 
		.B(B), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
		A = 32'd63;
		B = 32'd96;
		#100;
		
		A = 32'd4;
		B = 32'd8;
		#100
		
		A = 32'd4;
		B = 32'd4;
        
		// Add stimulus here

	end
      
endmodule

