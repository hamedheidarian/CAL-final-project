module Forwarding_Unit(
  input en,
  input[3:0] src1,
  input[3:0] src2,
  input[3:0] WB_Dest, MEM_Dest,
  input WB_WB_en, MEM_WB_en,
  output[1:0] Sel_src1, Sel_src2
);
reg[1:0] Sel_src1_tmp, Sel_src2_tmp;
always @(*) begin
	if(en)begin
		if(MEM_WB_en && ((src1 == MEM_Dest)|| (src2 == MEM_Dest)))begin
			Sel_src1_tmp <= (src1 == MEM_Dest)? 2'b01 : 2'b00;
			Sel_src2_tmp <= (src2 == MEM_Dest)? 2'b01: 2'b00;
		end
		else if(WB_WB_en)begin
			Sel_src1_tmp <= (src1 == WB_Dest)? 2'b10 : 2'b00;
			Sel_src2_tmp <= (src2 == WB_Dest)? 2'b10: 2'b00;
		end 
    end 
end
assign Sel_src1 = Sel_src1_tmp;
assign Sel_src2 = Sel_src2_tmp;
endmodule