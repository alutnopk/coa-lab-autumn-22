`timescale 1ns/1ps

module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [4:0] shamt,
    input [3:0] alu_control_signal,
    output [31:0] out_from_ALU,
    output reg negative,
    output reg zero,
    output reg carry
);

    wire carry_from_sum;
    wire [31:0] sum, comp, AND, XOR, diff, sll, srl, sra;

	 ADD adder1(.input1(input1), .input2(input2), .sum(sum), .carry_from_sum(carry_from_sum));
    Complement complementvalue(.A(input2), .out(comp));
    //DIFF differingbit(.A(input1), .B(input2), .out(diff));
    bitwiseAND and1(.A(input1), .B(input2), .out(AND));
    bitwiseXOR xor1(.A(input1), .B(input2), .out(XOR));
    LeftShifter sll1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(sll));
    RightShifter srl1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(srl));
    ArithmeticRightShifter sra1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(sra));
    
    MUX_8to1 mux(sum, comp, diff, AND, XOR, sll, srl, sra, alu_control_signal, out_from_ALU);
    // flags change value when the output changes
    always @(out_from_ALU) begin
        if (out_from_ALU == 32'b0) zero = 1'b1;
        else zero = 1'b0;
        negative = out_from_ALU[31];
        carry = carry_from_sum;
    end 

endmodule