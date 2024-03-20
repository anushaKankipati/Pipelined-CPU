`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 02:03:58 PM
// Design Name: 
// Module Name: control
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
module control(
    input [3:0] opcode, // Opcode from instruction
    input clk,
    output reg regWrt, aluSrc, memToReg, memRead, memWrite, branchz, pcToReg, jump, branchn, 
    output reg [3:0] aluOp // 4-bit ALU operation control
    );

// Define operation codes (example)

localparam NOP    = 4'b0000,
           SVPC   = 4'b1111,
           LD     = 4'b1110,
           ST     = 4'b0011,
           ADD    = 4'b0100,
           INC    = 4'b0101,
           NEG    = 4'b0110,
           SUB    = 4'b0111,
           J      = 4'b1000,
           BRZ    = 4'b1001,
           BRN    = 4'b1011;
          
//Generate control signals based on opcode
always@(opcode) 
begin
    case (opcode)
        NOP: begin
            regWrt = 0; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0100; aluSrc=0; branchn = 0;
        end
        SVPC: begin
            regWrt = 1; memToReg = 0; pcToReg = 1; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0100; aluSrc=1; branchn = 0;
        end
        LD: begin
            regWrt = 1; memToReg = 1; pcToReg = 0; branchz = 0; memRead=1;
            jump = 0; memWrite = 0; aluOp = 4'b0100; aluSrc=0; branchn = 0;
        end
        ST: begin
            regWrt = 0; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 1; aluOp = 4'b0100; aluSrc=0; branchn = 0;
        end
        ADD: begin
            regWrt = 1; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0000; aluSrc=0; branchn = 0;
        end
        INC: begin
            regWrt = 1; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0101; aluSrc=1; branchn = 0;
        end
        NEG: begin
            regWrt = 1; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0010; aluSrc=0; branchn = 0;
        end
        SUB: begin
            regWrt = 1; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0111; aluSrc=0; branchn = 0;
        end
        J: begin
            regWrt = 0; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 1; memWrite = 0; aluOp = 4'b0100; aluSrc=0; branchn = 0;
        end
        BRZ: begin
            regWrt = 0; memToReg = 0; pcToReg = 0; branchz = 1; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0100; aluSrc=0; branchn = 0;
        end
        BRN: begin
            regWrt = 0; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0100; aluSrc=0; branchn = 1;
        end
        default: begin //Default case
            regWrt = 0; memToReg = 0; pcToReg = 0; branchz = 0; memRead=0;
            jump = 0; memWrite = 0; aluOp = 4'b0100; aluSrc=0; branchn = 0;
        end
    endcase
end


endmodule
