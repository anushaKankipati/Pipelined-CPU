`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 01:33:08 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module alu(A, B, Sel, Out, N, Z);
	input [31:0] A, B;
	input [3:0] Sel;
	output reg [31:0] Out;
	output reg N, Z;
	
	always@(A, B, Sel)
	begin
		if(Sel == 4'b0100) //add
			Out = A + B;
		if(Sel == 4'b0101) //increment
			Out = A + 1;
		if(Sel == 4'b0110) //negate
			Out = - A;
		if(Sel == 4'b0111) //subtract
			Out = A - B;
		if(Sel == 4'b0000) //no op (pass value)
			Out = A;
	end
	
	always@(Out)
	begin
		if(Sel != 4'b0000) //if selector is not pass value
			begin
			if(Out == 0)
				Z = 1;
			else if(Out !=0)
				Z = 0;
			if(Out[31] == 1)
				N = 1;
			else if(Out[31] == 0)
				N = 0;
			end
	end
endmodule
