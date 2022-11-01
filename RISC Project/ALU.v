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
    wire [31:0] sum, comp, bitwiseAND, bitwiseXOR, 
    ADD adder1(.input1(input1), .input2(input2), .sum(sum), .carry_from_sum(carry_from_sum));
    Complement comp(.A(input2), .out(out));
    DIFF diff(.A(input1), .B(input2), .out(out));
    bitwiseAND and1(.A(input1), .B(input2), .out(out));
    bitwiseXOR xor1(.A(input1), .B(input2), .out(out));
    LeftShifter sll1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
    RightShifter srl1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
    ArithmeticRightShifter sra1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
    RightShifter srl2(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
    LeftShifter sll1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
    ArithmeticRightShifter sra2(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));


    always @(*) begin
        case(alu_control_signal[3:0])
            4'b0000: ADD adder1(.input1(input1), .input2(input2), .sum(sum), .carry_from_sum(carry_from_sum));
            4'b0001: Complement comp(.A(input2), .out(out));
            4'b0010: DIFF diff(.A(input1), .B(input2), .out(out));
            4'b0011: bitwiseAND and1(.A(input1), .B(input2), .out(out));
            4'b0100: bitwiseXOR xor1(.A(input1), .B(input2), .out(out));
            4'b0101: LeftShifter sll1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b0110: RightShifter srl1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b0111: ArithmeticRightShifter sra1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b1000: RightShifter srl2(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b1001: LeftShifter sll1(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
            4'b1010: ArithmeticRightShifter sra2(.A(input1), .B(input2), .alu_control_signal(alu_control_signal), .shamt(shamt), .out(out));
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