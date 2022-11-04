`timescale 1ns/1ps

module BranchingInstructions(
    input [5:0] function_code,
    input [1:0] branch,
    input clk,
    input rst,
    input negative,
    input zero,
    input carry,
    input [31:0] reg1_value,
    input [31:0] prog_count_in,
    input [31:0] branch_address, 
    output reg [31:0] prog_count_out,
    output reg [31:0] prog_count_next
);


/*
    OperationName    FunctionCode    Branch    BranchAddress       Prog_Count_out
    br                  000000       01        register             pc_in + 1
    bltz                000001       01        branch_address       pc_in + 1
    bz                  000010       01        branch_address       pc_in + 1
    bnz                 000011       01        branch_address       pc_in + 1 

    b                   000000       10        branch_address       pc_in + 1
    bcy                 000001       10        branch_address       pc_in + 1
    bncy                000010       10        branch_address       pc_in + 1

    bl                  000000       11        branch_address       pc_in + 1
*/
wire old_neg, old_carry, old_zero;


always @(posedge clk) begin
    if (rst) begin
        carry <= 0;
        negative <= 0;
        zero <= 0;
    end
    else begin
        old_carry <= carry;
        old_neg <= negative;
        old_zero <= zero;
    end
end

always @(*) begin
    prog_count_next <= prog_count_in + 32'd1;
    if (rst) prog_count_out <= 32'd0;
    else begin
        case (branch)
            2'b01: begin
                case(function_code)
                    6'b000000: begin
                        prog_count_out <= reg1_value;
                    end
                    6'b000001: begin
                        if (negative == 1'b1) begin
                            prog_count_out <= branch_address;
                        end
                        else begin
                            prog_count_out <= prog_count_in + 32'd1;
                        end
                    end
                    6'b000010: begin
                        if (zero == 1'b1) begin
                            prog_count_out <= branch_address;
                        end
                        else begin
                            prog_count_out <= prog_count_in + 32'd1;
                        end
                    end
                    6'b000011: begin
                        if (zero == 1'b0) begin
                            prog_count_out <= branch_address;
                        end
                        else begin
                            prog_count_out <= prog_count_in + 32'd1;
                        end
                    end
                    default: prog_count_out <= prog_count_in + 32'd1;
                endcase
            end

            2'b10: begin
                case(function_code)
                    6'b000000: begin
                        prog_count_out <= branch_address;
                    end
                    6'b000001: begin
                        if (carry == 1'b1) begin
                            prog_count_out <= branch_address;
                        end
                        else begin
                            prog_count_out <= prog_count_in + 32'd1;
                        end
                    end
                    6'b000001: begin
                        if (carry == 1'b0) begin
                            prog_count_out <= branch_address;
                        end
                        else begin
                            prog_count_out <= prog_count_in + 32'd1;
                        end
                    end
                    default: prog_count_out <= prog_count_in + 32'd1;
                endcase
            end

            2'b11: begin
                prog_count_out <= branch_address;
            end
            default prog_count_out <= prog_count_in + 32'd1;
        endcase
    end
end

endmodule