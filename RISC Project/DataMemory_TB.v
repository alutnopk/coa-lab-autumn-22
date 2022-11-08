`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:02:40 11/09/2022
// Design Name:   DataMemory
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC-Grp-12/DataMemory_TB.v
// Project Name:  KGP-miniRISC-Grp-12
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DataMemory_TB;

	// Inputs
	reg clka;
	reg ena;
	reg [0:0] wea;
	reg [10:0] addra;
	reg [31:0] dina;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	DataMemory uut (
		.clka(clka), 
		.ena(ena), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);
	always #10 clka = ~clka;
	initial begin
		// Initialize Inputs
		clka = 0;
		ena = 1;
		wea = 1;
		addra = 11'd23;
		dina = 32'd69;

		#50;
		addra = 11'd24;
		dina = 32'd70;
		#50;
		wea = 0;
		addra = 11'd23;
      #50;
		
		// Add stimulus here

	end
      
endmodule

