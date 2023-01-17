module ALU (
  input [31:0] val1, val2,
  input [3:0] EXE_CMD,
  input cin,
  output reg signed [31:0] aluOut,
  output reg [3:0] status
);

  always@(*) begin
    status <= 0;
    case (EXE_CMD)
	    4'b0001: aluOut <= val2;
      4'b1001: aluOut <= ~val2;
      4'b0010: begin {status[2], aluOut} <= val1 + val2; status[0] = (val1[31] == val2[31]) && (aluOut[31] != val1[31]); end
      4'b0011: begin {status[2], aluOut} <= val1 + val2 + {31'b0, cin}; status[0] = (val1[31] == val2[31]) && (aluOut[31] != val1[31]); end
      4'b0100: begin {status[2], aluOut} <= val1 - val2; status[0] = (val1[31] == val2[31]) && (aluOut[31] != val1[31]);end
	    4'b0101: begin {status[2], aluOut} <= val1 - val2 - cin; status[0] = (val1[31] == val2[31]) && (aluOut[31] != val1[31]);end
      4'b0110: aluOut <= val1 & val2;
      4'b0111: aluOut <= val1 | val2;
      4'b1000: aluOut <= val1 ^ val2;
      default: aluOut <= 0;
    endcase
  status[3] <= (aluOut == 32'b0) ? 1'b1 : 1'b0;
  status[1] <= (aluOut[31]);
  end
endmodule
