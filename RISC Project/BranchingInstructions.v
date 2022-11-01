`timescale 1ns/1ps

module BranchingInstructions(
    input [5:0] function_code,
    input branch,
    input clk,
    input rst,
    input negative,
    input zero,
    input carry,
    input [31:0] prog_count_in,
    input [31:0] branch_address, 
    output reg [31:0] prog_count_out
);


/*
    OperationName    FunctionCode    Branch    BranchAddress       Prog_Count_out
    br                  000000        1        register             pc_in + 1
    bltz                000001        1        branch_address       pc_in + 1
    bz                  000010        1        branch_address       pc_in + 1
    bnz                 000011        1        branch_address       pc_in + 1

    b                   000000        1        branch_address       pc_in + 1
    bcy                 000001        1        branch_address       pc_in + 1
    bncy                000010        1        branch_address       pc_in + 1

    bl                  000000        1        branch_address       pc_in + 1
*/

always @(posedge clk) begin
    if (rst) begin
        carry <= 0;
        negative <= 0;
        zero <= 0;
    end
    else begin





    end



endmodule