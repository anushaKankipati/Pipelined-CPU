`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 01:31:41 PM
// Design Name: 
// Module Name: program_counter
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
module program_counter(PCin, PCout, clk);
    input [31:0] PCin;
    input clk;
    output reg [31:0] PCout;
    
    initial
    begin
        PCout = 0;
    end
    
    always@ (negedge clk)
    begin
        if(PCin !=0)
            PCout = PCin;
    end
endmodule
