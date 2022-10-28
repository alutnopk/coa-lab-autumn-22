`timescale 1ns/1ps

module DIFF(
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] out
);

    // out is the LSB at which A and B differ
    wire[31:0] xor1;
    assign xor1 = A ^ B;
    wire[4:0] count;
    assign count = 5'b0;
    integer i;
    for(i = 0; i <= 5'b11111; i = i + 1) begin
        if (xor1[0] == 1'b1) break;
        else begin
            count = count + 1;
            xor1 = xor1 >> 1;
        end
    end
    assign out = count;
endmodule