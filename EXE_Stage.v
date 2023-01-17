module EXE_Stage(
  input clk,
  input[3:0] EXE_CMD,
  input MEM_R_EN, MEM_W_EN,
  input[31:0] PC, Val_Rn, Val_Rm,
  input imm,
  input[11:0] Shift_operand,
  input[23:0] Signed_imm_24,
  input[3:0] SR,
  output[31:0] ALU_Res, Br_addr,
  output[3:0] status
);
wire [31:0] val2GOut;
assign Br_addr = ((PC + Signed_imm_24[23]) == 1'b1) ? {8'b11111111, Signed_imm_24} : {8'b0, Signed_imm_24};
Val2Generator v(.sel(MEM_R_EN | MEM_W_EN), .imm(imm), .Shift_operand(Shift_operand), .Val_Rm(Val_Rm), .out(val2GOut));
ALU a(.val1(Val_Rn), .val2(val2GOut), .EXE_CMD(EXE_CMD), .cin(SR[2]), .aluOut(ALU_Res), .status(status));
endmodule
