`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:26:57 11/08/2022
// Design Name:   Register_Module
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC-Grp-12/REGF_TB.v
// Project Name:  KGP-miniRISC-Grp-12
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Register_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module REGF_TB;

	// Inputs
	reg [4:0] reg1_index;
	reg [4:0] reg2_index;
	reg [1:0] reg_write;
	reg [31:0] data_write;
	reg [4:0] show_index;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] reg1_value;
	wire [31:0] reg2_value;
	wire [31:0] reg_return;

	// Instantiate the Unit Under Test (UUT)
	Register_Module uut (
		.reg1_index(reg1_index), 
		.reg2_index(reg2_index), 
		.reg_write(reg_write), 
		.data_write(data_write), 
		.clk(clk), 
		.rst(rst), 
		.show_index(show_index),
		.reg1_value(reg1_value), 
		.reg2_value(reg2_value), 
		.reg_return(reg_return)
	);
	always #100 clk = ~clk;
	initial begin
		$monitor ("reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, reg31 = %d", 
			$signed(uut.register_list[0]), 
			$signed(uut.register_list[1]), 
			$signed(uut.register_list[2]), 
			$signed(uut.register_list[3]), 
			$signed(uut.register_list[31])
			);
			
		// Initialize Inputs
		reg1_index = 0;
		reg2_index = 0;
		reg_write = 0; 
		data_write = 0;
		show_index = 0;
		clk = 0;
		rst = 1;
		
		$monitor ("reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, reg31 = %d", 
			$signed(uut.register_list[0]), 
			$signed(uut.register_list[1]), 
			$signed(uut.register_list[2]), 
			$signed(uut.register_list[3]), 
			$signed(uut.register_list[31])
			);
			
		// Wait 100 ns for global reset to finish
		#100;
        
		rst = 0;

		// Add stimulus here
		reg1_index = 5'd1;
		reg2_index = 5'd2;
		reg_write = 2'b10;
		show_index = 5'd1;
		data_write = 32'd16;

$monitor ("reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, reg31 = %d", 
			$signed(uut.register_list[0]), 
			$signed(uut.register_list[1]), 
			$signed(uut.register_list[2]), 
			$signed(uut.register_list[3]), 
			$signed(uut.register_list[31])
			);
			
		#100;

		reg1_index = 5'd1;
		reg2_index = 5'd2;
		reg_write = 2'b11;
		data_write = 32'd22;
		$monitor ("reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, reg31 = %d", 
			$signed(uut.register_list[0]), 
			$signed(uut.register_list[1]), 
			$signed(uut.register_list[2]), 
			$signed(uut.register_list[3]), 
			$signed(uut.register_list[31])
			);
		#100;
		show_index = 5'd2;

		#100;

		reg1_index = 5'd1;
		reg2_index = 5'd2;
		reg_write = 2'b00;
		$monitor ("reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, reg31 = %d", 
			$signed(uut.register_list[0]), 
			$signed(uut.register_list[1]), 
			$signed(uut.register_list[2]), 
			$signed(uut.register_list[3]), 
			$signed(uut.register_list[31])
			);
			

		#100;

		reg1_index = 5'd1;
		reg_write = 2'b10;
		data_write = 32'd20;
		show_index = 5'd1;
		$monitor ("reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, reg31 = %d", 
			$signed(uut.register_list[0]), 
			$signed(uut.register_list[1]), 
			$signed(uut.register_list[2]), 
			$signed(uut.register_list[3]), 
			$signed(uut.register_list[31])
			);
			
		#100;

		reg_write= 2'b01;
		data_write = 32'd9;
		show_index = 5'd31;
		reg2_index = 5'd1;
$monitor ("reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, reg31 = %d", 
			$signed(uut.register_list[0]), 
			$signed(uut.register_list[1]), 
			$signed(uut.register_list[2]), 
			$signed(uut.register_list[3]), 
			$signed(uut.register_list[31])
			);
	end
      
endmodule

