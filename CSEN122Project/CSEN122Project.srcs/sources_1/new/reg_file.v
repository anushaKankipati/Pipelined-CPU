`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2024 06:34:09 PM
// Design Name: 
// Module Name: reg_file
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
/*
module reg_file(
    input clk,
    input reset,
    input [5:0] readReg1, readReg2, writeReg, //Register numbers
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

initial
    begin
    registers[8]=12;
    registers[10]=10;
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
*/
module reg_file(clock, rs, rt, rd, dataIn, write, rsOut, rtOut);
	reg[31:0]registers[63:0];
	input [5:0] rs;
	input [5:0] rt;
	input [5:0] rd;
	input [31:0] dataIn;
	input clock, write;
	output reg [31:0] rsOut;
	output reg [31:0] rtOut;
	
	/*
	initial
    begin
        registers[8]=1;
        registers[9]=2;
        registers[20]=7;
        registers[21]=11;
        registers[22]=31;
        registers[23]=33;
    end 
    */
	
	always@(posedge clock)
	
	begin
	    //if (write==0) begin
		  rsOut = registers[rs];
		  rtOut = registers[rt];
		//end
		if (write==1) 
			registers[rd] = dataIn;
	end
endmodule
	
