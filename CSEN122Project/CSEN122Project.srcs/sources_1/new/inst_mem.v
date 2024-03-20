`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2024 03:30:49 PM
// Design Name: 
// Module Name: inst_mem
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
module inst_mem(address, clk, instrOut);
input clk;
input [31:0] address;
output reg [31:0] instrOut;
wire [31:0] instr [255:0];

assign instr[0] = 32'b1111_000001_000000_000000_0000000001; //SVPC x1, 1 
assign instr[1] = 32'b1111_000101_000000_000000_0000000100; //SVPC x5, 4  Store the address of last element in array in x5
assign instr[2] = 32'b1111_001001_000000_000000_0000000100; //SVPC x9, 4 Save the target branch address of PC+4 into x9
assign instr[3] = 32'b0111_000010_000001_000001_0000000000; //sub x2, x1, x1 Set x2 register to 0 
assign instr[4] = 32'b0111_000100_000001_000001_0000000000; //sub x4, x1, x1 Set x4 register to 0
assign instr[5] = 32'b0111_000011_000001_000001_0000000000; //sub x3, x1, x1 Set x3 register to 0

assign instr[6] = 32'b1111_001010_000000_000000_0000001001; //SVPC x10, 9  Save the target branch address of PC+5 into x10

assign instr[7] = 32'b1110_000110_000010_000000_0000000000; //LD   x6, x2      //x6=mem[x2]
assign instr[8] = 32'b00000000000000000000000000000000;     //NOP
assign instr[9] = 32'b00000000000000000000000000000000;     //NOP


assign instr[10] = 32'b0111_000111_000110_000100_0000000000; //sub  x7, x6, x4  x7=x6-x4 x7 holds negative val if x6<x4

assign instr[11] = 32'b1011_000000_001010_000000_0000000000; //BRN  x10         //If x6 is smaller than x4, skip instruction loading x6 to x4 
assign instr[12] = 32'b00000000000000000000000000000000;    //NOP
assign instr[13] = 32'b00000000000000000000000000000000;    //NOP
assign instr[14] = 32'b0111_000100_000110_000011_0000000000; //sub x4, x6, x3 Set x4 register to 0

assign instr[15] = 32'b0101_000010_000010_000000_0000000001; //INC  x2, x2, 1   //x2=x2+1 (Move to next array element)

assign instr[16] = 32'b0111_001000_000010_000101_0000000000; //sub  x8, x2, x5  //x8=x2-x5 If at last element in array, x8 will hold 0
assign instr[17] = 32'b1011_000000_001001_000000_0000000000; //BRN  x9          //else if not yet at last element in array, loop back
/*
BRZ  x9          //if at last element in array, loop back to process last element

STOP
assign instr[0] = 32'b1111_001000_000000_000000_0000000001; //SVPC x8, 1 rd=x8=0+1=1
assign instr[1] = 32'b1111_001001_000000_000000_0000000001; //SVPC x9, 1 rd=x9=1+1=2
assign instr[2] = 32'b1111_010100_000000_000000_0000000100; //SVPC x20, 4 rd=x9=2+4=6

assign instr[3] = 32'b0111_001010_001000_001000_0000000000; //SUB x10, x8, x8  so x10=0
assign instr[4] = 32'b0111_001011_001000_001000_0000000000; //sub x11, x8, x8
assign instr[5] = 32'b0111_001100_001000_001000_0000000000; //sub x12, x8, x8
assign instr[6] = 32'b00000000000000000000000000000000; //NOP
assign instr[7] = 32'b00000000000000000000000000000000; //NOP

assign instr[8] = 32'b1111_010101_000000_000000_0000000011; //svpc x21 +3 = 11
assign instr[9] = 32'b1111_010110_000000_000000_0000010011; //svpc x22 + 19  = 28
assign instr[10] = 32'b1111_010111_000000_000000_0000000000; //svpc x23 + 0= 10
assign instr[11] = 32'b1110_001100_001001_000000_0000000000; //ld x12, x9
assign instr[12] = 32'b00000000000000000000000000000000; //NOP
assign instr[13] = 32'b00000000000000000000000000000000; //NOP


assign instr[14] = 32'b0111_000111_001010_001100_0000000000; //sub x7, x10, x12
//assign instr[15] = 32'b1011_000000_010110_000000_0000000000; //BRN x22 module alu
assign instr[15] = 32'b00000000000000000000000000000000; //NOP
assign instr[16] = 32'b00000000000000000000000000000000; //NOP
assign instr[17] = 32'b0000000000000000000000000000000; //NOP
assign instr[18] = 32'b0000000000000000000000000000000; //NOP


assign instr[19] = 32'b0101_001001_001001_000000_0000000001; //INC x9, x9, 1
assign instr[20] = 32'b00000000000000000000000000000000; //nop
assign instr[21] = 32'b00000000000000000000000000000000; //nop
assign instr[22] = 32'b0111_011000_001001_010100_0000000000; //sub x24, x9, x20
assign instr[23] = 32'b1011_000000_010101_000000_0000000000; //brn x21 instr[11]

assign instr[24] = 32'b00000000000000000000000000000000; //nop
assign instr[25] = 32'b00000000000000000000000000000000; //nop
//assign instr[26] = 32'b00000000000000000000000000000000; //nop
assign instr[26] = 32'b0100_001010_001011_001100_0000000000; //add x10, x11, x12
assign instr[27] = 32'b1000_000000_001011_000000_0000000000; //jump x11 instr[0]
assign instr[28] = 32'b00000000000000000000000000000000; //nop
assign instr[29] = 32'b00000000000000000000000000000000; //nop
assign instr[30] = 32'b00000000000000000000000000000000; //nop


assign instr[31] = 32'b0100_001010_001011_001100_0000000000; //add x10, x11, x12
assign instr[32] = 32'b1000_000000_010101_000000_0000000000; //jump x21 instr[11]
assign instr[33] = 32'b00000000000000000000000000000000;
assign instr[34] = 32'b00000000000000000000000000000000;
assign instr[35] = 32'b00000000000000000000000000000000;
assign instr[36] = 32'b00000000000000000000000000000000;
*/

always @(posedge clk)

begin
    instrOut = instr[address];
end

endmodule
