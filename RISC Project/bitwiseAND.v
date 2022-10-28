`timescale 1ns/1ps

module bitwiseAND(
    input[31:0] A,
    input[31:0] B,
    output reg [31:0] out
);

    and a1(out,A,B);

endmodule