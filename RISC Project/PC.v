`timescale 1ns/1ps

module PC(
    input [31:0] input_pc,
    input clk,
    input rst,
    output reg [31:0] output_pc
    );

    always @(posedge clk) begin
        if (rst) output_pc <= 0;
        else output_pc <= input_pc;
    end
endmodule 