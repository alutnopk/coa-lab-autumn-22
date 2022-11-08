`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:35:27 11/07/2022
// Design Name:   MainControl
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC/MCU_TB.v
// Project Name:  KGP-miniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MainControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MCU_TB;

	// Inputs
	reg [5:0] opcode;

	// Outputs
	wire [1:0] reg_write;
	wire mem_read;
	wire mem_write;
	wire [1:0] branch;
	wire mem_to_reg;
	wire [2:0] alu_op;
	wire alu_src;

	// Instantiate the Unit Under Test (UUT)
	MainControl uut (
		.opcode(opcode), 
		.reg_write(reg_write), 
		.mem_read(mem_read), 
		.mem_write(mem_write), 
		.branch(branch), 
		.mem_to_reg(mem_to_reg), 
		.alu_op(alu_op), 
		.alu_src(alu_src)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;

		// Wait 100 ns for global reset to finish
		#100;
		opcode = 6'd0;
		#100;
		opcode = 6'd1;
		#100;
		opcode = 6'd2;
		#100;
		opcode = 6'd3;
		#100;
		opcode = 6'd4;
		#100;
		opcode = 6'd5;
		#100;
		opcode = 6'd6;
		#100;
		opcode = 6'd7;
		#100;
		opcode = 6'd8;
		#100;
		opcode = 6'd9;
		#100;
        
		// Add stimulus here

	end
      
endmodule

