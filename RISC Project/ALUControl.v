`timescale 1ns/1ps

module ALUControl(
    input [2:0] alu_op,
    input [5:0] funct_code,
    output reg [3:0] alu_control_signal
);

/*
    Assign the values of the control signals based on the funct_code and the alu_op
    ALUop - Function Code   Control Signal
    001     000000          0000
    001     000001          0001
    001     000010          0010

    010     000000          0011
    010     000001          0100

    011     000000          0101
    011     000001          0110
    011     000010          1001
    011     000011          1000
    011     000100          0111
    011     000101          1010

    110     X               0000
    111     X               0001
    
*/

always @(*) begin
    case(alu_op)
        3'b001: begin
            case(funct_code)
                6'b000000: alu_control_signal <= 4'b0000;
                6'b000001: alu_control_signal <= 4'b0001;
                6'b000010: alu_control_signal <= 4'b0010;
                default: alu_control_signal <= 4'b1111;
            endcase
        end

        3'b010: begin
            case(funct_code)
                6'b000000: alu_control_signal <= 4'b0011;
                6'b000001: alu_control_signal <= 4'b0100;
                default: alu_control_signal <= 4'b1111;
            endcase
        end

        3'b011: begin
            case(funct_code)
                6'b000000: alu_control_signal <= 4'b0101;
                6'b000001: alu_control_signal <= 4'b0110;
                6'b000010: alu_control_signal <= 4'b1001;
                6'b000011: alu_control_signal <= 4'b1000;
                6'b000100: alu_control_signal <= 4'b0111;
                6'b000101: alu_control_signal <= 4'b1010;
                default: alu_control_signal <= 4'b1111;
            endcase
        end

        3'b110: alu_control_signal <= 4'b0000;
        3'b111: alu_control_signal <= 4'b0001;
        default: alu_control_signal <= 4'b1111;
    endcase
end


endmodule