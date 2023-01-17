module ID_Stage_Reg(
	input clk, rst, flush,
	input [3:0] SR_IN, src1_IN, src2_IN,
	input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
	input B_IN, S_IN,
	input[3:0] EXE_CMD_IN,
	input[31:0] Val_Rn_IN, Val_Rm_IN,
	input [31:0] PC_IN,			
	input imm_IN,
	input[23:0] Signed_imm_24_IN,
	input [3:0] DEST_IN,
	input[11:0] Shift_operand_IN,
	output reg[3:0] SR_OUT, src1, src2,
	output reg MEM_R_EN, MEM_W_EN, WB_EN, B,S,
	output reg[3:0] EXE_CMD,
	output reg[31:0] Val_Rn, Val_Rm,
	output reg imm,
	output reg[11:0] Shift_operand,
	output reg [31:0] PC,
	output reg [23:0] Signed_imm_24,
	output reg [3:0] DEST
);
  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      {SR_OUT, WB_EN, MEM_R_EN, MEM_W_EN, B, S, EXE_CMD, Val_Rn, Val_Rm, imm, Shift_operand, PC, Signed_imm_24, DEST, src1, src2} <= 0;
    end
    else begin
		if(~flush)begin
		  SR_OUT <= SR_IN;
		  WB_EN <= WB_EN_IN;
		  MEM_R_EN <= MEM_R_EN_IN;
		  MEM_W_EN <= MEM_W_EN_IN;
		  B <= B_IN;
		  S <= S_IN;
		  EXE_CMD <= EXE_CMD_IN;
		  Val_Rn <= Val_Rn_IN;
		  Val_Rm <= Val_Rm_IN;
		  imm <= imm_IN;
		  Shift_operand <= Shift_operand_IN;
		  PC <= PC_IN;
		  Signed_imm_24 <= Signed_imm_24_IN;
		  DEST <= DEST_IN;
		  src1 <= src1_IN;
		  src2 <= src2_IN;
		end
	  end
	end  
endmodule