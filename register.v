module register (input clk, rst, writeEn,input [31:0] regIn,output reg [31:0] regOut);
  always @ (posedge clk, posedge rst) begin
    if (rst == 1'b1) regOut <= 32'b0;
    else begin if (writeEn == 1'b1) begin regOut <= regIn; end end
  end
endmodule