`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:53:40 11/08/2022
// Design Name:   KGP_RISC
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC-Grp-12/KGP_RISC_TB.v
// Project Name:  KGP-miniRISC-Grp-12
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: KGP_RISC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module KGP_RISC_TB;

	// Inputs
	reg clk;
	reg rst;
	reg [4:0] show_index;

	// Outputs
	wire [31:0] Register_return;

	// Instantiate the Unit Under Test (UUT)
	KGP_RISC uut (
		.clk(clk), 
		.rst(rst), 
		.show_index(show_index),
		.Register_return(Register_return)
	);
	
	always #10 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		show_index = 0;
		$monitor("reg0 = %d\t, reg1 = %d\t, reg2 = %d\t, reg3 = %d\t, reg4 = %d\t, reg5 = %d\t, reg6 = %d\t, reg11 = %d\t, reg12 = %d\t", 
			$signed(uut.REGF.register_list[0]),
			$signed(uut.REGF.register_list[1]),
			$signed(uut.REGF.register_list[2]),
			$signed(uut.REGF.register_list[3]),
			$signed(uut.REGF.register_list[4]),
			$signed(uut.REGF.register_list[5]),
			$signed(uut.REGF.register_list[6]),
			$signed(uut.REGF.register_list[11]),
			$signed(uut.REGF.register_list[12]),
			);
		// Wait 10 ns for global reset to finish
		#100;
		
        
		// Add stimulus here
		rst = 0;
		show_index = 5'd2;
		
		#100;
		show_index = 5'd1;
		
	end
      
endmodule

