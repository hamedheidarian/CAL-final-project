module IDStage (
  input clk, rst, writeBackEn,hazard, 
  input[3:0] SR, WB_Dest,
  input [31:0] Instruction, WB_Value,
  output MEM_R_EN, MEM_W_EN, WB_EN, B, S,
  output[3:0] EXE_CMD,
  output [31:0] Val_Rn, Val_Rm,
  output imm,
  output[11:0] Shift_operand,
  output[23:0] Signed_imm_24,
  output[3:0] Dest,
  output[3:0] src1, src2,
  output Two_src
);
  wire MEM_R_EN1, MEM_W_EN1, WB_EN1, B1, S1, imm1;
  wire[3:0] EXE_CMD1;
  wire cc_out;
  assign Shift_operand = Instruction[11:0];
  assign Dest = Instruction[15:12];
  assign src2 = (MEM_W_EN1) ? Instruction[15:12] : Instruction[3:0];
  assign src1 = Instruction[19:16];
  assign Signed_imm_24 = Instruction[23:0];
  assign Two_src = MEM_R_EN || ~Instruction[25];
  assign imm1 = Instruction[25];
  assign {B, S, EXE_CMD, WB_EN, MEM_R_EN, MEM_W_EN, imm} = (hazard || ~cc_out)? 0: {B1, S1, EXE_CMD1, WB_EN1, MEM_R_EN1, MEM_W_EN1, imm1};
  controlUnit cu(.s(Instruction[20]), .mode(Instruction[27:26]), .opCode(Instruction[24:21]), .B(B1), .S(S1), .EXE_CMD(EXE_CMD1), .WB_EN(WB_EN1), .MEM_R_EN(MEM_R_EN1), .MEM_W_EN(MEM_W_EN1));
  condition_Check cc(.inst(Instruction[31:28]),.n(SR[3]), .z(SR[2]), .c(SR[1]), .v(SR[0]), .res(cc_out));
  regFile rf(.clk(clk), .rst(rst), .writeBackEn(writeBackEn), .src1(src1), .src2(src2), .WB_Dest(WB_Dest), .WB_Value(WB_Value), .reg1(Val_Rn), .reg2(Val_Rm));
endmodule
