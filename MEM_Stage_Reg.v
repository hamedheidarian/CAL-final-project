module MEM_Stage_Reg (
  input clk, rst, WB_EN_IN, MEM_R_EN_IN,
  input[31:0] ALU_result_in, mem_read_value_in,
  input[3:0] Dest_in,
  output reg WB_EN, MEM_R_EN,
  output reg[31:0] ALU_result, mem_read_value,
  output reg[3:0] Dest
);

  always@(posedge clk, posedge rst) begin
    if (rst) begin
      {WB_EN, MEM_R_EN, ALU_result, mem_read_value, Dest} <= 0;
    end
    else begin
	    WB_EN <= WB_EN_IN;
		  MEM_R_EN <= MEM_R_EN_IN;
		  ALU_result <= ALU_result_in;
		  mem_read_value <= mem_read_value_in;
		  Dest <= Dest_in;
	  end
	end  
endmodule
