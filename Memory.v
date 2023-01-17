module Memory(
  input clk, MEMread, MEMwrite,
  input[31:0] address, data,
  output [31:0] MEM_result
);
reg [31:0] memory [0:63];
wire [31:0] tempAdd;
assign tempAdd = ((address - 32'd1024) >> 2);
assign MEM_result = MEMread ? memory[((address - 32'd1024) >> 2)] : 32'bz;
always @(posedge clk) begin
  if (MEMwrite) begin
    memory[tempAdd] = data;
  end
  // else if(MEMread)begin
	
  // end
end
endmodule