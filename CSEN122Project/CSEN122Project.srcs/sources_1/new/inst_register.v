`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 02:01:57 PM
// Design Name: 
// Module Name: inst_register
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
module inst_register(
    input clk,
    input reset,
    input [4:0] readReg1, readReg2, writeReg, //Register numbers
    input [31:0] writeData, // Data to write
    input regWrite, // Write enable signal
    output [31:0] readData1, readData2 //Data outputs
);

//Define 32 registers of 32 bits each
reg [31:0] registers[31:0];

//Initialize registers to 0 on reset
integer i;
always @(posedge reset) begin
    for (i = 0; i < 32; i = i + 1) begin
        registers[i] <= 32'b0;
    end
end

// Read operations (combinational logic)
assign readData1 = registers[readReg1];
assign readData2 = registers[readReg2];

// Write operation (sequential logic, on positive clock edge)
always @(posedge clk) begin
    if (regWrite && (writeReg != 5'b0)) begin //Prevent writing to register 0
        registers[writeReg] <= writeData;
    end
end

endmodule