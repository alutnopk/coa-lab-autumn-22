`timescale 1ns/1ps

module RightShifter(
    input [31:0] A,
    input [31:0] B,
    input [3:0] alu_control_signal,
    input [4:0] shamt,
    output [31:0] out
);
    wire [31:0] shift_amt;
    assign shift_amt = (alu_control_signal[3] == 1'b1 && alu_control_signal != 4'b1111) ? B : {27'b0,shamt};
    assign out = A >> shift_amt;

endmodule

