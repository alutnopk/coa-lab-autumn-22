`timescale 1ns/1ps

module bitwiseAND(
    input[31:0] A,
    input[31:0] B,
    output [31:0] out
);

    assign out = A & B;

endmodule