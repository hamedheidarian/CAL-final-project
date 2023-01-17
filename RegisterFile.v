module regFile (input clk, rst, writeBackEn, input [3:0] src1, src2, WB_Dest, input [31:0] WB_Value, output [31:0] reg1, reg2);
  reg [31:0] regMem [14:0];
    integer i, count;

  always @ (negedge clk) begin
    if (rst) begin
    count = 0;
    for (i=0;i < 15;i=i+1)
    regMem[i] <= i;
	    end

    else if (writeBackEn) regMem[WB_Dest] <= WB_Value;
    // regMem[0] <= 0;
  end

  assign reg1 = (regMem[src1]);
  assign reg2 = (regMem[src2]);
endmodule
