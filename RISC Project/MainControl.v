`timescale 1ns/1ps

module MainControl(
    input [5:0] opcode,
    output reg [1:0] reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg [1:0] branch,
    output reg [1:0] mem_to_reg,
    output reg [2:0] alu_op,
    output reg alu_src
);

/*
    Assign the values of the control signals based on the opcode
    OPCODE   ALUSrc   ALUOp   MemtoReg   RegWrite   MemRead   MemWrite   Branch
    000000   1        001     00         10          0         0          00
    000001   1        010     00         10          0         0          00
    000010   1        011     00         10          0         0          00
    000011   1        000     00         00          0         0          01
    000100   1        000     00         00          0         0          10
    000101   0        100     01         11          1         0          00
    000110   0        101     00         00          0         1          00
    000111   0        110     00         10          0         0          00
    001000   0        111     00         10          0         0          00
    001001   1        000     10         01          0         0          11

*/

    always @(*) begin
      case(opcode)
        6'b000000: begin
          alu_src <= 1'b1;
          alu_op <= 3'b001;
          mem_to_reg <= 2'b00;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b00;
        end

        6'b000001: begin
          alu_src <= 1'b1;
          alu_op <= 3'b010;
          mem_to_reg <= 2'b00;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b00;
        end
        
        6'b000010: begin
          alu_src <= 1'b1;
          alu_op <= 3'b011;
          mem_to_reg <= 2'b00;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b00;
        end

        6'b000011: begin
          alu_src <= 1'b1;
          alu_op <= 3'b000;
          mem_to_reg <= 2'b00;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b01;
        end

        6'b000100: begin
          alu_src <= 1'b1;
          alu_op <= 3'b000;
          mem_to_reg <= 2'b00;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b10;
        end

        6'b000101: begin
          alu_src <= 1'b0;
          alu_op <= 3'b100;
          mem_to_reg <= 2'b01;
          reg_write <= 2'b10;
          mem_read <= 1'b1;
          mem_write <= 1'b0;
          branch <= 2'b00;
        end

        6'b000110: begin
          alu_src <= 1'b0;
          alu_op <= 3'b101;
          mem_to_reg <= 2'b00;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b1;
          branch <= 2'b00;
        end

        6'b000111: begin
          //reg_dst <= 1'b1;
          alu_src <= 1'b0;
          alu_op <= 3'b110;
          mem_to_reg <= 2'b00;
          reg_write <= 2'b10;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b00;
        end

        6'b001000: begin
          //reg_dst <= 1'b1;
          alu_src <= 1'b0;
          alu_op <= 3'b111;
          mem_to_reg <= 2'b00;
          reg_write <= 1'b1;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b00;
        end

        6'b001001: begin
          //reg_dst <= 1'b0;
          alu_src <= 1'b1;
          alu_op <= 3'b000;
          mem_to_reg <= 2'b10;
          reg_write <= 2'b01;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b11;
        end

        default: begin
          //reg_dst <= 1'b0;
          alu_src <= 1'b0;
          alu_op <= 3'b000;
          mem_to_reg <= 2'b00;
          reg_write <= 1'b0;
          mem_read <= 1'b0;
          mem_write <= 1'b0;
          branch <= 2'b00;
        end
      endcase        
    end

endmodule