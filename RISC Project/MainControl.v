`timescale 1ns/1ps

module MainControl(
    input [5:0] opcode,
    output reg [1:0] reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg mem_to_reg,
    output reg [2:0] alu_op,
    output reg alu_src
);

/*
    Assign the values of the control signals based on the opcode
    OPCODE   ALUSrc   ALUOp   MemtoReg   RegWrite   MemRead   MemWrite   Branch
    000000   1        001     0          10          0         0          0
    000001   1        010     0          10          0         0          0
    000010   1        011     0          10          0         0          0
    000011   1        000     X          00          0         0          1
    000100   1        000     X          00          0         0          1
    000101   0        100     1          11          1         0          0
    000110   0        101     X          00          0         1          0
    000111   0        110     0          10          0         0          0
    001000   0        111     0          10          0         0          0
    001001   1        000     X          01          0         0          1

*/

    always @(*) begin
      case(opcode)
        6'b000000: begin
          alu_src <= 1'b1;
          alu_op <= 3'b001;
          mem_to_reg <= 1'b0;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b0;
        end

        6'b000001: begin
          alu_src <= 1'b1;
          alu_op <= 3'b010;
          mem_to_reg <= 1'b0;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b0;
        end
        
        6'b000010: begin
          alu_src <= 1'b1;
          alu_op <= 3'b011;
          mem_to_reg <= 1'b0;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b0;
        end

        6'b000011: begin
          alu_src <= 1'b1;
          alu_op <= 3'b000;
          mem_to_reg <= 1'b0;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b1;
        end

        6'b000100: begin
          alu_src <= 1'b1;
          alu_op <= 3'b000;
          mem_to_reg <= 1'b0;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b1;
        end

        6'b000101: begin
          alu_src <= 1'b0;
          alu_op <= 3'b100;
          mem_to_reg <= 1'b1;
          reg_write <= 2'b10;
          mem_read <= 1'b1;
          mem_write <= 1'b0;
          branch <= 1'b0;
        end

        6'b000110: begin
          alu_src <= 1'b0;
          alu_op <= 3'b101;
          mem_to_reg <= 1'b0;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b1;
          branch <= 1'b0;
        end

        6'b000111: begin
          //reg_dst <= 1'b1;
          alu_src <= 1'b0;
          alu_op <= 3'b110;
          mem_to_reg <= 1'b0;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b0;
        end

        6'b001000: begin
          //reg_dst <= 1'b1;
          alu_src <= 1'b0;
          alu_op <= 3'b111;
          mem_to_reg <= 1'b0;
          reg_write <= 1'b1;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b0;
        end

        6'b001001: begin
          //reg_dst <= 1'b0;
          alu_src <= 1'b1;
          alu_op <= 3'b000;
          mem_to_reg <= 1'b0;
          reg_write <= 2'b01;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b1;
        end

        default: begin
          //reg_dst <= 1'b0;
          alu_src <= 1'b0;
          alu_op <= 3'b000;
          mem_to_reg <= 1'b0;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 1'b0;
        end
      endcase        
    end

endmodule