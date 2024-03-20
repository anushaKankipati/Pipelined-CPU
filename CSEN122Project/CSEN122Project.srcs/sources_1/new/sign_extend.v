`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 02:18:50 PM
// Design Name: 
// Module Name: sign_extend
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
module sign_extend(inst_opcode, signIn, signOut);
	input [3:0] inst_opcode;
	input [21:0] signIn;
	output reg [31:0] signOut;
		
	always@ (signIn, signOut)
	begin
		if(inst_opcode == 4'b111)
			begin
				if(signIn[21] == 1)
					signOut = {10'b1111111111, signIn};
				else if(signIn[21] == 0)
					signOut = {10'b0000000000, signIn};
			end
		
		if (inst_opcode == 4'b0101)
			begin
				if(signIn[5] ==1)
					signOut = {16'b1111111111111111, signIn};
				else if(signIn[15] == 0)
					signOut = {16'b0000000000000000, signIn};
			end
	end

endmodule