`timescale 1ns/1ps

module bitwiseXOR(
    input[31:0] A,
    input[31:0] B,
    output reg [31:0] out
);

    xor x1(out,A,B);

endmodule