module controlUnit (
  input s,
  input[1:0] mode, 
  input [3:0] opCode,	
  output reg B,S,
  output reg [3:0] EXE_CMD,
  output reg WB_EN, MEM_R_EN, MEM_W_EN
 );


  always @(*) begin
      {B, S, EXE_CMD, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;
      case ({mode, opCode})
        default: {B, S, EXE_CMD, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;
		6'b001101: begin EXE_CMD <= 4'b0001; WB_EN <= 1'b1; S <= s; end
		6'b001111: begin EXE_CMD <= 4'b1001; WB_EN <= 1'b1; S <= s; end
		6'b000100: begin EXE_CMD <= 4'b0010; WB_EN <= 1'b1; S <= s; end
		6'b000101: begin EXE_CMD <= 4'b0011; WB_EN <= 1'b1; S <= s; end
		6'b000010: begin EXE_CMD <= 4'b0100; WB_EN <= 1'b1; S <= s; end
		6'b000110: begin EXE_CMD <= 4'b0101; WB_EN <= 1'b1; S <= s; end
		6'b000000: begin EXE_CMD <= 4'b0110; WB_EN <= 1'b1; S <= s; end
		6'b001100: begin EXE_CMD <= 4'b0111; WB_EN <= 1'b1; S <= s; end
		6'b000001: begin EXE_CMD <= 4'b1000; WB_EN <= 1'b1; S <= s; end
		6'b001010: begin EXE_CMD <= 4'b0100; S <= 1'b1; end
		6'b001000: begin EXE_CMD <= 4'b0110; S <= 1'b1; end
		6'b010100: begin
		if(s == 1) begin EXE_CMD <= 4'b0010; WB_EN <= 1'b1; S<=1'b1; MEM_R_EN<=1'b1; end 
		else begin EXE_CMD <= 4'b0010; MEM_W_EN<=1'b1; end
		end
      endcase
	  if(mode == 2'b10)begin B <= 1'b1;end
  end
endmodule