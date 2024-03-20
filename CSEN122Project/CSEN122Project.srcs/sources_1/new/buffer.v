`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 01:55:15 PM
// Design Name: 
// Module Name: buffer
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
module ifid_buffer(clk, instIn, pcIn, instOut, pcOut);
    input clk;
    input [31:0] instIn;
    input [31:0] pcIn;

    output reg [31:0] instOut;
    output reg [31:0] pcOut;
   
    always @(negedge clk)
        begin
            instOut = instIn;
            pcOut = pcIn;
         end
endmodule

module idex_buffer(clk, rdAddrIn, rsDataIn, rtDataIn, pcIn, regWriteIn, memToRegIn, aluOpIn, memReadIn, 
                   memWriteIn, pcToRegIn, aluSrcIn, immIn,
                   rdAddrOut, rsDataOut, rtDataOut, pcOut, regWriteOut, memToRegOut, aluOpOut, memReadOut,
                   memWriteOut, pcToRegOut, aluSrcOut, immOut);
    input clk, regWriteIn, memToRegIn, memReadIn, memWriteIn, pcToRegIn, aluSrcIn;
    input [31:0] rsDataIn;
    input [31:0] rtDataIn; 
    input [31:0] pcIn; 
    input [31:0] immIn;
    input [5:0] rdAddrIn;
    input [3:0] aluOpIn;
    
    output reg regWriteOut, memToRegOut, memReadOut, memWriteOut, pcToRegOut, aluSrcOut; 
    output reg [31:0] rsDataOut;
    output reg [31:0] rtDataOut;
    output reg [31:0] immOut;
    output reg [31:0] pcOut;
    output reg [5:0] rdAddrOut;
    output reg [3:0] aluOpOut;
   
    always @(negedge clk)
        begin
            regWriteOut = regWriteIn;
            memToRegOut = memToRegIn;
            memReadOut = memReadIn; 
            memWriteOut = memWriteIn;
            pcToRegOut = pcToRegIn;
            aluSrcOut = aluSrcIn;
            
            rsDataOut = rsDataIn;
            rtDataOut = rtDataIn;
            rdAddrOut = rdAddrIn;
            immOut = immIn;
            pcOut=pcIn;
            aluOpOut=aluOpIn;
         end
endmodule

module exwb_buffer(clk, dataIn, aluIn, regWriteIn, memToRegIn, rdAddrIn,
                   dataOut, aluOut, regWriteOut, memToRegOut, rdAddrOut);
    input clk, regWriteIn, memToRegIn;
    input [31:0] dataIn;
    input [31:0] aluIn;
    input [5:0] rdAddrIn;
   
    output reg regWriteOut, memToRegOut;
    output reg [31:0] dataOut;
    output reg [31:0] aluOut;
    output reg [5:0] rdAddrOut;
   
     always @(negedge clk)
        begin
            dataOut = dataIn;
            aluOut = aluIn;
            regWriteOut = regWriteIn;
            memToRegOut = memToRegIn;
            rdAddrOut = rdAddrIn;
         end
endmodule