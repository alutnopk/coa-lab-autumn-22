`timescale 1ns/1ps

module FullAdderTestbench;
    //inputs
    reg a;
    reg b;
    reg c_in;
    //outputs
    wire sum;
    wire c_out;

    integer write_data; //data to write to the memory
    write_data = $fopen("output_FullAdderTestbench.txt"); //open the file to write to
    // instantiating of the full adder
    FullAdder tbt(.a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_out));
    initial begin
        a = 0; b = 0; c_in = 0;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out); //write the values to the file
        #20; // wait for 20 cycles
        a = 0; b = 0; c_in = 1;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out);
        #20;
        a = 0; b = 1; c_in = 0;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out);
        #20;
        a = 0; b = 1; c_in = 1;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out);
        #20;
        a = 1; b = 0; c_in = 0;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out);
        #20;
        a = 1; b = 0; c_in = 1;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out);
        #20;
        a = 1; b = 1; c_in = 0;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out);
        #20;
        a = 1; b = 1; c_in = 1;
        $fdisplay(write_data, "%b %b %b %b %b",a,b,c_in,sum,c_out);
        #20;
    end

    $fclose(write_data); //closing the file

endmodule