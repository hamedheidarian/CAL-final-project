module condition_Check (input[3:0] inst,input z, c, n, v, output res);
  reg temp;
  always@(*) begin
    temp <= 1'b0;
    case(inst)
      4'b0000: temp <= (z == 1'b1)? 1'b1: 1'b0;
      4'b0001: temp <= (z == 1'b0)? 1'b1: 1'b0;
      4'b0010: temp <= (c == 1'b1)? 1'b1: 1'b0;
      4'b0011: temp <= (c == 1'b0)? 1'b1: 1'b0;
      4'b0100: temp <= (n == 1'b1)? 1'b1: 1'b0;
      4'b0101: temp <= (n == 1'b0)? 1'b1: 1'b0;
      4'b0110: temp <= (v == 1'b1)? 1'b1: 1'b0;
      4'b0111: temp <= (v == 1'b0)? 1'b1: 1'b0;
      4'b1000: temp <= (c == 1'b1 && z == 1'b0)? 1'b1: 1'b0;
      4'b1001: temp <= (c == 1'b0 || z == 1'b1)? 1'b1: 1'b0;
      4'b1010: temp <= (n == v)? 1'b1: 1'b0;
      4'b1011: temp <= (n != v)? 1'b1: 1'b0;
      4'b1100: temp <= (z == 1'b0 && n == v)? 1'b1: 1'b0;
      4'b1101: temp <= (z == 1'b1 || n != v)? 1'b1: 1'b0;
      4'b1110: temp <= 1'b1;
    endcase
  end
  assign res = temp;
endmodule
