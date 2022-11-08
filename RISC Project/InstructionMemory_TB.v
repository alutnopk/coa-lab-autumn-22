`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:27:22 11/08/2022
// Design Name:   InstructionMemory
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC-Grp-12/InstructionMemory_TB.v
// Project Name:  KGP-miniRISC-Grp-12
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_TB;

	// Inputs
	reg clka;
	reg [10:0] addra;

	// Outputs
	wire [31:0] douta;
	
	integer i;

	// Instantiate the Unit Under Test (UUT)
	InstructionMemory uut (
		.clka(clka), 
		.addra(addra), 
		.douta(douta)
	);
	
	always #10 clka = ~clka;
	
	initial begin
		// Initialize Inputs
		clka = 0;
		addra = 0;

		// Wait 100 ns for global reset to finish
		#10;
      
		for(i=0; i<32; i=i+1)
		begin
			addra = i;
			#20;
		end
	end
      
endmodule

