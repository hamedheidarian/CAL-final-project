module Val2Generator(
    input sel, imm,
	input[11:0] Shift_operand,
    input [31:0] Val_Rm,
    output reg [31:0] out
);
integer i;
reg[31:0] rotate;
always @(*) begin
    rotate = {24'b0, Shift_operand[7:0]};
    if(sel == 1'b0) begin
        case(imm)
           1'b1: begin for (i = 0; i < (Shift_operand[11:8] << 1); i = i + 1) begin
             rotate = {rotate[0], rotate[31:1]};
           end
           out <= rotate;
        end
           1'b0: begin
            if (Shift_operand[4] == 1'b0) begin
                case (Shift_operand[6:5])
                    2'b00: out <=(Val_Rm << Shift_operand[11:7]); 
                    2'b01: out <=(Val_Rm >> Shift_operand[11:7]);
                    2'b10: out <=(Val_Rm >>> Shift_operand[11:7]);
                    2'b11: out <=(Val_Rm >> Shift_operand[11:7]) | (Val_Rm << (~Shift_operand[11:7] + 5'd1));
    				default: out <= 32'b0;
                endcase
            end
        end
    endcase 
    end 
    else if(sel == 1'b1) out <= {20'b0, Shift_operand};
end
endmodule