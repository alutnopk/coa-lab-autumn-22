`timescale 1ns/1ps

module MUX_8to1(
    input [31:0] i1,
    input [31:0] i2,
    input [31:0] i3,
    input [31:0] i4,
    input [31:0] i5,
    input [31:0] i6,
    input [31:0] i7,
    input [31:0] i8,
    input [3:0] alu_control_signal,
    output reg [31:0] out
);

    always @(*) begin
        case(alu_control_signal)
            4'b0000: out = i1;
            4'b0001: out = i2;
            4'b0010: out = i3;
            4'b0011: out = i4;
            4'b0100: out = i5;
            4'b0101: out = i6;
            4'b0110: out = i7;
            4'b0111: out = i8;
            4'b1001: out = i6;
            4'b1000: out = i7;
            4'b1010: out = i8;
            default: out = i1;
        endcase
    end

endmodule
