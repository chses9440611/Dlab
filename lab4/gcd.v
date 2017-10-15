`timescale 1ns / 1ps
// Documented Verilog UART
// Copyright (C) 2010 Timothy Goddard (tim@goddard.net.nz)
// Distributed under the MIT licence.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
// 

module Gcd(
	input [15:0] d1,
	input [15:0] d2,
	input clk,
	input rst,
	output [15:0] gcd,
	output finished_flag
); 
reg [15:0] 	tmp1;
reg [15:0] 	tmp2;
reg [15:0] 	tmp1_q;
reg [15:0] 	tmp2_q;
reg [15:0]  result_q;
reg [1:0]	flag_tmp;
reg [1:0]	flag_tmp_q;
reg enable;
always@(clk)begin
	if(~rst)begin
		tmp1 <= 16'd0;
		tmp2 <= 16'd0;
		result_q <= 16'd0;
		flag_tmp <= 2'b00;
		enable <= 1'b0;
	end
	else begin
		if(flag_tmp==2'b00)begin
		//read d1,d2
			tmp1 <= d1;
			tmp2 <= d2;
			flag_tmp <= 2'b01;
			enable <= 1'b0;
		end
		else if(flag_tmp_q == 2'b01)begin
			if(tmp1_q==tmp2_q && tmp1_q != 0)begin
				flag_tmp <= 2'b00;
				result_q <= tmp2_q;
				enable <= 1'b1;
			end
			else if(tmp1_q > tmp2_q)begin
				tmp1 <= tmp1_q - tmp2_q;
				tmp2 <= tmp2_q;
			end
			else if(tmp1_q < tmp2_q)begin
				tmp2 <= tmp2_q - tmp1_q;
				tmp1 <= tmp1_q;
			end
		end
	end
end

always@(clk)begin
	tmp1_q <= tmp1;
	tmp2_q <= tmp2;
	flag_tmp_q <= flag_tmp;
end

assign gcd = result_q;
assign finished_flag = enable;
endmodule
