`timescale 1ns / 1ps
module gcd_tb;
	reg rst = 1;
	reg clk = 1;
	wire flag;
	reg [15:0] A;
	reg [15:0] B;
	wire [15:0] result;
	Gcd uut(
		.d1(A),
		.d2(B),
		.rst(rst),
		.clk(clk),
		.gcd(result),
		.finished_flag(flag)
	);
	
	always
		#5 clk = ~clk;
		
	initial begin
		rst = 1; A=16'd0; B=16'd0;
		#100;
		rst = 0;
		#20;
		rst=1; A=16'd78; B=16'd114;
		#20;
		A=16'd77; B=16'd35;
		
		
	end
	
endmodule;	
