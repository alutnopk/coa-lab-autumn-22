`timescale 1ns/1ps

module Register_Module(
    input [4:0] reg1_index,
    input [4:0] reg2_index,
    input [1:0] reg_write,
    input [31:0] data_write,
	 input [4:0] show_index,
    input clk, 
    input rst,
    output [31:0] reg1_value,
    output [31:0] reg2_value,
    output [31:0] reg_return
);

    reg[31:0] register_list[31:0];
	 
    always @(posedge clk) begin
        if (rst) begin
            // if the rst is high, then the registers are reset to 0
            register_list[0] <= 32'b0;
            register_list[1] <= 32'b0;
            register_list[2] <= 32'b0;
            register_list[3] <= 32'b0;
            register_list[4] <= 32'b0;
            register_list[5] <= 32'b0;
            register_list[6] <= 32'b0;
            register_list[7] <= 32'b0;
            register_list[8] <= 32'b0;
            register_list[9] <= 32'b0;
            register_list[10] <= 32'b0;
            register_list[11] <= 32'b0;
            register_list[12] <= 32'b0;
            register_list[13] <= 32'b0;
            register_list[14] <= 32'b0;
            register_list[15] <= 32'b0;
            register_list[16] <= 32'b0;
            register_list[17] <= 32'b0;
            register_list[18] <= 32'b0;
            register_list[19] <= 32'b0;
            register_list[20] <= 32'b0;
            register_list[21] <= 32'b0;
            register_list[22] <= 32'b0;
            register_list[23] <= 32'b0;
            register_list[24] <= 32'b0;
            register_list[25] <= 32'b0;
            register_list[26] <= 32'b0;
            register_list[27] <= 32'b0;
            register_list[28] <= 32'b0;
            register_list[29] <= 32'b0;
            register_list[30] <= 32'b0;
            register_list[31] <= 32'b0;
        end else if(reg_write[0] || reg_write[1]) begin 
            case(reg_write)
                // depending on the value of reg_write, the corresponding register is written to
                2'b10:
                    register_list[reg1_index] <= data_write;
                2'b01:
                    register_list[5'b11111] <= data_write;
                2'b11:
                    register_list[reg2_index] <= data_write;
                default: ;
            endcase
        end
    end
	// always @(*) begin
		//reg1_value = register_list[reg1_index];
		//reg2_value = register_list[reg2_index];
	//	reg_return = register_list[5'b00001];
	 //end
    assign reg1_value = register_list[reg1_index];
    assign reg2_value = register_list[reg2_index];
    assign reg_return = register_list[show_index];
endmodule