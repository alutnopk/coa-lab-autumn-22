`timescale 1ns/1ps

module ALU(
    input signed [31:0] input1,
    input [31:0] input2,
    input [4:0] shamt,
    input [3:0] alu_control_signal,
    output reg [31:0] out,
    output reg negative,
    output reg zero,
    output reg carry
);

    wire carry_from_sum;
    always @(*) begin
        case(alu_control_signal[3:0])
            4'b0000: ADD adder1(.input1(input1), .input2(input2), .sum(sum), .carry_from_sum(carry_from_sum));
            4'b0001: Complement comp(.A(input1), .out(out));
            4'b0010: DIFF diff(.A(input1), .B(input2), .out(out));
            4'b0011: bitwiseAND and1(.A(input1), .B(input2), .out(out));
            4'b0100: bitwiseXOR xor1(.A(input1), .B(input2), .out(out));
            4'b0101: LeftShifter sll(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b0110: RightShifter sll(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b0111: ArithmeticRightShifter sll(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b1000: RightShifter sll(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b1001: LeftShifter sll(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b1010: ArithmeticRightShifter sll(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            default: out = 32'b0;
        endcase
    end

    // flags change value when the output changes
    always @(out) begin
        if (out == 32'b0) zero = 1'b1;
        else zero = 1'b0;
        negative = out[31];
    end 

endmodule