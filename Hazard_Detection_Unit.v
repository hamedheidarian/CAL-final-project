module Hazard_Detection_Unit(
input Two_src, EXE_MEM_R_EN,
input[3:0] EXE_Dest, src1, src2,
output reg out
);
always@(*)begin
    out <= 1'b0;
    if((src1 == EXE_Dest) && (EXE_MEM_R_EN == 1'b1))
      out <= 1'b1;
    else if((src2 == EXE_Dest) && (EXE_MEM_R_EN == 1'b1) && (Two_src == 1'b1))
      out <= 1'b1;
end

endmodule