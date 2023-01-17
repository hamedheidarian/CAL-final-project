module AMD(input clk, rst);
	wire[31:0] PC, Instruction, ID_Val_Rm, ID_Val_Rn, IF_Reg_PC, IF_Reg_Ins, Val_Rn, Val_Rm, ID_PC, MEM_Stage_Reg_ALU_result, MEM_Stage_Reg_MEM_read_value, WB_Value,
	MEM_Stage_MEM_result, ExE_Stage_Reg_Val_Rm, mux1, mux2;
	wire imm, hazard, WB_EN, MEM_R_EN, MEM_W_EN, B, S, Two_src, ID_WB_EN, ID_MEM_R_EN, ID_MEM_W_EN, ID_B, ID_S, ID_imm, MEM_Stage_WB_EN, MEM_Stage_MEM_R_EN, EXE_Reg_WB_EN, EXE_Reg_MEM_R_EN, EXE_Reg_MEM_W_EN, forward_enable;
	wire[3:0] EXE_CMD, Dest, src1, src2, ID_reg_src1, ID_reg_src2, ID_SR, ID_EXE_CMD, ID_Dest, EXE_Reg_Dest, status, SR, MEM_Stage_Dest;
	wire[11:0] Shift_operand, ID_Shift_operand;
	wire[23:0] Signed_imm_24, ID_Signed_imm_24;
	wire[31:0] ALU_Res_in, ALU_Res, Br_addr;
  wire[1:0] Sel_src1, Sel_src2;


assign forward_enable=1;
assign mux1=(Sel_src1==2'b00)?ID_Val_Rn:(Sel_src1==2'b01)?ALU_Res:(Sel_src1==2'b10)?WB_Value:4'dx;
assign mux2=(Sel_src2==2'b00)?ID_Val_Rm:(Sel_src2==2'b01)?ALU_Res:(Sel_src2==2'b10)?WB_Value:4'dx;

IFStage i( .clk(clk), .rst(rst), .Branch_taken(ID_B), .freeze(hazard), .BranchAdder(Br_addr), .PC(PC), .instruction(Instruction));
IF_Stage_reg i1(.clk(clk), .rst(rst),.freeze(hazard),.flush(ID_B), .PC_in(PC), .Instruction_IN(Instruction), .PC(IF_Reg_PC), .Instruction(IF_Reg_Ins));
IDStage i2(
  .clk(clk), .rst(rst), .writeBackEn(MEM_Stage_WB_EN),.hazard(hazard), .SR(SR), .WB_Dest(MEM_Stage_Dest), .Instruction(IF_Reg_Ins), .WB_Value(WB_Value), .MEM_R_EN(MEM_R_EN), .MEM_W_EN(MEM_W_EN), .WB_EN(WB_EN), .B(B), .S(S), .EXE_CMD(EXE_CMD), .Val_Rn(Val_Rn), .Val_Rm(Val_Rm), .imm(imm), .Shift_operand(Shift_operand), .Signed_imm_24(Signed_imm_24), .Dest(Dest), .src1(src1), .src2(src2), .Two_src(Two_src)
);
ID_Stage_Reg i3(
	.clk(clk), .rst(rst), .flush(ID_B),
  .src1_IN(src1), .src2_IN(src2),
  .SR_IN(SR),
	.WB_EN_IN(WB_EN), .MEM_R_EN_IN(MEM_R_EN), .MEM_W_EN_IN(MEM_W_EN),
	.B_IN(B), .S_IN(S),
	.EXE_CMD_IN(EXE_CMD),
	.Val_Rn_IN(Val_Rn), .Val_Rm_IN(Val_Rm),
	.PC_IN(IF_Reg_PC),
	.imm_IN(imm),
	.Signed_imm_24_IN(Signed_imm_24),
	.DEST_IN(Dest),
	.Shift_operand_IN(Shift_operand),
	.MEM_R_EN(ID_MEM_R_EN), .MEM_W_EN(ID_MEM_W_EN), .WB_EN(ID_WB_EN), .B(ID_B),.S(ID_S),
	.EXE_CMD(ID_EXE_CMD),
	.Val_Rn(ID_Val_Rn), .Val_Rm(ID_Val_Rm),
	.imm(ID_imm),
	.Shift_operand(ID_Shift_operand),
	.PC(ID_PC),
	.Signed_imm_24(ID_Signed_imm_24),
	.DEST(ID_Dest),
  .SR_OUT(ID_SR),
  .src1(ID_reg_src1),
  .src2(ID_reg_src2)
);

EXE_Stage e(
  .clk(clk),
  .EXE_CMD(ID_EXE_CMD),
  .MEM_R_EN(ID_MEM_R_EN), .MEM_W_EN(ID_MEM_W_EN),
  .PC(ID_PC), .Val_Rn(mux1), .Val_Rm(mux2),
  .imm(ID_imm),
   .Shift_operand(ID_Shift_operand),
   .Signed_imm_24(ID_Signed_imm_24),
  .SR(ID_SR),
  .ALU_Res(ALU_Res_in), .Br_addr(Br_addr),
   .status(status)
);

EXE_Stage_Reg e1(
 .clk(clk), .rst(rst), .WB_EN_in(ID_WB_EN), .MEM_R_EN_in(ID_MEM_R_EN), .MEM_W_EN_in(ID_MEM_W_EN),
   .ALU_result_in(ALU_Res_in), .Val_Rm_in(mux2),
  .Dest_in(ID_Dest),
  .WB_EN(EXE_Reg_WB_EN), .MEM_R_EN(EXE_Reg_MEM_R_EN), .MEM_W_EN(EXE_Reg_MEM_W_EN),
  .ALU_result(ALU_Res), .Val_Rm(ExE_Stage_Reg_Val_Rm),
  .Dest(EXE_Reg_Dest)
);

MEMStage m(
  .clk(clk), .MEM_R_EN(EXE_Reg_MEM_R_EN), .MEM_W_EN(EXE_Reg_MEM_W_EN),
  .ALU_res(ALU_Res), .Val_Rm(ExE_Stage_Reg_Val_Rm),
   .dataMem_out(MEM_Stage_MEM_result)
  );
  
MEM_Stage_Reg m2(
  .clk(clk), .rst(rst), .WB_EN_IN(EXE_Reg_WB_EN), .MEM_R_EN_IN(EXE_Reg_MEM_R_EN),
  .ALU_result_in(ALU_Res), .mem_read_value_in(MEM_Stage_MEM_result),
  .Dest_in(EXE_Reg_Dest),
  .WB_EN(MEM_Stage_WB_EN), .MEM_R_EN(MEM_Stage_MEM_R_EN),
  .ALU_result(MEM_Stage_Reg_ALU_result), .mem_read_value(MEM_Stage_Reg_MEM_read_value),
  .Dest(MEM_Stage_Dest)
);

WB_Stage w(  
  .ALU_Res(MEM_Stage_Reg_ALU_result), .MEM_Res(MEM_Stage_Reg_MEM_read_value),
  .MEM_R_EN(MEM_Stage_MEM_R_EN),
  .out(WB_Value)
);

Hazard_Detection_Unit h(
.Two_src(Two_src),
.EXE_Dest(ID_Dest), .EXE_MEM_R_EN(ID_MEM_R_EN), .src1(src1), .src2(src2),
.out(hazard)
);

StatusRegister s(
.clk(clk), .rst(rst), .S(ID_S), 
.Status_Bits(status),
.out(SR)
);


Forwarding_Unit f(
    .en(forward_enable),
    .src1(ID_reg_src1),
    .src2(ID_reg_src2),
    .WB_Dest(MEM_Stage_Dest),
    .MEM_Dest(EXE_Reg_Dest),
    .WB_WB_en(MEM_Stage_WB_EN),
    .MEM_WB_en(EXE_Reg_WB_EN),   
    .Sel_src1(Sel_src1),
    .Sel_src2(Sel_src2)
);


endmodule