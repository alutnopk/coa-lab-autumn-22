`timescale 1ns/1ps

module HalfAdderTestbench;
    //inputs
    reg a,b;
    //outputs
    wire sum, c_out;
    integer write_data;
    write_data = $fopen("output_HalfAdderTestbench.txt"); //open the file to write to
    // instantiating the half adder
    HalfAdder UUT(.a(a), .b(b), .sum(sum), .c_out(c_out));
    initial begin
        a = 0; b = 0;
        $fdisplay(write_data, "%b %b %b %b", a, b, sum, c_out);
        #10;
        a = 1; b = 0;
        $fdisplay(write_data, "%b %b %b %b", a, b, sum, c_out);
        #10;
        a = 0; b = 1;
        $fdisplay(write_data, "%b %b %b %b", a, b, sum, c_out);
        #10;
        a = 1; b = 1;
        $fdisplay(write_data, "%b %b %b %b", a, b, sum, c_out);
        #10;      
    end

    $fclose(write_data); //close the file
endmodule