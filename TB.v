module TB();
reg clk=1'b0,rst=1'b0;
AMD a(clk, rst);
initial begin #10 rst = 1'b1; #19 rst = 1'b0; end
initial repeat (150) #10 clk=~clk;
endmodule
