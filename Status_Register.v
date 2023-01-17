module StatusRegister (
    input clk, rst, S, 
    input [3:0] Status_Bits,
    output reg [3:0] out
);
  always@(negedge clk, posedge rst) begin
    if (rst) begin
      out <= 0;
    end
    else if(S == 1'b1) begin
      out <= Status_Bits;
	  end
  end 
endmodule