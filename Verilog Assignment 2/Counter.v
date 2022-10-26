`timescale 1ns/1ps

module counter(input clk, input rstn, output reg [3:0] count);

always @(posedge clk ,posedge rstn) begin
  if (!rstn) begin
    count <= 4'b0000;
  end 
  else if (count == 4'b1111) begin
    count <= 4'b0000;
  end
  else begin
    count <= count + 1;
  end
end

endmodule