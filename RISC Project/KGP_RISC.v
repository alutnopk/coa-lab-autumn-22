`timescale 1ns/1ps

module KGP_RISC(
    input clk,
    input rst,
    output [31:0] Register_return 
);

    wire [31:0] Program_counter, Program_counter_next;
    wire [31:0] instruction, instruction_next;
    wire [1:0] Branching;
    wire Memory_read, Memory_write;
    wire [1:0] Memory_to_Register;
    wire [2:0] ALU_op;
    wire ALU_src;
    wire [1:0] Register_write;
    wire [3:0] ALU_control_signal;
    wire [31:0] Output_from_ALU, Data_out, Data_write, Register1_value, Register2_value, Branching_address, immediate, ALU_input2, Program_counter_ref;
    wire negative, carry, zero;

    assign immediate = {{16{instruction[15]}}, instruction[15:0]};
    assign Branching_address = {{17{instruction[20]}}, instruction[20:6]};
    assign ALU_input2 = ALU_src ? Register2_value : immediate;

    MainControl MCU(
        .opcode(instruction[31:26]),
        .reg_write(Register_write),
        .mem_read(Memory_read),
        .mem_write(Memory_write),
        .branch(Branching),
        .mem_to_reg(Memory_to_Register),
        .alu_op(ALU_op),
        .alu_src(ALU_src)
    );

    ALU ALU1(
        .input1(Register1_value),
        .input2(ALU_input2),
        .shamt(instruction[10:6]),
        .alu_control_signal(ALU_control_signal),
        .out_from_ALU(Output_from_ALU),
        .negative(negative),
        .carry(carry),
        .zero(zero)
    );

    BranchingInstructions BIM(
        .function_code(instruction[5:0]),
        .branch(Branching),
        .clk(clk),
        .rst(rst),
        .negative(negative),
        .zero(zero),
        .carry(carry),
        .reg1_value(Register1_value),
        .prog_count_in(Program_counter),
        .branch_address(Branching_address),
        .prog_count_out(Program_counter_next),
        .prog_count_next(Program_counter_ref)
    );

    Register_write REGF(
        .reg1_index(instruction[25:21]),
        .reg2_index(instruction[20:16]),
        .reg_write(Register_write),
        .clk(clk),
        .rst(rst),
        .data_write(Data_write),
        .reg1_value(Register1_value),
        .reg2_value(Register2_value),
        .reg_return(Register_return)
    );

    ALUControl ALUCU(
        .alu_op(ALU_op),
        .funct_code(instruction[5:0]),
        .alu_control_signal(ALU_control_signal)
    );

    PC PC1(
        .clk(clk),
        .rst(rst),
        .input_pc(Program_counter_next),
        .output_pc(Program_counter)
    );


    Mem_to_Reg_Selector MTRS(
        .mem_to_reg(Memory_to_Register), 
        .out_from_ALU(Output_from_ALU),
        .data_out(Data_out),
        .prog_count(Program_counter_ref),
        .data_write(Data_write)
    );

    








endmodule