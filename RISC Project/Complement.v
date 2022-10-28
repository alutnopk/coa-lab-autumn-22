`timescale 1ns/1ps

module Complement(
    input [31:0] A,
    output reg [31:0] out
);

    assign out = ~A + 1'b1;
endmodule