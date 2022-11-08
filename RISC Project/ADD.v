`timescale 1ns/1ps

module ADD(
    input [31:0] input1,
    input [31:0] input2,
    output [31:0] sum,
    output carry_from_sum
);

    wire c_out;
    wire [1:0] G_out, P_out;
    CLA_16bit_LCU adder1(.A(input1[15:0]), .B(input2[15:0]), .c_in(1'b0), .S(sum[15:0]), .c_out(c_out), .P_out(P_out[0]), .G_out(G_out[0]));
    CLA_16bit_LCU adder2(.A(input1[31:16]), .B(input2[31:16]), .c_in(c_out), .S(sum[31:16]), .c_out(carry_from_sum), .P_out(P_out[1]), .G_out(G_out[1]));

endmodule