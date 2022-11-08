`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:21:30 11/07/2022
// Design Name:   ALU
// Module Name:   C:/Users/KP/Desktop/code/ise/KGP-miniRISC/ALU_TB.v
// Project Name:  KGP-miniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_TB;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg [4:0] shamt;
	reg [3:0] alu_control_signal;

	// Outputs
	wire [31:0] out_from_ALU;
	wire negative;
	wire zero;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.input1(input1), 
		.input2(input2), 
		.shamt(shamt), 
		.alu_control_signal(alu_control_signal), 
		.out_from_ALU(out_from_ALU), 
		.negative(negative), 
		.zero(zero), 
		.carry(carry)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		shamt = 0;
		alu_control_signal = 0;
		#100;
		
		input1 = 32'd32;
		input2 = 32'd53;
		shamt = 5'd0;
		alu_control_signal = 4'd0;
		#100;
		
		input1 = 32'd32;
		input2 = 32'd53;
		shamt = 5'd0;
		alu_control_signal = 4'd1;
		#100;
		
		input1 = 32'd30;
		input2 = 32'd312;
		shamt = 5'd0;
		alu_control_signal = 4'd2;
		#100;
		
		input1 = 32'd32;
		input2 = 32'd452;
		shamt = 5'd0;
		alu_control_signal = 4'd3;
		#100;
		
		input1 = 32'd31;
		input2 = 32'd32;
		shamt = 5'd0;
		alu_control_signal = 4'd4;
		#100;
		
		input1 = 32'd302;
		input2 = 32'd32;
		shamt = 5'd1;
		alu_control_signal = 4'd5;
		#100;
        
		// Add stimulus here

	end
      
endmodule

