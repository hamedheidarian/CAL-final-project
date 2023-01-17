module IF_Stage_reg( input clk,rst,freeze,flush, input[31:0] PC_in, Instruction_IN, output reg[31:0] PC, Instruction);
  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      PC <= 0;
      Instruction <= 0;
    end
    else begin
      if (~freeze) begin
        case(flush)
        1'b1: begin
          Instruction <= 0;
          PC <= 0;
        end
        1'b0: begin
          Instruction <= Instruction_IN;
          PC <= PC_in;
        end
      endcase
      end
    end
  end

endmodule