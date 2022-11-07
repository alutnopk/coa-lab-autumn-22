`timescale 1ns/1ps

module Mem_To_Reg_Selector(
    input [1:0] mem_to_reg,
    input [31:0] out_from_ALU,
    input [31:0] data_out,
    input [31:0] prog_count,
    output reg [31:0] data_write,
);

    always @(*) begin
        case (mem_to_reg)
            2'b01: data_write <= data_out;
            2'b10: data_write <= prog_count;
            default: data_write <= out_from_ALU;
        endcase
    end

endmodule