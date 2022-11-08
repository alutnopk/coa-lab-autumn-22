`timescale 1ns/1ps

module DIFF(
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] out
);
	reg [4:0] count;
	wire [31:0] xor1;
	integer i;
	assign xor1 = A ^ B;
	initial begin
		out = 'd32;
		count = 5'd32;
		i = 31;
		for(;i >=0; i=i-1) begin
			if ((A[i] && !B[i]) || (!A[i] && B[i])) begin
				out = i;
				count = count - 1;
			end
			else begin
				count = count - 1;
			end
		end
	end
	
endmodule