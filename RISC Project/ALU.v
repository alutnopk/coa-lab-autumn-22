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
    wire [31:0] sum, XOR, AND, comp, sll, srl, sla, diff;
    wire carry_from_sum;

    wire c_out;
    wire [1:0] G_out, P_out;
    CLA_16bit_LCU adder1(.A(input1[15:0]), .B(input2[15:0]), .c_in(1'b0), .S(sum[15:0]), .c_out(c_out), .P_out(P_out[0]), .G_out(G_out[0]));
    CLA_16bit_LCU adder2(.A(input1[31:16]), .B(input2[31:16]), .c_in(c_out), .S(sum[31:16]), .c_out(carry_from_sum), .P_out(P_out[1]), .G_out(G_out[1]));

    assign XOR = input1 ^ input2;
    assign AND = input1 & input2;
    assign comp = ~input1 + 1'b1;

    assign diff = ;

    assign shift_amt = (control[3] == 1'b1 and control != 4'b1111) ? input2 : {27'b0,shamt};
    assign sll = input1 << shift_amt;
    assign srl = input1 >> shift_amt;
    assign sra = input1 >>> shift_amt;

    always @(*) begin
        case(control[3:0])
            4'b0000: begin
                out = sum;
                carry = carry_from_sum;
            end
            4'b0001: out = comp;
            4'b0010: out = diff;
            4'b0011: out = AND;
            4'b0100: out = XOR;
            4'b0101: out = sll;
            4'b0110: out = srl;
            4'b0111: out = sra;
            4'b1000: out = srl;
            4'b1001: out = sll;
            4'b1010: out = sra;
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