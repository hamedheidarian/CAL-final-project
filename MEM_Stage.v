module MEMStage (
  input clk, MEM_R_EN, MEM_W_EN,
  input [31:0] ALU_res, Val_Rm,
  output [31:0]  dataMem_out
  );
Memory m(.clk(clk), .MEMread(MEM_R_EN), .MEMwrite(MEM_W_EN), .address(ALU_res), .data(Val_Rm), .MEM_result(dataMem_out));
endmodule
