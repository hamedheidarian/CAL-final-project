module IFStage ( input clk, rst, Branch_taken, freeze, input [31:0] BranchAdder, output [31:0] PC, instruction);
  wire [31:0] pc;
  wire [31:0] pc_out;

  register PCReg (
    .clk(clk),
    .rst(rst),
    .writeEn(~freeze),
    .regIn(pc),
    .regOut(pc_out)
  );

  instructionMem instructions (
    .clk(clk),
    .addr(pc_out),
    .instruction(instruction)
  );
  assign PC = pc_out + 32'd4;
  assign pc = (Branch_taken == 1'b1) ? BranchAdder : PC ;
endmodule